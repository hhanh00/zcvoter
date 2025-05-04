import 'package:mobx/mobx.dart';
import 'package:zcvoter/src/rust/api/election.dart';

part 'store.g.dart';

AppStore appStore = AppStore();

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  ElectionData? election;

  loadElectionData(String id) async {
    election = await getElection(hash: id);
  }
}
