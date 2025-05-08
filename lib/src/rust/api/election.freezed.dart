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
mixin _$CreateElectionResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int height) progress,
    required TResult Function(String message) message,
    required TResult Function(String hash, String phrase, String electionString)
        result,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int height)? progress,
    TResult? Function(String message)? message,
    TResult? Function(String hash, String phrase, String electionString)?
        result,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int height)? progress,
    TResult Function(String message)? message,
    TResult Function(String hash, String phrase, String electionString)? result,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateElectionResult_Progress value) progress,
    required TResult Function(CreateElectionResult_Message value) message,
    required TResult Function(CreateElectionResult_Result value) result,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateElectionResult_Progress value)? progress,
    TResult? Function(CreateElectionResult_Message value)? message,
    TResult? Function(CreateElectionResult_Result value)? result,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateElectionResult_Progress value)? progress,
    TResult Function(CreateElectionResult_Message value)? message,
    TResult Function(CreateElectionResult_Result value)? result,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateElectionResultCopyWith<$Res> {
  factory $CreateElectionResultCopyWith(CreateElectionResult value,
          $Res Function(CreateElectionResult) then) =
      _$CreateElectionResultCopyWithImpl<$Res, CreateElectionResult>;
}

/// @nodoc
class _$CreateElectionResultCopyWithImpl<$Res,
        $Val extends CreateElectionResult>
    implements $CreateElectionResultCopyWith<$Res> {
  _$CreateElectionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateElectionResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CreateElectionResult_ProgressImplCopyWith<$Res> {
  factory _$$CreateElectionResult_ProgressImplCopyWith(
          _$CreateElectionResult_ProgressImpl value,
          $Res Function(_$CreateElectionResult_ProgressImpl) then) =
      __$$CreateElectionResult_ProgressImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int height});
}

/// @nodoc
class __$$CreateElectionResult_ProgressImplCopyWithImpl<$Res>
    extends _$CreateElectionResultCopyWithImpl<$Res,
        _$CreateElectionResult_ProgressImpl>
    implements _$$CreateElectionResult_ProgressImplCopyWith<$Res> {
  __$$CreateElectionResult_ProgressImplCopyWithImpl(
      _$CreateElectionResult_ProgressImpl _value,
      $Res Function(_$CreateElectionResult_ProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateElectionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? height = null,
  }) {
    return _then(_$CreateElectionResult_ProgressImpl(
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CreateElectionResult_ProgressImpl
    extends CreateElectionResult_Progress {
  const _$CreateElectionResult_ProgressImpl({required this.height}) : super._();

  @override
  final int height;

  @override
  String toString() {
    return 'CreateElectionResult.progress(height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateElectionResult_ProgressImpl &&
            (identical(other.height, height) || other.height == height));
  }

  @override
  int get hashCode => Object.hash(runtimeType, height);

  /// Create a copy of CreateElectionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateElectionResult_ProgressImplCopyWith<
          _$CreateElectionResult_ProgressImpl>
      get copyWith => __$$CreateElectionResult_ProgressImplCopyWithImpl<
          _$CreateElectionResult_ProgressImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int height) progress,
    required TResult Function(String message) message,
    required TResult Function(String hash, String phrase, String electionString)
        result,
  }) {
    return progress(height);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int height)? progress,
    TResult? Function(String message)? message,
    TResult? Function(String hash, String phrase, String electionString)?
        result,
  }) {
    return progress?.call(height);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int height)? progress,
    TResult Function(String message)? message,
    TResult Function(String hash, String phrase, String electionString)? result,
    required TResult orElse(),
  }) {
    if (progress != null) {
      return progress(height);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateElectionResult_Progress value) progress,
    required TResult Function(CreateElectionResult_Message value) message,
    required TResult Function(CreateElectionResult_Result value) result,
  }) {
    return progress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateElectionResult_Progress value)? progress,
    TResult? Function(CreateElectionResult_Message value)? message,
    TResult? Function(CreateElectionResult_Result value)? result,
  }) {
    return progress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateElectionResult_Progress value)? progress,
    TResult Function(CreateElectionResult_Message value)? message,
    TResult Function(CreateElectionResult_Result value)? result,
    required TResult orElse(),
  }) {
    if (progress != null) {
      return progress(this);
    }
    return orElse();
  }
}

abstract class CreateElectionResult_Progress extends CreateElectionResult {
  const factory CreateElectionResult_Progress({required final int height}) =
      _$CreateElectionResult_ProgressImpl;
  const CreateElectionResult_Progress._() : super._();

  int get height;

  /// Create a copy of CreateElectionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateElectionResult_ProgressImplCopyWith<
          _$CreateElectionResult_ProgressImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateElectionResult_MessageImplCopyWith<$Res> {
  factory _$$CreateElectionResult_MessageImplCopyWith(
          _$CreateElectionResult_MessageImpl value,
          $Res Function(_$CreateElectionResult_MessageImpl) then) =
      __$$CreateElectionResult_MessageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CreateElectionResult_MessageImplCopyWithImpl<$Res>
    extends _$CreateElectionResultCopyWithImpl<$Res,
        _$CreateElectionResult_MessageImpl>
    implements _$$CreateElectionResult_MessageImplCopyWith<$Res> {
  __$$CreateElectionResult_MessageImplCopyWithImpl(
      _$CreateElectionResult_MessageImpl _value,
      $Res Function(_$CreateElectionResult_MessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateElectionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$CreateElectionResult_MessageImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CreateElectionResult_MessageImpl extends CreateElectionResult_Message {
  const _$CreateElectionResult_MessageImpl({required this.message}) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'CreateElectionResult.message(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateElectionResult_MessageImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CreateElectionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateElectionResult_MessageImplCopyWith<
          _$CreateElectionResult_MessageImpl>
      get copyWith => __$$CreateElectionResult_MessageImplCopyWithImpl<
          _$CreateElectionResult_MessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int height) progress,
    required TResult Function(String message) message,
    required TResult Function(String hash, String phrase, String electionString)
        result,
  }) {
    return message(this.message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int height)? progress,
    TResult? Function(String message)? message,
    TResult? Function(String hash, String phrase, String electionString)?
        result,
  }) {
    return message?.call(this.message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int height)? progress,
    TResult Function(String message)? message,
    TResult Function(String hash, String phrase, String electionString)? result,
    required TResult orElse(),
  }) {
    if (message != null) {
      return message(this.message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateElectionResult_Progress value) progress,
    required TResult Function(CreateElectionResult_Message value) message,
    required TResult Function(CreateElectionResult_Result value) result,
  }) {
    return message(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateElectionResult_Progress value)? progress,
    TResult? Function(CreateElectionResult_Message value)? message,
    TResult? Function(CreateElectionResult_Result value)? result,
  }) {
    return message?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateElectionResult_Progress value)? progress,
    TResult Function(CreateElectionResult_Message value)? message,
    TResult Function(CreateElectionResult_Result value)? result,
    required TResult orElse(),
  }) {
    if (message != null) {
      return message(this);
    }
    return orElse();
  }
}

abstract class CreateElectionResult_Message extends CreateElectionResult {
  const factory CreateElectionResult_Message({required final String message}) =
      _$CreateElectionResult_MessageImpl;
  const CreateElectionResult_Message._() : super._();

  String get message;

  /// Create a copy of CreateElectionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateElectionResult_MessageImplCopyWith<
          _$CreateElectionResult_MessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateElectionResult_ResultImplCopyWith<$Res> {
  factory _$$CreateElectionResult_ResultImplCopyWith(
          _$CreateElectionResult_ResultImpl value,
          $Res Function(_$CreateElectionResult_ResultImpl) then) =
      __$$CreateElectionResult_ResultImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String hash, String phrase, String electionString});
}

/// @nodoc
class __$$CreateElectionResult_ResultImplCopyWithImpl<$Res>
    extends _$CreateElectionResultCopyWithImpl<$Res,
        _$CreateElectionResult_ResultImpl>
    implements _$$CreateElectionResult_ResultImplCopyWith<$Res> {
  __$$CreateElectionResult_ResultImplCopyWithImpl(
      _$CreateElectionResult_ResultImpl _value,
      $Res Function(_$CreateElectionResult_ResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateElectionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hash = null,
    Object? phrase = null,
    Object? electionString = null,
  }) {
    return _then(_$CreateElectionResult_ResultImpl(
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      phrase: null == phrase
          ? _value.phrase
          : phrase // ignore: cast_nullable_to_non_nullable
              as String,
      electionString: null == electionString
          ? _value.electionString
          : electionString // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CreateElectionResult_ResultImpl extends CreateElectionResult_Result {
  const _$CreateElectionResult_ResultImpl(
      {required this.hash, required this.phrase, required this.electionString})
      : super._();

  @override
  final String hash;
  @override
  final String phrase;
  @override
  final String electionString;

  @override
  String toString() {
    return 'CreateElectionResult.result(hash: $hash, phrase: $phrase, electionString: $electionString)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateElectionResult_ResultImpl &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.phrase, phrase) || other.phrase == phrase) &&
            (identical(other.electionString, electionString) ||
                other.electionString == electionString));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hash, phrase, electionString);

  /// Create a copy of CreateElectionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateElectionResult_ResultImplCopyWith<_$CreateElectionResult_ResultImpl>
      get copyWith => __$$CreateElectionResult_ResultImplCopyWithImpl<
          _$CreateElectionResult_ResultImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int height) progress,
    required TResult Function(String message) message,
    required TResult Function(String hash, String phrase, String electionString)
        result,
  }) {
    return result(hash, phrase, electionString);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int height)? progress,
    TResult? Function(String message)? message,
    TResult? Function(String hash, String phrase, String electionString)?
        result,
  }) {
    return result?.call(hash, phrase, electionString);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int height)? progress,
    TResult Function(String message)? message,
    TResult Function(String hash, String phrase, String electionString)? result,
    required TResult orElse(),
  }) {
    if (result != null) {
      return result(hash, phrase, electionString);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreateElectionResult_Progress value) progress,
    required TResult Function(CreateElectionResult_Message value) message,
    required TResult Function(CreateElectionResult_Result value) result,
  }) {
    return result(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreateElectionResult_Progress value)? progress,
    TResult? Function(CreateElectionResult_Message value)? message,
    TResult? Function(CreateElectionResult_Result value)? result,
  }) {
    return result?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreateElectionResult_Progress value)? progress,
    TResult Function(CreateElectionResult_Message value)? message,
    TResult Function(CreateElectionResult_Result value)? result,
    required TResult orElse(),
  }) {
    if (result != null) {
      return result(this);
    }
    return orElse();
  }
}

abstract class CreateElectionResult_Result extends CreateElectionResult {
  const factory CreateElectionResult_Result(
          {required final String hash,
          required final String phrase,
          required final String electionString}) =
      _$CreateElectionResult_ResultImpl;
  const CreateElectionResult_Result._() : super._();

  String get hash;
  String get phrase;
  String get electionString;

  /// Create a copy of CreateElectionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateElectionResult_ResultImplCopyWith<_$CreateElectionResult_ResultImpl>
      get copyWith => throw _privateConstructorUsedError;
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
