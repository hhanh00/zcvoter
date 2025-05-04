use anyhow::Result;
use flutter_rust_bridge::frb;
use sqlx::{sqlite::SqliteRow, Row};
use zcash_vote::db::load_prop;

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

// #[frb]
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

#[frb(sync)]
pub fn is_valid_seed(seed: &str) -> bool {
    true
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
