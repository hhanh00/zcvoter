// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on AppStoreBase, Store {
  late final _$idAtom = Atom(name: 'AppStoreBase.id', context: context);

  @override
  String? get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String? value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  late final _$electionAtom =
      Atom(name: 'AppStoreBase.election', context: context);

  @override
  ElectionData? get election {
    _$electionAtom.reportRead();
    return super.election;
  }

  @override
  set election(ElectionData? value) {
    _$electionAtom.reportWrite(value, super.election, () {
      super.election = value;
    });
  }

  late final _$refDataLoadedAtom =
      Atom(name: 'AppStoreBase.refDataLoaded', context: context);

  @override
  bool get refDataLoaded {
    _$refDataLoadedAtom.reportRead();
    return super.refDataLoaded;
  }

  @override
  set refDataLoaded(bool value) {
    _$refDataLoadedAtom.reportWrite(value, super.refDataLoaded, () {
      super.refDataLoaded = value;
    });
  }

  late final _$heightAtom = Atom(name: 'AppStoreBase.height', context: context);

  @override
  int? get height {
    _$heightAtom.reportRead();
    return super.height;
  }

  @override
  set height(int? value) {
    _$heightAtom.reportWrite(value, super.height, () {
      super.height = value;
    });
  }

  late final _$availableVotesAtom =
      Atom(name: 'AppStoreBase.availableVotes', context: context);

  @override
  int get availableVotes {
    _$availableVotesAtom.reportRead();
    return super.availableVotes;
  }

  @override
  set availableVotes(int value) {
    _$availableVotesAtom.reportWrite(value, super.availableVotes, () {
      super.availableVotes = value;
    });
  }

  late final _$votesAtom = Atom(name: 'AppStoreBase.votes', context: context);

  @override
  ObservableList<VoteRec> get votes {
    _$votesAtom.reportRead();
    return super.votes;
  }

  @override
  set votes(ObservableList<VoteRec> value) {
    _$votesAtom.reportWrite(value, super.votes, () {
      super.votes = value;
    });
  }

  late final _$loadElectionDataAsyncAction =
      AsyncAction('AppStoreBase.loadElectionData', context: context);

  @override
  Future<void> loadElectionData(String id) {
    return _$loadElectionDataAsyncAction.run(() => super.loadElectionData(id));
  }

  late final _$_refDataSynchronizeAsyncAction =
      AsyncAction('AppStoreBase._refDataSynchronize', context: context);

  @override
  Future<void> _refDataSynchronize() {
    return _$_refDataSynchronizeAsyncAction
        .run(() => super._refDataSynchronize());
  }

  late final _$_ballotSynchronizeAsyncAction =
      AsyncAction('AppStoreBase._ballotSynchronize', context: context);

  @override
  Future<void> _ballotSynchronize() {
    return _$_ballotSynchronizeAsyncAction
        .run(() => super._ballotSynchronize());
  }

  late final _$synchronizeAsyncAction =
      AsyncAction('AppStoreBase.synchronize', context: context);

  @override
  Future<void> synchronize() {
    return _$synchronizeAsyncAction.run(() => super.synchronize());
  }

  late final _$startAutoSyncAsyncAction =
      AsyncAction('AppStoreBase.startAutoSync', context: context);

  @override
  Future<void> startAutoSync() {
    return _$startAutoSyncAsyncAction.run(() => super.startAutoSync());
  }

  late final _$cancelAutoSyncAsyncAction =
      AsyncAction('AppStoreBase.cancelAutoSync', context: context);

  @override
  Future<void> cancelAutoSync() {
    return _$cancelAutoSyncAsyncAction.run(() => super.cancelAutoSync());
  }

  late final _$updateAvailableVotesAsyncAction =
      AsyncAction('AppStoreBase.updateAvailableVotes', context: context);

  @override
  Future<void> updateAvailableVotes() {
    return _$updateAvailableVotesAsyncAction
        .run(() => super.updateAvailableVotes());
  }

  late final _$updateVoteHistoryAsyncAction =
      AsyncAction('AppStoreBase.updateVoteHistory', context: context);

  @override
  Future<void> updateVoteHistory() {
    return _$updateVoteHistoryAsyncAction.run(() => super.updateVoteHistory());
  }

  late final _$deleteElectionAsyncAction =
      AsyncAction('AppStoreBase.deleteElection', context: context);

  @override
  Future<void> deleteElection(String hash) {
    return _$deleteElectionAsyncAction.run(() => super.deleteElection(hash));
  }

  @override
  String toString() {
    return '''
id: ${id},
election: ${election},
refDataLoaded: ${refDataLoaded},
height: ${height},
availableVotes: ${availableVotes},
votes: ${votes}
    ''';
  }
}
