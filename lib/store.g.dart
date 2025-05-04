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

  late final _$synchronizeAsyncAction =
      AsyncAction('AppStoreBase.synchronize', context: context);

  @override
  Future<void> synchronize() {
    return _$synchronizeAsyncAction.run(() => super.synchronize());
  }

  @override
  String toString() {
    return '''
id: ${id},
election: ${election},
height: ${height}
    ''';
  }
}
