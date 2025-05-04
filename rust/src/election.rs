use anyhow::Result;
use sqlx::SqlitePool;
use zcash_vote::election::Election;

pub async fn connect_election(connection: &SqlitePool, url: &str, seed: &str) -> Result<String> {
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
    zcash_vote::db::store_prop(&connection, "url", url).await?;
    zcash_vote::db::store_prop(&connection, "election", &serde_json::to_string(&election).expect("election json")).await?;
    zcash_vote::db::store_prop(&connection, "key", seed).await?;

    Ok(election.id())
}

