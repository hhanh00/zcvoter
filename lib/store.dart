import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:mobx/mobx.dart';
import 'package:toastification/toastification.dart';
import 'package:zcvoter/src/rust/api/election.dart';

part 'store.g.dart';

AppStore appStore = AppStore();

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  String? id;
  @observable
  ElectionData? election;
  @observable
  int? height;

  @action
  Future<void> loadElectionData(String id) async {
    if (election != null) return;
    this.id = id;
    election = await getElection(hash: id);
  }

  @action
  Future<void> refDataSynchronize() async {
    if (await isRefdataLoaded(hash: id!)) return;

    final syncProgress = electionSynchronize(hash: id!);
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
    }, onDone: () {
      toastification.dismissAll();
      toastification.show(
        title: Text("Synchronization"),
        description: Text("Download complete"),
      );
      height = null;
    });
  }

  @action
  Future<void> ballotSynchronize() async {
    if (await isBallotSynced(hash: id!)) return;

    await ballotSync(hash: id!);
    toastification.show(
      title: Text("Ballot Sync"),
      description: Text("Ballot sync complete"),
      autoCloseDuration: Durations.extralong1,
    );
  }

  bool synchronizing = false;
  int consecutiveErrors = 0;
  @action
  Future<void> synchronize() async {
    if (synchronizing) return;
    try {
      synchronizing = true;
      await refDataSynchronize();
      await ballotSynchronize();
      consecutiveErrors = 0;
    } on AnyhowException catch (e) {
      consecutiveErrors++;
      if (consecutiveErrors < 3)
        toastification.show(
          title: Text("Synchronization Error"),
          description: Text(e.message),
        );
    }
    finally {
      synchronizing = false;
    }
  }

  Timer? pollTimer;

  @action
  Future<void> startAutoSync() async {
    await synchronize();
    pollTimer = Timer.periodic(const Duration(seconds: 15), (timer) async {
      await synchronize();
    });
  }

  @action
  Future<void> cancelAutoSync() async {
    pollTimer?.cancel();
    pollTimer = null;
  }
}
