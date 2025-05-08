use std::{str::FromStr, sync::mpsc::channel};

use anyhow::Result;
use bip39::Mnemonic;
use flutter_rust_bridge::frb;
use orchard::{keys::{FullViewingKey, Scope, SpendingKey}, vote::OrchardHash};
use sqlx::{
    sqlite::{SqliteConnectOptions, SqliteRow},
    Row, SqlitePool,
};
use tonic::transport::Endpoint;
use zcash_primitives::zip32::AccountId;
use zcash_protocol::consensus::{Network, Parameters};
use zcash_vote::{
    address::VoteAddress, db::load_prop, download::download_reference_data, election::{CandidateChoice, Election}, rpc::{compact_tx_streamer_client::CompactTxStreamerClient, ChainSpec}, trees::{compute_cmx_root, compute_nf_root}
};

use crate::frb_generated::StreamSink;

use super::{get_directory_connection, get_pool};

#[frb]
pub async fn get_orchard_height() -> Result<u32> {
    let n: u32 = Network::MainNetwork
        .activation_height(zcash_protocol::consensus::NetworkUpgrade::Nu5)
        .unwrap()
        .into();
    Ok(n)
}

#[frb]
pub async fn get_latest_height(lwd: &str) -> Result<u32> {
    let ep = Endpoint::from_shared(lwd.to_string())?;
    let mut client = CompactTxStreamerClient::connect(ep).await?;
    let block_id = client
        .get_latest_block(tonic::Request::new(ChainSpec {}))
        .await?
        .into_inner();
    Ok(block_id.height as u32)
}

#[frb]
pub async fn create_election(
    progress: StreamSink<CreateElectionResult>,
    name: &str,
    start: u32,
    end: u32,
    question: &str,
    answers: &str,
    lwd: &str,
) -> Result<()> {
    let options = SqliteConnectOptions::new().in_memory(true);
    let pool = SqlitePool::connect_with(options).await?;
    let mut connection = pool.acquire().await?;
    zcash_vote::db::create_schema(&mut connection).await?;

    let mnemonic = Mnemonic::generate_in(bip39::Language::English, 24)?;
    let phrase = mnemonic.to_string();
    let seed = mnemonic.to_seed("vote");
    let candidates = answers
        .trim()
        .split("\n")
        .enumerate()
        .map(|(i, choice)| {
            let spk = SpendingKey::from_zip32_seed(&seed, 133, AccountId::try_from(i as u32).unwrap()).unwrap();
            let fvk = FullViewingKey::from(&spk);
            let address = fvk.address_at(0u64, Scope::External);
            let vote_address = VoteAddress(address);

            CandidateChoice {
                address: vote_address.to_string(),
                choice: choice.to_string(),
            }
        })
        .collect::<Vec<_>>();

    let mut election = Election {
        name: name.to_string(),
        start_height: start,
        end_height: end,
        question: question.to_string(),
        candidates,
        signature_required: true,
        cmx: OrchardHash::default(),
        nf: OrchardHash::default(),
        cmx_frontier: None,
    };

    let prg = progress.clone();
    download_reference_data(&mut connection, 0, &election, None, lwd, move |h| {
        if h % 1000 == 0 || h == end {
            prg.add(CreateElectionResult::Progress { height: h }).expect("progress sink");
        }
    }).await?;

    progress.add(CreateElectionResult::Message { message: "Computing nullifiers".to_string() }).expect("progress sink");
    let nf_root = compute_nf_root(&mut connection).await?;
    progress.add(CreateElectionResult::Message { message: "Computing note commitments".to_string() }).expect("progress sink");
    let (cmx_root, frontier) = compute_cmx_root(&mut connection).await?;

    election.nf = nf_root;
    election.cmx = cmx_root;
    election.cmx_frontier = frontier;

    let hash = election.id();

    let election_string = serde_json::to_string(&election)?;
    progress.add(CreateElectionResult::Result {
        hash,
        phrase: phrase.clone(),
        election_string: election_string.clone(),
    }).expect("progress sink");
    Ok(())
}

#[frb]
#[derive(Debug, Clone)]
pub enum CreateElectionResult {
    Progress {
        height: u32,
    },
    Message {
        message: String,
    },
    Result {
        hash: String,
        phrase: String,
        election_string: String,
    },
}

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
pub async fn remove_election(hash: &str) -> Result<()> {
    let directory = get_directory_connection().await?;
    crate::election::remove_election(&directory, hash).await
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
    let mut connection = get_pool(hash).await?.acquire().await?;
    let election_string = load_prop(&mut connection, "election")
        .await?
        .expect("election");
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

#[frb]
pub async fn get_voting_address(hash: &str) -> Result<String> {
    let mut connection = get_pool(hash).await?.acquire().await?;
    let fvk = crate::election::get_fvk(&mut connection).await?;
    let address = fvk.address_at(0u64, Scope::External);
    let vote_address = VoteAddress(address);
    Ok(vote_address.encode())
}

#[frb]
pub async fn vote_election(
    hash: &str,
    address: &str,
    amount: u64,
    choice: Option<u32>,
) -> Result<String> {
    let connection = get_pool(hash).await?;
    crate::election::vote_election(&connection, address, amount, choice).await
}

#[frb(sync)]
pub fn is_valid_seed(seed: &str) -> bool {
    Mnemonic::from_str(seed).is_ok()
}

#[frb(sync)]
pub fn is_valid_address(address: &str) -> bool {
    VoteAddress::decode(address).is_ok()
}

#[frb]
pub async fn is_refdata_loaded(hash: &str) -> Result<bool> {
    let mut connection = get_pool(hash).await?.acquire().await?;
    let election = crate::election::get_election(&mut connection).await?;
    let end_height = election.end_height;
    let sync_height = load_prop(&mut connection, "height").await?;
    if let Some(sync_height) = sync_height {
        let sync_height = u32::from_str(&sync_height).expect("sync height");
        Ok(end_height == sync_height)
    } else {
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
    let connection = get_pool(hash).await?;
    crate::election::synchronize(&connection, tx_progress).await
}

#[frb]
pub async fn is_ballot_synced(hash: &str) -> Result<bool> {
    let connection = get_pool(hash).await?;
    let (c, n) = crate::sync::ballot_sync_status(&connection).await?;
    Ok(c == n)
}

#[frb]
pub async fn ballot_sync(hash: &str) -> Result<()> {
    let connection = get_pool(hash).await?;
    crate::sync::ballot_sync(&connection).await
}

#[frb]
pub async fn votes_available(hash: &str) -> Result<u64> {
    let connection = get_pool(hash).await?;
    let n = crate::election::votes_available(&connection).await?;
    Ok(n)
}

#[frb]
pub async fn list_votes(hash: &str) -> Result<Vec<VoteRec>> {
    let connection = get_pool(hash).await?;
    let votes = crate::election::list_votes(&connection).await?;
    Ok(votes)
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

#[frb(dart_metadata = ("freezed"))]
pub struct VoteRec {
    pub id: u32,
    pub hash: String,
    pub address: String,
    pub amount: u64,
    pub choice: Option<u32>,
}
