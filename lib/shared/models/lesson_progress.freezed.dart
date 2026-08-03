// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LessonProgress _$LessonProgressFromJson(Map<String, dynamic> json) {
  return _LessonProgress.fromJson(json);
}

/// @nodoc
mixin _$LessonProgress {
  /// Unique lesson identifier (e.g., 'unit1_lesson3').
  String get lessonId => throw _privateConstructorUsedError;

  /// Current status of the lesson.
  LessonStatus get status => throw _privateConstructorUsedError;

  /// Number of times the child has attempted this lesson.
  int get attempts => throw _privateConstructorUsedError;

  /// Best score achieved (0-100).
  int get bestScore => throw _privateConstructorUsedError;

  /// Total stars earned (0-3) based on performance.
  int get starsEarned => throw _privateConstructorUsedError;

  /// When the lesson was completed (null if not yet completed).
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// XP awarded for this lesson.
  int get xpEarned => throw _privateConstructorUsedError;

  /// Serializes this LessonProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LessonProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LessonProgressCopyWith<LessonProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonProgressCopyWith<$Res> {
  factory $LessonProgressCopyWith(
          LessonProgress value, $Res Function(LessonProgress) then) =
      _$LessonProgressCopyWithImpl<$Res, LessonProgress>;
  @useResult
  $Res call(
      {String lessonId,
      LessonStatus status,
      int attempts,
      int bestScore,
      int starsEarned,
      DateTime? completedAt,
      int xpEarned});
}

/// @nodoc
class _$LessonProgressCopyWithImpl<$Res, $Val extends LessonProgress>
    implements $LessonProgressCopyWith<$Res> {
  _$LessonProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LessonProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lessonId = null,
    Object? status = null,
    Object? attempts = null,
    Object? bestScore = null,
    Object? starsEarned = null,
    Object? completedAt = freezed,
    Object? xpEarned = null,
  }) {
    return _then(_value.copyWith(
      lessonId: null == lessonId
          ? _value.lessonId
          : lessonId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LessonStatus,
      attempts: null == attempts
          ? _value.attempts
          : attempts // ignore: cast_nullable_to_non_nullable
              as int,
      bestScore: null == bestScore
          ? _value.bestScore
          : bestScore // ignore: cast_nullable_to_non_nullable
              as int,
      starsEarned: null == starsEarned
          ? _value.starsEarned
          : starsEarned // ignore: cast_nullable_to_non_nullable
              as int,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      xpEarned: null == xpEarned
          ? _value.xpEarned
          : xpEarned // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LessonProgressImplCopyWith<$Res>
    implements $LessonProgressCopyWith<$Res> {
  factory _$$LessonProgressImplCopyWith(_$LessonProgressImpl value,
          $Res Function(_$LessonProgressImpl) then) =
      __$$LessonProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String lessonId,
      LessonStatus status,
      int attempts,
      int bestScore,
      int starsEarned,
      DateTime? completedAt,
      int xpEarned});
}

/// @nodoc
class __$$LessonProgressImplCopyWithImpl<$Res>
    extends _$LessonProgressCopyWithImpl<$Res, _$LessonProgressImpl>
    implements _$$LessonProgressImplCopyWith<$Res> {
  __$$LessonProgressImplCopyWithImpl(
      _$LessonProgressImpl _value, $Res Function(_$LessonProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of LessonProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lessonId = null,
    Object? status = null,
    Object? attempts = null,
    Object? bestScore = null,
    Object? starsEarned = null,
    Object? completedAt = freezed,
    Object? xpEarned = null,
  }) {
    return _then(_$LessonProgressImpl(
      lessonId: null == lessonId
          ? _value.lessonId
          : lessonId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LessonStatus,
      attempts: null == attempts
          ? _value.attempts
          : attempts // ignore: cast_nullable_to_non_nullable
              as int,
      bestScore: null == bestScore
          ? _value.bestScore
          : bestScore // ignore: cast_nullable_to_non_nullable
              as int,
      starsEarned: null == starsEarned
          ? _value.starsEarned
          : starsEarned // ignore: cast_nullable_to_non_nullable
              as int,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      xpEarned: null == xpEarned
          ? _value.xpEarned
          : xpEarned // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LessonProgressImpl implements _LessonProgress {
  const _$LessonProgressImpl(
      {required this.lessonId,
      this.status = LessonStatus.locked,
      this.attempts = 0,
      this.bestScore = 0,
      this.starsEarned = 0,
      this.completedAt,
      this.xpEarned = 0});

  factory _$LessonProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonProgressImplFromJson(json);

  /// Unique lesson identifier (e.g., 'unit1_lesson3').
  @override
  final String lessonId;

  /// Current status of the lesson.
  @override
  @JsonKey()
  final LessonStatus status;

  /// Number of times the child has attempted this lesson.
  @override
  @JsonKey()
  final int attempts;

  /// Best score achieved (0-100).
  @override
  @JsonKey()
  final int bestScore;

  /// Total stars earned (0-3) based on performance.
  @override
  @JsonKey()
  final int starsEarned;

  /// When the lesson was completed (null if not yet completed).
  @override
  final DateTime? completedAt;

  /// XP awarded for this lesson.
  @override
  @JsonKey()
  final int xpEarned;

  @override
  String toString() {
    return 'LessonProgress(lessonId: $lessonId, status: $status, attempts: $attempts, bestScore: $bestScore, starsEarned: $starsEarned, completedAt: $completedAt, xpEarned: $xpEarned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonProgressImpl &&
            (identical(other.lessonId, lessonId) ||
                other.lessonId == lessonId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.attempts, attempts) ||
                other.attempts == attempts) &&
            (identical(other.bestScore, bestScore) ||
                other.bestScore == bestScore) &&
            (identical(other.starsEarned, starsEarned) ||
                other.starsEarned == starsEarned) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.xpEarned, xpEarned) ||
                other.xpEarned == xpEarned));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lessonId, status, attempts,
      bestScore, starsEarned, completedAt, xpEarned);

  /// Create a copy of LessonProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonProgressImplCopyWith<_$LessonProgressImpl> get copyWith =>
      __$$LessonProgressImplCopyWithImpl<_$LessonProgressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LessonProgressImplToJson(
      this,
    );
  }
}

abstract class _LessonProgress implements LessonProgress {
  const factory _LessonProgress(
      {required final String lessonId,
      final LessonStatus status,
      final int attempts,
      final int bestScore,
      final int starsEarned,
      final DateTime? completedAt,
      final int xpEarned}) = _$LessonProgressImpl;

  factory _LessonProgress.fromJson(Map<String, dynamic> json) =
      _$LessonProgressImpl.fromJson;

  /// Unique lesson identifier (e.g., 'unit1_lesson3').
  @override
  String get lessonId;

  /// Current status of the lesson.
  @override
  LessonStatus get status;

  /// Number of times the child has attempted this lesson.
  @override
  int get attempts;

  /// Best score achieved (0-100).
  @override
  int get bestScore;

  /// Total stars earned (0-3) based on performance.
  @override
  int get starsEarned;

  /// When the lesson was completed (null if not yet completed).
  @override
  DateTime? get completedAt;

  /// XP awarded for this lesson.
  @override
  int get xpEarned;

  /// Create a copy of LessonProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonProgressImplCopyWith<_$LessonProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
