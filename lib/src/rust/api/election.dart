// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.9.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide protected;
part 'election.freezed.dart';

// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `clone`, `clone`, `fmt`, `fmt`

Future<int> getOrchardHeight() =>
    RustLib.instance.api.crateApiElectionGetOrchardHeight();

Future<int> getLatestHeight({required String lwd}) =>
    RustLib.instance.api.crateApiElectionGetLatestHeight(lwd: lwd);

Stream<CreateElectionResult> createElection(
        {required String name,
        required int start,
        required int end,
        required String question,
        required String answers,
        required String lwd}) =>
    RustLib.instance.api.crateApiElectionCreateElection(
        name: name,
        start: start,
        end: end,
        question: question,
        answers: answers,
        lwd: lwd);

Future<void> createDirectoryDb({required String directory}) =>
    RustLib.instance.api
        .crateApiElectionCreateDirectoryDb(directory: directory);

Future<String> connectElection(
        {required String url, required String lwd, required String seed}) =>
    RustLib.instance.api
        .crateApiElectionConnectElection(url: url, lwd: lwd, seed: seed);

Future<void> removeElection({required String hash}) =>
    RustLib.instance.api.crateApiElectionRemoveElection(hash: hash);

Future<List<ElectionRec>> listElections() =>
    RustLib.instance.api.crateApiElectionListElections();

Future<ElectionData> getElection({required String hash}) =>
    RustLib.instance.api.crateApiElectionGetElection(hash: hash);

Future<String> getVotingAddress({required String hash}) =>
    RustLib.instance.api.crateApiElectionGetVotingAddress(hash: hash);

Future<String> voteElection(
        {required String hash,
        required String address,
        required BigInt amount,
        int? choice}) =>
    RustLib.instance.api.crateApiElectionVoteElection(
        hash: hash, address: address, amount: amount, choice: choice);

bool isValidSeed({required String seed}) =>
    RustLib.instance.api.crateApiElectionIsValidSeed(seed: seed);

bool isValidAddress({required String address}) =>
    RustLib.instance.api.crateApiElectionIsValidAddress(address: address);

Future<bool> isRefdataLoaded({required String hash}) =>
    RustLib.instance.api.crateApiElectionIsRefdataLoaded(hash: hash);

Stream<int> electionSynchronize({required String hash}) =>
    RustLib.instance.api.crateApiElectionElectionSynchronize(hash: hash);

Future<bool> isBallotSynced({required String hash}) =>
    RustLib.instance.api.crateApiElectionIsBallotSynced(hash: hash);

Future<void> ballotSync({required String hash}) =>
    RustLib.instance.api.crateApiElectionBallotSync(hash: hash);

Future<BigInt> votesAvailable({required String hash}) =>
    RustLib.instance.api.crateApiElectionVotesAvailable(hash: hash);

Future<List<VoteRec>> listVotes({required String hash}) =>
    RustLib.instance.api.crateApiElectionListVotes(hash: hash);

@freezed
class Answer with _$Answer {
  const factory Answer({
    required String address,
    required String value,
  }) = _Answer;
}

@freezed
sealed class CreateElectionResult with _$CreateElectionResult {
  const CreateElectionResult._();

  const factory CreateElectionResult.progress({
    required int height,
  }) = CreateElectionResult_Progress;
  const factory CreateElectionResult.message({
    required String message,
  }) = CreateElectionResult_Message;
  const factory CreateElectionResult.result({
    required String hash,
    required String phrase,
    required String electionString,
  }) = CreateElectionResult_Result;
}

@freezed
class ElectionData with _$ElectionData {
  const factory ElectionData({
    required String name,
    required int startHeight,
    required int endHeight,
    required String question,
    required List<Answer> answers,
  }) = _ElectionData;
}

@freezed
class ElectionRec with _$ElectionRec {
  const factory ElectionRec({
    required PlatformInt64 id,
    required String hash,
    required String name,
    required String question,
  }) = _ElectionRec;
}

@freezed
class VoteRec with _$VoteRec {
  const factory VoteRec({
    required int id,
    required String hash,
    required String address,
    required BigInt amount,
    int? choice,
  }) = _VoteRec;
}
