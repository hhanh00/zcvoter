use anyhow::Result;
use flutter_rust_bridge::frb;
use sqlx::{sqlite::SqliteRow, Row};

use super::get_directory_connection;

#[frb]
pub async fn create_directory_db(directory: &str) -> Result<()> {
    crate::directory::create_directory_db(directory).await
}

#[frb]
pub async fn connect_election(url: &str) -> Result<()> {
    let directory = get_directory_connection().await?;
    crate::election::connect_election(&directory, url).await
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

#[frb(dart_metadata = ("freezed"))]
#[derive(Debug, Clone)]
pub struct ElectionRec {
    pub id: i64,
    pub hash: String,
    pub name: String,
    pub question: String,
}
