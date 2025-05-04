// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on AppStoreBase, Store {
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

  @override
  String toString() {
    return '''
election: ${election}
    ''';
  }
}
