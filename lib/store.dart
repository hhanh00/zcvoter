import 'package:mobx/mobx.dart';

part 'store.g.dart';

AppStore appStore = AppStore();

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
}
