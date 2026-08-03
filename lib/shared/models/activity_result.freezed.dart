// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ActivityResult _$ActivityResultFromJson(Map<String, dynamic> json) {
  return _ActivityResult.fromJson(json);
}

/// @nodoc
mixin _$ActivityResult {
  /// Unique activity identifier.
  String get activityId => throw _privateConstructorUsedError;

  /// Type of activity completed.
  ActivityType get type => throw _privateConstructorUsedError;

  /// Whether the activity was answered correctly.
  bool get correct => throw _privateConstructorUsedError;

  /// Time spent on the activity in milliseconds.
  int get timeSpentMs => throw _privateConstructorUsedError;

  /// Number of attempts before success (or giving up).
  int get attempts => throw _privateConstructorUsedError;

  /// Timestamp of the activity completion.
  DateTime get completedAt => throw _privateConstructorUsedError;

  /// The letter or skill this activity targets.
  String? get targetLetter => throw _privateConstructorUsedError;

  /// Hint count used during this activity.
  int get hintsUsed => throw _privateConstructorUsedError;

  /// Serializes this ActivityResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivityResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityResultCopyWith<ActivityResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityResultCopyWith<$Res> {
  factory $ActivityResultCopyWith(
          ActivityResult value, $Res Function(ActivityResult) then) =
      _$ActivityResultCopyWithImpl<$Res, ActivityResult>;
  @useResult
  $Res call(
      {String activityId,
      ActivityType type,
      bool correct,
      int timeSpentMs,
      int attempts,
      DateTime completedAt,
      String? targetLetter,
      int hintsUsed});
}

/// @nodoc
class _$ActivityResultCopyWithImpl<$Res, $Val extends ActivityResult>
    implements $ActivityResultCopyWith<$Res> {
  _$ActivityResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activityId = null,
    Object? type = null,
    Object? correct = null,
    Object? timeSpentMs = null,
    Object? attempts = null,
    Object? completedAt = null,
    Object? targetLetter = freezed,
    Object? hintsUsed = null,
  }) {
    return _then(_value.copyWith(
      activityId: null == activityId
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ActivityType,
      correct: null == correct
          ? _value.correct
          : correct // ignore: cast_nullable_to_non_nullable
              as bool,
      timeSpentMs: null == timeSpentMs
          ? _value.timeSpentMs
          : timeSpentMs // ignore: cast_nullable_to_non_nullable
              as int,
      attempts: null == attempts
          ? _value.attempts
          : attempts // ignore: cast_nullable_to_non_nullable
              as int,
      completedAt: null == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      targetLetter: freezed == targetLetter
          ? _value.targetLetter
          : targetLetter // ignore: cast_nullable_to_non_nullable
              as String?,
      hintsUsed: null == hintsUsed
          ? _value.hintsUsed
          : hintsUsed // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivityResultImplCopyWith<$Res>
    implements $ActivityResultCopyWith<$Res> {
  factory _$$ActivityResultImplCopyWith(_$ActivityResultImpl value,
          $Res Function(_$ActivityResultImpl) then) =
      __$$ActivityResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String activityId,
      ActivityType type,
      bool correct,
      int timeSpentMs,
      int attempts,
      DateTime completedAt,
      String? targetLetter,
      int hintsUsed});
}

/// @nodoc
class __$$ActivityResultImplCopyWithImpl<$Res>
    extends _$ActivityResultCopyWithImpl<$Res, _$ActivityResultImpl>
    implements _$$ActivityResultImplCopyWith<$Res> {
  __$$ActivityResultImplCopyWithImpl(
      _$ActivityResultImpl _value, $Res Function(_$ActivityResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActivityResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activityId = null,
    Object? type = null,
    Object? correct = null,
    Object? timeSpentMs = null,
    Object? attempts = null,
    Object? completedAt = null,
    Object? targetLetter = freezed,
    Object? hintsUsed = null,
  }) {
    return _then(_$ActivityResultImpl(
      activityId: null == activityId
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ActivityType,
      correct: null == correct
          ? _value.correct
          : correct // ignore: cast_nullable_to_non_nullable
              as bool,
      timeSpentMs: null == timeSpentMs
          ? _value.timeSpentMs
          : timeSpentMs // ignore: cast_nullable_to_non_nullable
              as int,
      attempts: null == attempts
          ? _value.attempts
          : attempts // ignore: cast_nullable_to_non_nullable
              as int,
      completedAt: null == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      targetLetter: freezed == targetLetter
          ? _value.targetLetter
          : targetLetter // ignore: cast_nullable_to_non_nullable
              as String?,
      hintsUsed: null == hintsUsed
          ? _value.hintsUsed
          : hintsUsed // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityResultImpl implements _ActivityResult {
  const _$ActivityResultImpl(
      {required this.activityId,
      required this.type,
      required this.correct,
      required this.timeSpentMs,
      this.attempts = 1,
      required this.completedAt,
      this.targetLetter,
      this.hintsUsed = 0});

  factory _$ActivityResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityResultImplFromJson(json);

  /// Unique activity identifier.
  @override
  final String activityId;

  /// Type of activity completed.
  @override
  final ActivityType type;

  /// Whether the activity was answered correctly.
  @override
  final bool correct;

  /// Time spent on the activity in milliseconds.
  @override
  final int timeSpentMs;

  /// Number of attempts before success (or giving up).
  @override
  @JsonKey()
  final int attempts;

  /// Timestamp of the activity completion.
  @override
  final DateTime completedAt;

  /// The letter or skill this activity targets.
  @override
  final String? targetLetter;

  /// Hint count used during this activity.
  @override
  @JsonKey()
  final int hintsUsed;

  @override
  String toString() {
    return 'ActivityResult(activityId: $activityId, type: $type, correct: $correct, timeSpentMs: $timeSpentMs, attempts: $attempts, completedAt: $completedAt, targetLetter: $targetLetter, hintsUsed: $hintsUsed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityResultImpl &&
            (identical(other.activityId, activityId) ||
                other.activityId == activityId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.correct, correct) || other.correct == correct) &&
            (identical(other.timeSpentMs, timeSpentMs) ||
                other.timeSpentMs == timeSpentMs) &&
            (identical(other.attempts, attempts) ||
                other.attempts == attempts) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.targetLetter, targetLetter) ||
                other.targetLetter == targetLetter) &&
            (identical(other.hintsUsed, hintsUsed) ||
                other.hintsUsed == hintsUsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, activityId, type, correct,
      timeSpentMs, attempts, completedAt, targetLetter, hintsUsed);

  /// Create a copy of ActivityResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityResultImplCopyWith<_$ActivityResultImpl> get copyWith =>
      __$$ActivityResultImplCopyWithImpl<_$ActivityResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityResultImplToJson(
      this,
    );
  }
}

abstract class _ActivityResult implements ActivityResult {
  const factory _ActivityResult(
      {required final String activityId,
      required final ActivityType type,
      required final bool correct,
      required final int timeSpentMs,
      final int attempts,
      required final DateTime completedAt,
      final String? targetLetter,
      final int hintsUsed}) = _$ActivityResultImpl;

  factory _ActivityResult.fromJson(Map<String, dynamic> json) =
      _$ActivityResultImpl.fromJson;

  /// Unique activity identifier.
  @override
  String get activityId;

  /// Type of activity completed.
  @override
  ActivityType get type;

  /// Whether the activity was answered correctly.
  @override
  bool get correct;

  /// Time spent on the activity in milliseconds.
  @override
  int get timeSpentMs;

  /// Number of attempts before success (or giving up).
  @override
  int get attempts;

  /// Timestamp of the activity completion.
  @override
  DateTime get completedAt;

  /// The letter or skill this activity targets.
  @override
  String? get targetLetter;

  /// Hint count used during this activity.
  @override
  int get hintsUsed;

  /// Create a copy of ActivityResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityResultImplCopyWith<_$ActivityResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
