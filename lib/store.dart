import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:mobx/mobx.dart';
import 'package:toastification/toastification.dart';
import 'package:zcvoter/pages/home.dart';
import 'package:zcvoter/src/rust/api/election.dart';
import 'package:zcvoter/src/rust/api/init.dart';

part 'store.g.dart';

AppStore appStore = AppStore();

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  String? id;
  @observable
  ElectionData? election;
  @observable
  bool refDataLoaded = false;
  @observable
  int? height;
  @observable
  int availableVotes = 0;
  @observable
  ObservableList<VoteRec> votes = ObservableList.of([]);

  Future<void> init() async {
    final stream = setLogStream();
    stream.listen((m) {
      if (m.span == "vote") {
        toastification.show(
            description: Text(m.message),
            margin: EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(8),
            animationDuration: Durations.long1,
            autoCloseDuration: Duration(seconds: 3));
      }
    });
  }

  @action
  Future<void> loadElectionData(String id) async {
    if (election != null) return;
    this.id = id;
    election = await getElection(hash: id);
  }

  @action
  Future<void> _refDataSynchronize() async {
    refDataLoaded = await isRefdataLoaded(hash: id!);
    if (refDataLoaded) return;

    final syncProgress = electionSynchronize(hash: id!);
    final complete = Completer<void>();
    toastification.show(
      title: Text("Synchronization"),
      description: Text("Downloading blockchain data..."),
    );
    syncProgress.listen((h) {
      height = h;
    }, onError: (e) {
      toastification.show(
        title: Text("Synchronization"),
        description: Text("Error: $e"),
      );
      height = null;
      Future.delayed(const Duration(seconds: 10), synchronize);
      complete.completeError(e);
    }, onDone: () async {
      toastification.dismissAll();
      toastification.show(
        title: Text("Synchronization"),
        description: Text("Download complete"),
      );
      height = null;
      refDataLoaded = await isRefdataLoaded(hash: id!);
      complete.complete();
    });
    return complete.future;
  }

  @action
  Future<void> _ballotSynchronize() async {
    if (await isBallotSynced(hash: id!)) return;

    await ballotSync(hash: id!);
    await updateAvailableVotes();
    await updateVoteHistory();
    toastification.show(
      title: Text("Ballot Sync"),
      description: Text("Ballot sync complete"),
      autoCloseDuration: Durations.extralong1,
    );
  }

  bool synchronizing = false;
  @action
  Future<void> synchronize() async {
    if (synchronizing) return;
    try {
      synchronizing = true;
      await _refDataSynchronize();
      await _ballotSynchronize();
    } on AnyhowException catch (e) {
      toastification.show(
        title: Text("Synchronization Error. Retry in 1 minute"),
        description: Text(e.message),
      );
    } finally {
      synchronizing = false;
    }
  }

  Timer? pollTimer;

  @action
  Future<void> startAutoSync() async {
    await synchronize();
    pollTimer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      await synchronize();
    });
  }

  @action
  Future<void> cancelAutoSync() async {
    pollTimer?.cancel();
    pollTimer = null;
  }

  @action
  Future<void> updateAvailableVotes() async {
    final v = await votesAvailable(hash: appStore.id!);
    final votes = (v ~/ BigInt.from(ZatsPerVote)).toInt();
    availableVotes = votes;
  }

  @action
  Future<void> updateVoteHistory() async {
    final vs = await listVotes(hash: appStore.id!);
    votes = ObservableList.of(vs);
  }

  @action
  Future<void> deleteElection(String hash) async {
    await removeElection(hash: hash);
    election = null;
    id = null;
    refDataLoaded = false;
    height = null;
    availableVotes = 0;
    votes.clear();
  }
}
