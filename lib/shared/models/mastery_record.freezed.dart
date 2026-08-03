// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastery_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MasteryRecord _$MasteryRecordFromJson(Map<String, dynamic> json) {
  return _MasteryRecord.fromJson(json);
}

/// @nodoc
mixin _$MasteryRecord {
  /// The skill being tracked (e.g., 'letter_alif', 'word_arnab').
  String get skillId => throw _privateConstructorUsedError;

  /// Current mastery level.
  MasteryLevel get level => throw _privateConstructorUsedError;

  /// Number of successful consecutive recalls.
  int get consecutiveCorrect => throw _privateConstructorUsedError;

  /// Last time this skill was practiced.
  DateTime get lastPracticed => throw _privateConstructorUsedError;

  /// Calculated next review date (SM-2 interval).
  DateTime get nextReview => throw _privateConstructorUsedError;

  /// Current ease factor for SM-2 (default 2.5).
  double get easeFactor => throw _privateConstructorUsedError;

  /// Current interval in days.
  int get intervalDays => throw _privateConstructorUsedError;

  /// Serializes this MasteryRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MasteryRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MasteryRecordCopyWith<MasteryRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MasteryRecordCopyWith<$Res> {
  factory $MasteryRecordCopyWith(
          MasteryRecord value, $Res Function(MasteryRecord) then) =
      _$MasteryRecordCopyWithImpl<$Res, MasteryRecord>;
  @useResult
  $Res call(
      {String skillId,
      MasteryLevel level,
      int consecutiveCorrect,
      DateTime lastPracticed,
      DateTime nextReview,
      double easeFactor,
      int intervalDays});
}

/// @nodoc
class _$MasteryRecordCopyWithImpl<$Res, $Val extends MasteryRecord>
    implements $MasteryRecordCopyWith<$Res> {
  _$MasteryRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MasteryRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skillId = null,
    Object? level = null,
    Object? consecutiveCorrect = null,
    Object? lastPracticed = null,
    Object? nextReview = null,
    Object? easeFactor = null,
    Object? intervalDays = null,
  }) {
    return _then(_value.copyWith(
      skillId: null == skillId
          ? _value.skillId
          : skillId // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as MasteryLevel,
      consecutiveCorrect: null == consecutiveCorrect
          ? _value.consecutiveCorrect
          : consecutiveCorrect // ignore: cast_nullable_to_non_nullable
              as int,
      lastPracticed: null == lastPracticed
          ? _value.lastPracticed
          : lastPracticed // ignore: cast_nullable_to_non_nullable
              as DateTime,
      nextReview: null == nextReview
          ? _value.nextReview
          : nextReview // ignore: cast_nullable_to_non_nullable
              as DateTime,
      easeFactor: null == easeFactor
          ? _value.easeFactor
          : easeFactor // ignore: cast_nullable_to_non_nullable
              as double,
      intervalDays: null == intervalDays
          ? _value.intervalDays
          : intervalDays // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MasteryRecordImplCopyWith<$Res>
    implements $MasteryRecordCopyWith<$Res> {
  factory _$$MasteryRecordImplCopyWith(
          _$MasteryRecordImpl value, $Res Function(_$MasteryRecordImpl) then) =
      __$$MasteryRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String skillId,
      MasteryLevel level,
      int consecutiveCorrect,
      DateTime lastPracticed,
      DateTime nextReview,
      double easeFactor,
      int intervalDays});
}

/// @nodoc
class __$$MasteryRecordImplCopyWithImpl<$Res>
    extends _$MasteryRecordCopyWithImpl<$Res, _$MasteryRecordImpl>
    implements _$$MasteryRecordImplCopyWith<$Res> {
  __$$MasteryRecordImplCopyWithImpl(
      _$MasteryRecordImpl _value, $Res Function(_$MasteryRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of MasteryRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skillId = null,
    Object? level = null,
    Object? consecutiveCorrect = null,
    Object? lastPracticed = null,
    Object? nextReview = null,
    Object? easeFactor = null,
    Object? intervalDays = null,
  }) {
    return _then(_$MasteryRecordImpl(
      skillId: null == skillId
          ? _value.skillId
          : skillId // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as MasteryLevel,
      consecutiveCorrect: null == consecutiveCorrect
          ? _value.consecutiveCorrect
          : consecutiveCorrect // ignore: cast_nullable_to_non_nullable
              as int,
      lastPracticed: null == lastPracticed
          ? _value.lastPracticed
          : lastPracticed // ignore: cast_nullable_to_non_nullable
              as DateTime,
      nextReview: null == nextReview
          ? _value.nextReview
          : nextReview // ignore: cast_nullable_to_non_nullable
              as DateTime,
      easeFactor: null == easeFactor
          ? _value.easeFactor
          : easeFactor // ignore: cast_nullable_to_non_nullable
              as double,
      intervalDays: null == intervalDays
          ? _value.intervalDays
          : intervalDays // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MasteryRecordImpl implements _MasteryRecord {
  const _$MasteryRecordImpl(
      {required this.skillId,
      this.level = MasteryLevel.newSkill,
      this.consecutiveCorrect = 0,
      required this.lastPracticed,
      required this.nextReview,
      this.easeFactor = 2.5,
      this.intervalDays = 1});

  factory _$MasteryRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$MasteryRecordImplFromJson(json);

  /// The skill being tracked (e.g., 'letter_alif', 'word_arnab').
  @override
  final String skillId;

  /// Current mastery level.
  @override
  @JsonKey()
  final MasteryLevel level;

  /// Number of successful consecutive recalls.
  @override
  @JsonKey()
  final int consecutiveCorrect;

  /// Last time this skill was practiced.
  @override
  final DateTime lastPracticed;

  /// Calculated next review date (SM-2 interval).
  @override
  final DateTime nextReview;

  /// Current ease factor for SM-2 (default 2.5).
  @override
  @JsonKey()
  final double easeFactor;

  /// Current interval in days.
  @override
  @JsonKey()
  final int intervalDays;

  @override
  String toString() {
    return 'MasteryRecord(skillId: $skillId, level: $level, consecutiveCorrect: $consecutiveCorrect, lastPracticed: $lastPracticed, nextReview: $nextReview, easeFactor: $easeFactor, intervalDays: $intervalDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MasteryRecordImpl &&
            (identical(other.skillId, skillId) || other.skillId == skillId) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.consecutiveCorrect, consecutiveCorrect) ||
                other.consecutiveCorrect == consecutiveCorrect) &&
            (identical(other.lastPracticed, lastPracticed) ||
                other.lastPracticed == lastPracticed) &&
            (identical(other.nextReview, nextReview) ||
                other.nextReview == nextReview) &&
            (identical(other.easeFactor, easeFactor) ||
                other.easeFactor == easeFactor) &&
            (identical(other.intervalDays, intervalDays) ||
                other.intervalDays == intervalDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, skillId, level,
      consecutiveCorrect, lastPracticed, nextReview, easeFactor, intervalDays);

  /// Create a copy of MasteryRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MasteryRecordImplCopyWith<_$MasteryRecordImpl> get copyWith =>
      __$$MasteryRecordImplCopyWithImpl<_$MasteryRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MasteryRecordImplToJson(
      this,
    );
  }
}

abstract class _MasteryRecord implements MasteryRecord {
  const factory _MasteryRecord(
      {required final String skillId,
      final MasteryLevel level,
      final int consecutiveCorrect,
      required final DateTime lastPracticed,
      required final DateTime nextReview,
      final double easeFactor,
      final int intervalDays}) = _$MasteryRecordImpl;

  factory _MasteryRecord.fromJson(Map<String, dynamic> json) =
      _$MasteryRecordImpl.fromJson;

  /// The skill being tracked (e.g., 'letter_alif', 'word_arnab').
  @override
  String get skillId;

  /// Current mastery level.
  @override
  MasteryLevel get level;

  /// Number of successful consecutive recalls.
  @override
  int get consecutiveCorrect;

  /// Last time this skill was practiced.
  @override
  DateTime get lastPracticed;

  /// Calculated next review date (SM-2 interval).
  @override
  DateTime get nextReview;

  /// Current ease factor for SM-2 (default 2.5).
  @override
  double get easeFactor;

  /// Current interval in days.
  @override
  int get intervalDays;

  /// Create a copy of MasteryRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MasteryRecordImplCopyWith<_$MasteryRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
