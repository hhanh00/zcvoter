use anyhow::Result;
use bip39::Mnemonic;
use orchard::{keys::{FullViewingKey, SpendingKey}, vote::{Ballot, Circuit, ProvingKey, VerifyingKey}};
use rand_core::OsRng;
use reqwest::header::CONTENT_TYPE;
use sqlx::{sqlite::SqliteRow, SqliteConnection, SqlitePool, Row};
use std::sync::mpsc::Sender;
use tokio::sync::Mutex;
use tracing::{info, span, Level};
use zcash_primitives::zip32::AccountId;
use zcash_protocol::consensus::NetworkConstants;
use zcash_vote::{address::VoteAddress, db::{list_notes, load_prop}, download::download_reference_data, election::Election, trees::{list_cmxs, list_nf_ranges}};

use crate::{api::{election::VoteRec, get_election_path}, NETWORK};

pub async fn connect_election(
    connection: &SqlitePool,
    url: &str,
    lwd: &str,
    seed: &str,
) -> Result<String> {
    let rep = reqwest::get(url).await?.error_for_status()?;
    let mut connection = connection.acquire().await?;

    let election: Election = rep.json().await?;
    tracing::debug!("Election: {:?}", &election);

    sqlx::query(
        r#"
        INSERT INTO elections (hash, name, question)
        VALUES ($1, $2, $3)
        ON CONFLICT(hash) DO NOTHING;
        "#,
    )
    .bind(&election.id())
    .bind(&election.name)
    .bind(&election.question)
    .execute(&mut *connection)
    .await?;

    let connection = crate::api::get_election_connection(&election.id()).await?;
    let mut connection = connection.acquire().await?;

    zcash_vote::db::create_schema(&mut connection).await?;
    zcash_vote::db::store_prop(&mut connection, "lwd", lwd).await?;
    zcash_vote::db::store_prop(&mut connection, "url", url).await?;
    zcash_vote::db::store_prop(
        &mut connection,
        "election",
        &serde_json::to_string(&election).expect("election json"),
    )
    .await?;
    zcash_vote::db::store_prop(&mut connection, "key", seed).await?;

    sqlx::query(
        r#"CREATE TABLE IF NOT EXISTS votes(
        id_vote INTEGER PRIMARY KEY,
        hash BLOB NOT NULL,
        address TEXT NOT NULL,
        amount INTEGER NOT NULL,
        choice INTEGER,
        UNIQUE (hash))"#)
    .execute(&mut *connection).await?;

    Ok(election.id())
}

pub async fn remove_election(directory: &SqlitePool, hash: &str) -> Result<()> {
    let db_file_path = get_election_path(hash);
    std::fs::remove_file(&db_file_path).expect("remove file");
    sqlx::query("DELETE FROM elections WHERE hash = ?")
        .bind(hash)
        .execute(directory)
        .await?;
    Ok(())
}

pub async fn synchronize(pool: &SqlitePool, tx_progress: Sender<u32>) -> Result<()> {
    let mut connection = pool.acquire().await?;
    if let Ok(_guard) = SYNC_MUTEX.try_lock() {
        let election = get_election(&mut connection).await?;
        let fvk: FullViewingKey = get_fvk(&mut connection).await?;
        let lwd_url = load_prop(&mut connection, "lwd").await?.expect("lwd");
        trim_data(&mut connection).await?;
        download_reference_data(&mut connection, 0, &election, Some(fvk), &lwd_url, move |h| {
            info!("Progress: {}", h);
            tx_progress.send(h).expect("send progress");
        })
        .await?;
    }
    Ok(())
}

pub async fn get_election(connection: &mut SqliteConnection) -> Result<Election> {
    let election_string = load_prop(connection, "election").await?.expect("election");
    let election: Election = serde_json::from_str(&election_string)?;
    Ok(election)
}

pub async fn get_sk(connection: &mut SqliteConnection) -> Result<SpendingKey> {
    let key = load_prop(connection, "key").await?.expect("election");
    let mnemonic = Mnemonic::parse(&key)?;
    let seed = mnemonic.to_seed("");
    let sk = SpendingKey::from_zip32_seed(&seed, NETWORK.coin_type(), AccountId::ZERO)
        .expect("derive sk");
    Ok(sk)
}

pub async fn get_fvk(connection: &mut SqliteConnection) -> Result<FullViewingKey> {
    let sk = get_sk(connection).await?;
    let fvk = FullViewingKey::from(&sk);
    Ok(fvk)
}

pub async fn trim_data(connection: &mut SqliteConnection) -> Result<()> {
    sqlx::query("DELETE FROM ballots")
        .execute(&mut *connection)
        .await?;
    sqlx::query("DELETE FROM cmx_frontiers")
        .execute(&mut *connection)
        .await?;
    sqlx::query("DELETE FROM cmx_roots")
        .execute(&mut *connection)
        .await?;
    sqlx::query("DELETE FROM cmxs").execute(&mut *connection).await?;
    sqlx::query("DELETE FROM nfs").execute(&mut *connection).await?;
    sqlx::query("DELETE FROM dnfs").execute(&mut *connection).await?;
    sqlx::query("DELETE FROM notes").execute(&mut *connection).await?;

    Ok(())
}

pub async fn votes_available(connection: &SqlitePool) -> Result<u64> {
    let (votes,): (Option<u64>,) = sqlx::query_as(
        "SELECT SUM(value) FROM notes WHERE spent IS NULL",
    )
    .fetch_one(connection)
    .await?;
    Ok(votes.unwrap_or_default())
}

pub async fn vote_election(pool: &SqlitePool, address: &str, amount: u64, choice: Option<u32>) -> Result<String> {
    let span = span!(Level::INFO, "vote");
    info!("Vote election: {} {}", address, amount);
    let vaddress = VoteAddress::decode(address)?;

    span.in_scope(|| {
        info!("Preparing proving keys");
    });

    let mut connection = pool.acquire().await?;
    let election = get_election(&mut connection).await?;
    let sk = get_sk(&mut connection).await?;
    let fvk = get_fvk(&mut connection).await?;
    let notes = list_notes(&mut connection, 0, &fvk).await?;
    let cmxs = list_cmxs(&mut connection).await?;
    let nfs = list_nf_ranges(&mut connection).await?;
    let ballot = orchard::vote::vote(
        election.domain(),
        election.signature_required,
        Some(sk),
        &fvk,
        vaddress.0,
        amount,
        &notes,
        &nfs,
        &cmxs,
        &mut OsRng,
        &BALLOT_PK,
        &BALLOT_VK,
    )?;
    let ballot_hash = submit_ballot(pool, address, amount, choice, &ballot).await?;

    Ok(ballot_hash)
}

pub async fn submit_ballot(
    pool: &SqlitePool,
    address: &str,
    amount: u64,
    choice: Option<u32>,
    ballot: &Ballot,
) -> Result<String> {
    sqlx::query(
        r#"
        INSERT INTO votes (hash, address, amount, choice)
        VALUES (?, ?, ?, ?) ON CONFLICT(hash) DO NOTHING"#)
    .bind(ballot.data.sighash()?)
    .bind(address)
    .bind(amount as i64)
    .bind(choice)
    .execute(pool)
    .await?;

    let mut connection = pool.acquire().await?;
    let client = reqwest::Client::new();
    let base_url = load_prop(&mut connection, "url").await?.expect("Missing URL");
    let url = format!("{}/ballot", base_url);
    let rep = client
        .post(url)
        .header(CONTENT_TYPE, "application/json")
        .json(&ballot)
        .send()
        .await?;
    let rep = rep.error_for_status()?;
    let hash = rep.text().await?;

    Ok(hash)
}

pub async fn list_votes(pool: &SqlitePool) -> Result<Vec<VoteRec>> {
    let mut connection = pool.acquire().await?;
    let votes = sqlx::query(
        r#"
        SELECT id_vote, hash, address, amount, choice
        FROM votes
        ORDER BY id_vote DESC"#,
    )
    .map(|row: SqliteRow| {
        let id: u32 = row.get(0);
        let hash: Vec<u8> = row.get(1);
        let address: String = row.get(2);
        let amount: i64 = row.get(3);
        let choice: Option<u32> = row.get(4);
        VoteRec {
            id,
            hash: hex::encode(&hash),
            address,
            amount: amount as u64,
            choice,
        }
    })
    .fetch_all(&mut *connection)
    .await?;

    Ok(votes)
}

lazy_static::lazy_static! {
    pub static ref SYNC_MUTEX: Mutex<()> = Mutex::new(());
    pub static ref BALLOT_PK: ProvingKey<Circuit> = ProvingKey::build();
    pub static ref BALLOT_VK: VerifyingKey<Circuit> = VerifyingKey::build();
}
