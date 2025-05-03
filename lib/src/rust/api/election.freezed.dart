// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'election.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ElectionRec {
  int get id => throw _privateConstructorUsedError;
  String get hash => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;

  /// Create a copy of ElectionRec
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ElectionRecCopyWith<ElectionRec> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ElectionRecCopyWith<$Res> {
  factory $ElectionRecCopyWith(
          ElectionRec value, $Res Function(ElectionRec) then) =
      _$ElectionRecCopyWithImpl<$Res, ElectionRec>;
  @useResult
  $Res call({int id, String hash, String name, String question});
}

/// @nodoc
class _$ElectionRecCopyWithImpl<$Res, $Val extends ElectionRec>
    implements $ElectionRecCopyWith<$Res> {
  _$ElectionRecCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ElectionRec
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hash = null,
    Object? name = null,
    Object? question = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ElectionRecImplCopyWith<$Res>
    implements $ElectionRecCopyWith<$Res> {
  factory _$$ElectionRecImplCopyWith(
          _$ElectionRecImpl value, $Res Function(_$ElectionRecImpl) then) =
      __$$ElectionRecImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String hash, String name, String question});
}

/// @nodoc
class __$$ElectionRecImplCopyWithImpl<$Res>
    extends _$ElectionRecCopyWithImpl<$Res, _$ElectionRecImpl>
    implements _$$ElectionRecImplCopyWith<$Res> {
  __$$ElectionRecImplCopyWithImpl(
      _$ElectionRecImpl _value, $Res Function(_$ElectionRecImpl) _then)
      : super(_value, _then);

  /// Create a copy of ElectionRec
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hash = null,
    Object? name = null,
    Object? question = null,
  }) {
    return _then(_$ElectionRecImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ElectionRecImpl implements _ElectionRec {
  const _$ElectionRecImpl(
      {required this.id,
      required this.hash,
      required this.name,
      required this.question});

  @override
  final int id;
  @override
  final String hash;
  @override
  final String name;
  @override
  final String question;

  @override
  String toString() {
    return 'ElectionRec(id: $id, hash: $hash, name: $name, question: $question)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElectionRecImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.question, question) ||
                other.question == question));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, hash, name, question);

  /// Create a copy of ElectionRec
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ElectionRecImplCopyWith<_$ElectionRecImpl> get copyWith =>
      __$$ElectionRecImplCopyWithImpl<_$ElectionRecImpl>(this, _$identity);
}

abstract class _ElectionRec implements ElectionRec {
  const factory _ElectionRec(
      {required final int id,
      required final String hash,
      required final String name,
      required final String question}) = _$ElectionRecImpl;

  @override
  int get id;
  @override
  String get hash;
  @override
  String get name;
  @override
  String get question;

  /// Create a copy of ElectionRec
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ElectionRecImplCopyWith<_$ElectionRecImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
