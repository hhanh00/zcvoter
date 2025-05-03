use anyhow::Result;
use sqlx::SqlitePool;
use zcash_vote::election::Election;

pub async fn connect_election(connection: &SqlitePool, url: &str) -> Result<()> {
    let rep = reqwest::get(url).await?.error_for_status()?;

    let election: Election = rep.json().await?;
    tracing::debug!("Election: {:?}", election);

    sqlx::query(
        r#"
        INSERT INTO elections (hash, name, question)
        VALUES ($1, $2, $3)
        ON CONFLICT(hash) DO NOTHING;
        "#,
    )
    .bind(election.id())
    .bind(election.name)
    .bind(election.question)
    .execute(connection)
    .await?;

    Ok(())
}

