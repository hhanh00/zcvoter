use anyhow::Result;
use bip39::Mnemonic;
use orchard::{keys::{FullViewingKey, SpendingKey}, vote::{Circuit, ProvingKey, VerifyingKey}};
use rand_core::OsRng;
use sqlx::SqlitePool;
use std::sync::mpsc::Sender;
use tokio::sync::Mutex;
use tracing::{info, span, Level};
use zcash_primitives::zip32::AccountId;
use zcash_protocol::consensus::NetworkConstants;
use zcash_vote::{address::VoteAddress, db::{list_notes, load_prop}, download::download_reference_data, election::Election, trees::{list_cmxs, list_nf_ranges}};

use crate::NETWORK;

pub async fn connect_election(
    connection: &SqlitePool,
    url: &str,
    lwd: &str,
    seed: &str,
) -> Result<String> {
    let rep = reqwest::get(url).await?.error_for_status()?;

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
    .execute(connection)
    .await?;

    let connection = crate::api::get_election_connection(&election.id()).await?;

    zcash_vote::db::create_schema(&connection).await?;
    zcash_vote::db::store_prop(&connection, "lwd", lwd).await?;
    zcash_vote::db::store_prop(&connection, "url", url).await?;
    zcash_vote::db::store_prop(
        &connection,
        "election",
        &serde_json::to_string(&election).expect("election json"),
    )
    .await?;
    zcash_vote::db::store_prop(&connection, "key", seed).await?;

    Ok(election.id())
}

pub async fn synchronize(connection: &SqlitePool, tx_progress: Sender<u32>) -> Result<()> {
    if let Ok(_guard) = SYNC_MUTEX.try_lock() {
        let election = get_election(connection).await?;
        let fvk = get_fvk(connection).await?;
        let lwd_url = load_prop(connection, "lwd").await?.expect("lwd");
        trim_data(connection).await?;
        download_reference_data(connection, 0, &election, Some(fvk), &lwd_url, move |h| {
            info!("Progress: {}", h);
            tx_progress.send(h).expect("send progress");
        })
        .await?;
    }
    Ok(())
}

pub async fn get_election(connection: &SqlitePool) -> Result<Election> {
    let election_string = load_prop(&connection, "election").await?.expect("election");
    let election: Election = serde_json::from_str(&election_string)?;
    Ok(election)
}

pub async fn get_sk(connection: &SqlitePool) -> Result<SpendingKey> {
    let key = load_prop(&connection, "key").await?.expect("election");
    let mnemonic = Mnemonic::parse(&key)?;
    let seed = mnemonic.to_seed("");
    let sk = SpendingKey::from_zip32_seed(&seed, NETWORK.coin_type(), AccountId::ZERO)
        .expect("derive sk");
    Ok(sk)
}

pub async fn get_fvk(connection: &SqlitePool) -> Result<FullViewingKey> {
    let sk = get_sk(connection).await?;
    let fvk = FullViewingKey::from(&sk);
    Ok(fvk)
}

pub async fn trim_data(connection: &SqlitePool) -> Result<()> {
    sqlx::query("DELETE FROM ballots")
        .execute(connection)
        .await?;
    sqlx::query("DELETE FROM cmx_frontiers")
        .execute(connection)
        .await?;
    sqlx::query("DELETE FROM cmx_roots")
        .execute(connection)
        .await?;
    sqlx::query("DELETE FROM cmxs").execute(connection).await?;
    sqlx::query("DELETE FROM nfs").execute(connection).await?;
    sqlx::query("DELETE FROM dnfs").execute(connection).await?;
    sqlx::query("DELETE FROM notes").execute(connection).await?;

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

pub async fn vote_election(connection: &SqlitePool, address: &str, amount: u64) -> Result<String> {
    let span = span!(Level::INFO, "vote");
    info!("Vote election: {} {}", address, amount);
    let vaddress = VoteAddress::decode(address)?;

    span.in_scope(|| {
        info!("Preparing proving keys");
    });

    let election = get_election(connection).await?;
    let sk = get_sk(connection).await?;
    let fvk = get_fvk(connection).await?;
    let notes = list_notes(connection, 0, &fvk).await?;
    let cmxs = list_cmxs(&connection).await?;
    let nfs = list_nf_ranges(&connection).await?;
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
    let ballot_hash = ballot.data.sighash()?;
    Ok(hex::encode(&ballot_hash))
}

lazy_static::lazy_static! {
    pub static ref SYNC_MUTEX: Mutex<()> = Mutex::new(());
    pub static ref BALLOT_PK: ProvingKey<Circuit> = ProvingKey::build();
    pub static ref BALLOT_VK: VerifyingKey<Circuit> = VerifyingKey::build();
}
