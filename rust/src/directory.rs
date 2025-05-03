use anyhow::Result;
use sqlx::{sqlite::SqliteConnectOptions, SqlitePool};
use tracing::info;

use crate::api::DB_PATH;

pub async fn create_directory_db(directory: &str) -> Result<()> {
    {
        let mut db_path = DB_PATH.lock().unwrap();
        *db_path = directory.to_string();
    }

    let directory_db_path = format!("{}/directory.db", directory);
    info!("Creating directory database at {}", directory_db_path);

    let options = SqliteConnectOptions::new()
        .filename(directory_db_path)
        .create_if_missing(true);
    let pool = SqlitePool::connect_with(options).await?;
    sqlx::query(
        r#"
        CREATE TABLE IF NOT EXISTS elections (
            id INTEGER PRIMARY KEY,
            hash TEXT NOT NULL,
            name TEXT NOT NULL,
            question TEXT NOT NULL,
            balance INTEGER,
            UNIQUE(hash)
        );
        "#,
    )
    .execute(&pool)
    .await?;
    Ok(())
}
