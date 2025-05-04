use zcash_protocol::consensus::Network;

pub mod directory;
pub mod election;
pub mod api;
mod frb_generated;

pub const NETWORK: Network = Network::MainNetwork;

