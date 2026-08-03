// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streak_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StreakData _$StreakDataFromJson(Map<String, dynamic> json) {
  return _StreakData.fromJson(json);
}

/// @nodoc
mixin _$StreakData {
  /// Number of consecutive days with at least one lesson completed.
  int get currentStreak => throw _privateConstructorUsedError;

  /// Longest streak ever achieved.
  int get longestStreak => throw _privateConstructorUsedError;

  /// Last date the child was active (completed at least one activity).
  DateTime get lastActiveDate => throw _privateConstructorUsedError;

  /// Total number of days the child has been active.
  int get totalActiveDays => throw _privateConstructorUsedError;

  /// Whether today's activity has been completed (prevents double counting).
  bool get todayCompleted => throw _privateConstructorUsedError;

  /// Serializes this StreakData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StreakData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreakDataCopyWith<StreakData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreakDataCopyWith<$Res> {
  factory $StreakDataCopyWith(
          StreakData value, $Res Function(StreakData) then) =
      _$StreakDataCopyWithImpl<$Res, StreakData>;
  @useResult
  $Res call(
      {int currentStreak,
      int longestStreak,
      DateTime lastActiveDate,
      int totalActiveDays,
      bool todayCompleted});
}

/// @nodoc
class _$StreakDataCopyWithImpl<$Res, $Val extends StreakData>
    implements $StreakDataCopyWith<$Res> {
  _$StreakDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreakData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? lastActiveDate = null,
    Object? totalActiveDays = null,
    Object? todayCompleted = null,
  }) {
    return _then(_value.copyWith(
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      lastActiveDate: null == lastActiveDate
          ? _value.lastActiveDate
          : lastActiveDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalActiveDays: null == totalActiveDays
          ? _value.totalActiveDays
          : totalActiveDays // ignore: cast_nullable_to_non_nullable
              as int,
      todayCompleted: null == todayCompleted
          ? _value.todayCompleted
          : todayCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StreakDataImplCopyWith<$Res>
    implements $StreakDataCopyWith<$Res> {
  factory _$$StreakDataImplCopyWith(
          _$StreakDataImpl value, $Res Function(_$StreakDataImpl) then) =
      __$$StreakDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int currentStreak,
      int longestStreak,
      DateTime lastActiveDate,
      int totalActiveDays,
      bool todayCompleted});
}

/// @nodoc
class __$$StreakDataImplCopyWithImpl<$Res>
    extends _$StreakDataCopyWithImpl<$Res, _$StreakDataImpl>
    implements _$$StreakDataImplCopyWith<$Res> {
  __$$StreakDataImplCopyWithImpl(
      _$StreakDataImpl _value, $Res Function(_$StreakDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of StreakData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? lastActiveDate = null,
    Object? totalActiveDays = null,
    Object? todayCompleted = null,
  }) {
    return _then(_$StreakDataImpl(
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      lastActiveDate: null == lastActiveDate
          ? _value.lastActiveDate
          : lastActiveDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalActiveDays: null == totalActiveDays
          ? _value.totalActiveDays
          : totalActiveDays // ignore: cast_nullable_to_non_nullable
              as int,
      todayCompleted: null == todayCompleted
          ? _value.todayCompleted
          : todayCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StreakDataImpl implements _StreakData {
  const _$StreakDataImpl(
      {this.currentStreak = 0,
      this.longestStreak = 0,
      required this.lastActiveDate,
      this.totalActiveDays = 0,
      this.todayCompleted = false});

  factory _$StreakDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$StreakDataImplFromJson(json);

  /// Number of consecutive days with at least one lesson completed.
  @override
  @JsonKey()
  final int currentStreak;

  /// Longest streak ever achieved.
  @override
  @JsonKey()
  final int longestStreak;

  /// Last date the child was active (completed at least one activity).
  @override
  final DateTime lastActiveDate;

  /// Total number of days the child has been active.
  @override
  @JsonKey()
  final int totalActiveDays;

  /// Whether today's activity has been completed (prevents double counting).
  @override
  @JsonKey()
  final bool todayCompleted;

  @override
  String toString() {
    return 'StreakData(currentStreak: $currentStreak, longestStreak: $longestStreak, lastActiveDate: $lastActiveDate, totalActiveDays: $totalActiveDays, todayCompleted: $todayCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreakDataImpl &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.lastActiveDate, lastActiveDate) ||
                other.lastActiveDate == lastActiveDate) &&
            (identical(other.totalActiveDays, totalActiveDays) ||
                other.totalActiveDays == totalActiveDays) &&
            (identical(other.todayCompleted, todayCompleted) ||
                other.todayCompleted == todayCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, currentStreak, longestStreak,
      lastActiveDate, totalActiveDays, todayCompleted);

  /// Create a copy of StreakData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreakDataImplCopyWith<_$StreakDataImpl> get copyWith =>
      __$$StreakDataImplCopyWithImpl<_$StreakDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StreakDataImplToJson(
      this,
    );
  }
}

abstract class _StreakData implements StreakData {
  const factory _StreakData(
      {final int currentStreak,
      final int longestStreak,
      required final DateTime lastActiveDate,
      final int totalActiveDays,
      final bool todayCompleted}) = _$StreakDataImpl;

  factory _StreakData.fromJson(Map<String, dynamic> json) =
      _$StreakDataImpl.fromJson;

  /// Number of consecutive days with at least one lesson completed.
  @override
  int get currentStreak;

  /// Longest streak ever achieved.
  @override
  int get longestStreak;

  /// Last date the child was active (completed at least one activity).
  @override
  DateTime get lastActiveDate;

  /// Total number of days the child has been active.
  @override
  int get totalActiveDays;

  /// Whether today's activity has been completed (prevents double counting).
  @override
  bool get todayCompleted;

  /// Create a copy of StreakData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreakDataImplCopyWith<_$StreakDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
