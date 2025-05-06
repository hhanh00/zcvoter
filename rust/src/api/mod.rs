use std::sync::Mutex;

use anyhow::Result;
use sqlx::SqlitePool;

pub mod init;
pub mod election;

async fn get_pool(basename: &str) -> Result<SqlitePool> {
    let db_file_path = get_election_path(basename);
    let options = sqlx::sqlite::SqliteConnectOptions::new()
        .filename(db_file_path)
        .create_if_missing(true);
    let pool = SqlitePool::connect_with(options).await?;
    Ok(pool)
}

pub fn get_election_path(hash: &str) -> String {
    let db_path = {
        let db_path = DB_PATH.lock().unwrap();
        db_path.clone()
    };
    format!("{}/{}.db", db_path, hash)
}

pub(crate) async fn get_directory_connection() -> Result<SqlitePool> {
    get_pool("directory").await
}

pub(crate) async fn get_election_connection(hash: &str) -> Result<SqlitePool> {
    get_pool(hash).await
}

lazy_static::lazy_static! {
    pub static ref DB_PATH: Mutex<String> = Mutex::new(String::new());
}
