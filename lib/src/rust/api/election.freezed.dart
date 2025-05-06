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
mixin _$Answer {
  String get address => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  /// Create a copy of Answer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnswerCopyWith<Answer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnswerCopyWith<$Res> {
  factory $AnswerCopyWith(Answer value, $Res Function(Answer) then) =
      _$AnswerCopyWithImpl<$Res, Answer>;
  @useResult
  $Res call({String address, String value});
}

/// @nodoc
class _$AnswerCopyWithImpl<$Res, $Val extends Answer>
    implements $AnswerCopyWith<$Res> {
  _$AnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Answer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnswerImplCopyWith<$Res> implements $AnswerCopyWith<$Res> {
  factory _$$AnswerImplCopyWith(
          _$AnswerImpl value, $Res Function(_$AnswerImpl) then) =
      __$$AnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String address, String value});
}

/// @nodoc
class __$$AnswerImplCopyWithImpl<$Res>
    extends _$AnswerCopyWithImpl<$Res, _$AnswerImpl>
    implements _$$AnswerImplCopyWith<$Res> {
  __$$AnswerImplCopyWithImpl(
      _$AnswerImpl _value, $Res Function(_$AnswerImpl) _then)
      : super(_value, _then);

  /// Create a copy of Answer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? value = null,
  }) {
    return _then(_$AnswerImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AnswerImpl implements _Answer {
  const _$AnswerImpl({required this.address, required this.value});

  @override
  final String address;
  @override
  final String value;

  @override
  String toString() {
    return 'Answer(address: $address, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnswerImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address, value);

  /// Create a copy of Answer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnswerImplCopyWith<_$AnswerImpl> get copyWith =>
      __$$AnswerImplCopyWithImpl<_$AnswerImpl>(this, _$identity);
}

abstract class _Answer implements Answer {
  const factory _Answer(
      {required final String address,
      required final String value}) = _$AnswerImpl;

  @override
  String get address;
  @override
  String get value;

  /// Create a copy of Answer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnswerImplCopyWith<_$AnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ElectionData {
  String get name => throw _privateConstructorUsedError;
  int get startHeight => throw _privateConstructorUsedError;
  int get endHeight => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  List<Answer> get answers => throw _privateConstructorUsedError;

  /// Create a copy of ElectionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ElectionDataCopyWith<ElectionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ElectionDataCopyWith<$Res> {
  factory $ElectionDataCopyWith(
          ElectionData value, $Res Function(ElectionData) then) =
      _$ElectionDataCopyWithImpl<$Res, ElectionData>;
  @useResult
  $Res call(
      {String name,
      int startHeight,
      int endHeight,
      String question,
      List<Answer> answers});
}

/// @nodoc
class _$ElectionDataCopyWithImpl<$Res, $Val extends ElectionData>
    implements $ElectionDataCopyWith<$Res> {
  _$ElectionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ElectionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? startHeight = null,
    Object? endHeight = null,
    Object? question = null,
    Object? answers = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      startHeight: null == startHeight
          ? _value.startHeight
          : startHeight // ignore: cast_nullable_to_non_nullable
              as int,
      endHeight: null == endHeight
          ? _value.endHeight
          : endHeight // ignore: cast_nullable_to_non_nullable
              as int,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<Answer>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ElectionDataImplCopyWith<$Res>
    implements $ElectionDataCopyWith<$Res> {
  factory _$$ElectionDataImplCopyWith(
          _$ElectionDataImpl value, $Res Function(_$ElectionDataImpl) then) =
      __$$ElectionDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      int startHeight,
      int endHeight,
      String question,
      List<Answer> answers});
}

/// @nodoc
class __$$ElectionDataImplCopyWithImpl<$Res>
    extends _$ElectionDataCopyWithImpl<$Res, _$ElectionDataImpl>
    implements _$$ElectionDataImplCopyWith<$Res> {
  __$$ElectionDataImplCopyWithImpl(
      _$ElectionDataImpl _value, $Res Function(_$ElectionDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ElectionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? startHeight = null,
    Object? endHeight = null,
    Object? question = null,
    Object? answers = null,
  }) {
    return _then(_$ElectionDataImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      startHeight: null == startHeight
          ? _value.startHeight
          : startHeight // ignore: cast_nullable_to_non_nullable
              as int,
      endHeight: null == endHeight
          ? _value.endHeight
          : endHeight // ignore: cast_nullable_to_non_nullable
              as int,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<Answer>,
    ));
  }
}

/// @nodoc

class _$ElectionDataImpl implements _ElectionData {
  const _$ElectionDataImpl(
      {required this.name,
      required this.startHeight,
      required this.endHeight,
      required this.question,
      required final List<Answer> answers})
      : _answers = answers;

  @override
  final String name;
  @override
  final int startHeight;
  @override
  final int endHeight;
  @override
  final String question;
  final List<Answer> _answers;
  @override
  List<Answer> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  String toString() {
    return 'ElectionData(name: $name, startHeight: $startHeight, endHeight: $endHeight, question: $question, answers: $answers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElectionDataImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.startHeight, startHeight) ||
                other.startHeight == startHeight) &&
            (identical(other.endHeight, endHeight) ||
                other.endHeight == endHeight) &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._answers, _answers));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, startHeight, endHeight,
      question, const DeepCollectionEquality().hash(_answers));

  /// Create a copy of ElectionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ElectionDataImplCopyWith<_$ElectionDataImpl> get copyWith =>
      __$$ElectionDataImplCopyWithImpl<_$ElectionDataImpl>(this, _$identity);
}

abstract class _ElectionData implements ElectionData {
  const factory _ElectionData(
      {required final String name,
      required final int startHeight,
      required final int endHeight,
      required final String question,
      required final List<Answer> answers}) = _$ElectionDataImpl;

  @override
  String get name;
  @override
  int get startHeight;
  @override
  int get endHeight;
  @override
  String get question;
  @override
  List<Answer> get answers;

  /// Create a copy of ElectionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ElectionDataImplCopyWith<_$ElectionDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

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

/// @nodoc
mixin _$VoteRec {
  int get id => throw _privateConstructorUsedError;
  String get hash => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  BigInt get amount => throw _privateConstructorUsedError;
  int? get choice => throw _privateConstructorUsedError;

  /// Create a copy of VoteRec
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoteRecCopyWith<VoteRec> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoteRecCopyWith<$Res> {
  factory $VoteRecCopyWith(VoteRec value, $Res Function(VoteRec) then) =
      _$VoteRecCopyWithImpl<$Res, VoteRec>;
  @useResult
  $Res call({int id, String hash, String address, BigInt amount, int? choice});
}

/// @nodoc
class _$VoteRecCopyWithImpl<$Res, $Val extends VoteRec>
    implements $VoteRecCopyWith<$Res> {
  _$VoteRecCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoteRec
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hash = null,
    Object? address = null,
    Object? amount = null,
    Object? choice = freezed,
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
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      choice: freezed == choice
          ? _value.choice
          : choice // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoteRecImplCopyWith<$Res> implements $VoteRecCopyWith<$Res> {
  factory _$$VoteRecImplCopyWith(
          _$VoteRecImpl value, $Res Function(_$VoteRecImpl) then) =
      __$$VoteRecImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String hash, String address, BigInt amount, int? choice});
}

/// @nodoc
class __$$VoteRecImplCopyWithImpl<$Res>
    extends _$VoteRecCopyWithImpl<$Res, _$VoteRecImpl>
    implements _$$VoteRecImplCopyWith<$Res> {
  __$$VoteRecImplCopyWithImpl(
      _$VoteRecImpl _value, $Res Function(_$VoteRecImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoteRec
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hash = null,
    Object? address = null,
    Object? amount = null,
    Object? choice = freezed,
  }) {
    return _then(_$VoteRecImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      choice: freezed == choice
          ? _value.choice
          : choice // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$VoteRecImpl implements _VoteRec {
  const _$VoteRecImpl(
      {required this.id,
      required this.hash,
      required this.address,
      required this.amount,
      this.choice});

  @override
  final int id;
  @override
  final String hash;
  @override
  final String address;
  @override
  final BigInt amount;
  @override
  final int? choice;

  @override
  String toString() {
    return 'VoteRec(id: $id, hash: $hash, address: $address, amount: $amount, choice: $choice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoteRecImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.choice, choice) || other.choice == choice));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, hash, address, amount, choice);

  /// Create a copy of VoteRec
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoteRecImplCopyWith<_$VoteRecImpl> get copyWith =>
      __$$VoteRecImplCopyWithImpl<_$VoteRecImpl>(this, _$identity);
}

abstract class _VoteRec implements VoteRec {
  const factory _VoteRec(
      {required final int id,
      required final String hash,
      required final String address,
      required final BigInt amount,
      final int? choice}) = _$VoteRecImpl;

  @override
  int get id;
  @override
  String get hash;
  @override
  String get address;
  @override
  BigInt get amount;
  @override
  int? get choice;

  /// Create a copy of VoteRec
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoteRecImplCopyWith<_$VoteRecImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
