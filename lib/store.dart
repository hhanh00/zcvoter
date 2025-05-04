import 'package:flutter/material.dart';
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

  loadElectionData(String id) async {
    this.id = id;
    election = await getElection(hash: id);
  }

  @action
  Future<void> synchronize() async {
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
      toastification.show(
        title: Text("Synchronization"),
        description: Text("Download complete"),
      );
      height = null;
    });
  }
}
