use std::sync::Mutex;

use anyhow::Result;
use sqlx::SqlitePool;

pub mod init;
pub mod election;

pub(crate) async fn get_directory_connection() -> Result<SqlitePool> {
    let db_path = {
        let db_path = DB_PATH.lock().unwrap();
        db_path.clone()
    };
    let options = sqlx::sqlite::SqliteConnectOptions::new()
        .filename(format!("{}/directory.db", db_path));
    let pool = SqlitePool::connect_with(options).await?;
    Ok(pool)
}

lazy_static::lazy_static! {
    pub static ref DB_PATH: Mutex<String> = Mutex::new(String::new());
}
