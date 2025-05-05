use std::{str::FromStr, sync::mpsc::channel};

use anyhow::Result;
use bip39::Mnemonic;
use flutter_rust_bridge::frb;
use sqlx::{sqlite::SqliteRow, Row};
use zcash_vote::db::load_prop;

use crate::frb_generated::StreamSink;

use super::{get_connection, get_directory_connection};

#[frb]
pub async fn create_directory_db(directory: &str) -> Result<()> {
    crate::directory::create_directory_db(directory).await
}

#[frb]
pub async fn connect_election(url: &str, lwd: &str, seed: &str) -> Result<String> {
    let directory = get_directory_connection().await?;
    crate::election::connect_election(&directory, url, lwd, seed).await
}

#[frb]
pub async fn list_elections() -> Result<Vec<ElectionRec>> {
    let directory = get_directory_connection().await?;
    let elections = sqlx::query(
        r#"
        SELECT id, hash, name, question
        FROM elections
        ORDER BY name
        "#,
    )
    .map(|row: SqliteRow| ElectionRec {
        id: row.get(0),
        hash: row.get(1),
        name: row.get(2),
        question: row.get(3),
    })
    .fetch_all(&directory)
    .await?;
    Ok(elections)
}

#[frb]
pub async fn get_election(hash: &str) -> Result<ElectionData> {
    let connection = get_connection(hash).await?;
    let election_string = load_prop(&connection, "election").await?.expect("election");
    let election: zcash_vote::election::Election = serde_json::from_str(&election_string)?;
    let data = ElectionData {
        name: election.name,
        start_height: election.start_height,
        end_height: election.end_height,
        question: election.question,
        answers: election
            .candidates
            .iter()
            .map(|c| Answer {
                address: c.address.clone(),
                value: c.choice.clone(),
            })
            .collect(),
    };
    Ok(data)
}

pub async fn vote_election(hash: &str, address: &str, amount: u64) -> Result<String> {
    let connection = get_connection(hash).await?;
    crate::election::vote_election(&connection, address, amount).await
}

#[frb(sync)]
pub fn is_valid_seed(seed: &str) -> bool {
    Mnemonic::from_str(seed).is_ok()
}

#[frb]
pub async fn is_refdata_loaded(hash: &str) -> Result<bool> {
    let connection = get_connection(hash).await?;
    let election = crate::election::get_election(&connection).await?;
    let end_height = election.end_height;
    let sync_height = load_prop(&connection, "height").await?;
    if let Some(sync_height) = sync_height {
        let sync_height = u32::from_str(&sync_height).expect("sync height");
        Ok(end_height == sync_height)
    }
    else {
        Ok(false)
    }
}

#[frb]
pub async fn election_synchronize(progress: StreamSink<u32>, hash: &str) -> Result<()> {
    let (tx_progress, rx) = channel::<u32>();
    tokio::spawn(async move {
        while let Ok(v) = rx.recv() {
            progress.add(v).expect("progress sink");
        }
    });
    let connection = get_connection(hash).await?;
    crate::election::synchronize(
        &connection,
        tx_progress,
    ).await
}

#[frb]
pub async fn is_ballot_synced(hash: &str) -> Result<bool> {
    let connection = get_connection(hash).await?;
    let (c, n) = crate::sync::ballot_sync_status(&connection).await?;
    Ok(c == n)
}

#[frb]
pub async fn ballot_sync(hash: &str) -> Result<()> {
    let connection = get_connection(hash).await?;
    crate::sync::ballot_sync(&connection).await
}

#[frb]
pub async fn votes_available(hash: &str) -> Result<u64> {
    let connection = get_connection(hash).await?;
    let n = crate::election::votes_available(&connection).await?;
    Ok(n)
}

#[frb(dart_metadata = ("freezed"))]
#[derive(Debug, Clone)]
pub struct ElectionRec {
    pub id: i64,
    pub hash: String,
    pub name: String,
    pub question: String,
}

#[frb(dart_metadata = ("freezed"))]
pub struct Answer {
    pub address: String,
    pub value: String,
}

#[frb(dart_metadata = ("freezed"))]
pub struct ElectionData {
    pub name: String,
    pub start_height: u32,
    pub end_height: u32,
    pub question: String,
    pub answers: Vec<Answer>,
}
