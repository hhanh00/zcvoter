use anyhow::Result;
use orchard::{
    keys::{FullViewingKey, PreparedIncomingViewingKey, Scope},
    vote::{try_decrypt_ballot, Ballot},
};
use sqlx::{Acquire, SqliteConnection, SqlitePool};
use std::str::FromStr;
use tracing::info;
use zcash_vote::{
    db::{load_prop, store_cmx, store_note},
    election::Election,
};

use crate::election::{get_election, get_fvk};

pub async fn ballot_sync_status(connection: &SqlitePool) -> Result<(u32, u32)> {
    let base_url = load_prop(&connection, "url").await?.expect("Missing URL");
    let url = format!("{}/num_ballots", base_url);
    let n = reqwest::get(url).await?.text().await?;
    let n = u32::from_str(&n).expect("parse number of ballots");
    let (c,): (Option<u32>,) = sqlx::query_as(
        r#"
        SELECT COUNT(*) FROM ballots
        "#,
    )
    .fetch_one(connection)
    .await?;
    let c = c.unwrap_or_default();

    info!("Ballots: {} / {}", c, n);
    Ok((c, n))
}

pub async fn ballot_sync(connection: &SqlitePool) -> Result<()> {
    let base_url = load_prop(&connection, "url").await?.expect("Missing URL");
    let election = get_election(&connection).await?;
    let fvk = get_fvk(connection).await?;

    let (c, n) = ballot_sync_status(&connection).await?;

    if c < n {
        for i in c..n {
            info!("Ballot: #{}", i);
            let url = format!("{}/ballot/height/{}", base_url, i + 1);
            let ballot = reqwest::get(url).await?.text().await?;
            let ballot = serde_json::from_str::<Ballot>(&ballot)?;
            let mut transaction = connection.begin().await?;
            let c = transaction.acquire().await?;
            process_ballot(c, &election, i + 1, &ballot, &fvk).await?;

            let hash = ballot.data.sighash()?;
            let ballot = serde_json::to_string(&ballot)?;
            sqlx::query(
                "INSERT INTO ballots(election, height, hash, data)
                VALUES (0, ?, ?, ?)",
            )
            .bind(i + 1)
            .bind(&hash)
            .bind(&ballot)
            .execute(&mut *transaction)
            .await?;
            transaction.commit().await?;
        }
    }
    Ok(())
}

pub async fn process_ballot(
    connection: &mut SqliteConnection,
    election: &Election,
    height: u32,
    ballot: &Ballot,
    fvk: &FullViewingKey,
) -> Result<()> {
    for scope in 0..2 {
        let s = if scope == 0 {
            Scope::External
        } else {
            Scope::Internal
        };
        let ivk = fvk.to_ivk(s);
        let pivk = PreparedIncomingViewingKey::new(&ivk);

        let txid = ballot.data.sighash()?;

        for (i, action) in ballot.data.actions.iter().enumerate() {
            sqlx::query("UPDATE notes SET spent = ?1 WHERE dnf = ?2")
                .bind(height)
                .bind(&action.nf)
                .execute(&mut *connection)
                .await?;
            if let Some(note) = try_decrypt_ballot(&pivk, action)? {
                let (position,): (u32,) = sqlx::query_as("SELECT COUNT(*) FROM cmxs")
                    .fetch_one(&mut *connection)
                    .await?;

                store_note(
                    &mut *connection,
                    0,
                    election.domain(),
                    &fvk,
                    scope,
                    height,
                    position + i as u32,
                    &txid,
                    &note,
                )
                .await?;
            }
            if scope == 0 {
                store_cmx(&mut *connection, 0, &action.cmx).await?;
            }
        }
    }
    Ok(())
}
