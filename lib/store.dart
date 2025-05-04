import 'package:mobx/mobx.dart';
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
    final syncProgress = electionSynchronize(hash: id!);
    print("Syncing...");
    syncProgress.listen((h) {
      print("Sync progress: $h");
      height = h;
    }, onDone: () {
      print("Sync done");
      height = null;
    });
  }
}
