// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChildProfile _$ChildProfileFromJson(Map<String, dynamic> json) {
  return _ChildProfile.fromJson(json);
}

/// @nodoc
mixin _$ChildProfile {
  /// Unique identifier (UUID) for this child profile.
  String get id => throw _privateConstructorUsedError;

  /// Child's display name (chosen by parent).
  String get name => throw _privateConstructorUsedError;

  /// Index of the selected avatar (0-based).
  int get avatarIndex => throw _privateConstructorUsedError;

  /// Age group string: 'preschool3to5', 'emerging6to8', or 'independent9to10'.
  String get ageGroup => throw _privateConstructorUsedError;

  /// When the profile was created.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Currently active unit ID (e.g., 'unit_01_alif').
  String get currentUnit => throw _privateConstructorUsedError;

  /// Total experience points earned across all activities.
  int get totalXP => throw _privateConstructorUsedError;

  /// Timestamp of last sync to Firestore (null = never synced).
  DateTime? get lastSyncedAt => throw _privateConstructorUsedError;

  /// Serializes this ChildProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChildProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChildProfileCopyWith<ChildProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChildProfileCopyWith<$Res> {
  factory $ChildProfileCopyWith(
          ChildProfile value, $Res Function(ChildProfile) then) =
      _$ChildProfileCopyWithImpl<$Res, ChildProfile>;
  @useResult
  $Res call(
      {String id,
      String name,
      int avatarIndex,
      String ageGroup,
      DateTime createdAt,
      String currentUnit,
      int totalXP,
      DateTime? lastSyncedAt});
}

/// @nodoc
class _$ChildProfileCopyWithImpl<$Res, $Val extends ChildProfile>
    implements $ChildProfileCopyWith<$Res> {
  _$ChildProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChildProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatarIndex = null,
    Object? ageGroup = null,
    Object? createdAt = null,
    Object? currentUnit = null,
    Object? totalXP = null,
    Object? lastSyncedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatarIndex: null == avatarIndex
          ? _value.avatarIndex
          : avatarIndex // ignore: cast_nullable_to_non_nullable
              as int,
      ageGroup: null == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentUnit: null == currentUnit
          ? _value.currentUnit
          : currentUnit // ignore: cast_nullable_to_non_nullable
              as String,
      totalXP: null == totalXP
          ? _value.totalXP
          : totalXP // ignore: cast_nullable_to_non_nullable
              as int,
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChildProfileImplCopyWith<$Res>
    implements $ChildProfileCopyWith<$Res> {
  factory _$$ChildProfileImplCopyWith(
          _$ChildProfileImpl value, $Res Function(_$ChildProfileImpl) then) =
      __$$ChildProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int avatarIndex,
      String ageGroup,
      DateTime createdAt,
      String currentUnit,
      int totalXP,
      DateTime? lastSyncedAt});
}

/// @nodoc
class __$$ChildProfileImplCopyWithImpl<$Res>
    extends _$ChildProfileCopyWithImpl<$Res, _$ChildProfileImpl>
    implements _$$ChildProfileImplCopyWith<$Res> {
  __$$ChildProfileImplCopyWithImpl(
      _$ChildProfileImpl _value, $Res Function(_$ChildProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChildProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatarIndex = null,
    Object? ageGroup = null,
    Object? createdAt = null,
    Object? currentUnit = null,
    Object? totalXP = null,
    Object? lastSyncedAt = freezed,
  }) {
    return _then(_$ChildProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatarIndex: null == avatarIndex
          ? _value.avatarIndex
          : avatarIndex // ignore: cast_nullable_to_non_nullable
              as int,
      ageGroup: null == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentUnit: null == currentUnit
          ? _value.currentUnit
          : currentUnit // ignore: cast_nullable_to_non_nullable
              as String,
      totalXP: null == totalXP
          ? _value.totalXP
          : totalXP // ignore: cast_nullable_to_non_nullable
              as int,
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChildProfileImpl implements _ChildProfile {
  const _$ChildProfileImpl(
      {required this.id,
      required this.name,
      required this.avatarIndex,
      required this.ageGroup,
      required this.createdAt,
      required this.currentUnit,
      this.totalXP = 0,
      this.lastSyncedAt});

  factory _$ChildProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChildProfileImplFromJson(json);

  /// Unique identifier (UUID) for this child profile.
  @override
  final String id;

  /// Child's display name (chosen by parent).
  @override
  final String name;

  /// Index of the selected avatar (0-based).
  @override
  final int avatarIndex;

  /// Age group string: 'preschool3to5', 'emerging6to8', or 'independent9to10'.
  @override
  final String ageGroup;

  /// When the profile was created.
  @override
  final DateTime createdAt;

  /// Currently active unit ID (e.g., 'unit_01_alif').
  @override
  final String currentUnit;

  /// Total experience points earned across all activities.
  @override
  @JsonKey()
  final int totalXP;

  /// Timestamp of last sync to Firestore (null = never synced).
  @override
  final DateTime? lastSyncedAt;

  @override
  String toString() {
    return 'ChildProfile(id: $id, name: $name, avatarIndex: $avatarIndex, ageGroup: $ageGroup, createdAt: $createdAt, currentUnit: $currentUnit, totalXP: $totalXP, lastSyncedAt: $lastSyncedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChildProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarIndex, avatarIndex) ||
                other.avatarIndex == avatarIndex) &&
            (identical(other.ageGroup, ageGroup) ||
                other.ageGroup == ageGroup) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.currentUnit, currentUnit) ||
                other.currentUnit == currentUnit) &&
            (identical(other.totalXP, totalXP) || other.totalXP == totalXP) &&
            (identical(other.lastSyncedAt, lastSyncedAt) ||
                other.lastSyncedAt == lastSyncedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, avatarIndex, ageGroup,
      createdAt, currentUnit, totalXP, lastSyncedAt);

  /// Create a copy of ChildProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChildProfileImplCopyWith<_$ChildProfileImpl> get copyWith =>
      __$$ChildProfileImplCopyWithImpl<_$ChildProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChildProfileImplToJson(
      this,
    );
  }
}

abstract class _ChildProfile implements ChildProfile {
  const factory _ChildProfile(
      {required final String id,
      required final String name,
      required final int avatarIndex,
      required final String ageGroup,
      required final DateTime createdAt,
      required final String currentUnit,
      final int totalXP,
      final DateTime? lastSyncedAt}) = _$ChildProfileImpl;

  factory _ChildProfile.fromJson(Map<String, dynamic> json) =
      _$ChildProfileImpl.fromJson;

  /// Unique identifier (UUID) for this child profile.
  @override
  String get id;

  /// Child's display name (chosen by parent).
  @override
  String get name;

  /// Index of the selected avatar (0-based).
  @override
  int get avatarIndex;

  /// Age group string: 'preschool3to5', 'emerging6to8', or 'independent9to10'.
  @override
  String get ageGroup;

  /// When the profile was created.
  @override
  DateTime get createdAt;

  /// Currently active unit ID (e.g., 'unit_01_alif').
  @override
  String get currentUnit;

  /// Total experience points earned across all activities.
  @override
  int get totalXP;

  /// Timestamp of last sync to Firestore (null = never synced).
  @override
  DateTime? get lastSyncedAt;

  /// Create a copy of ChildProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChildProfileImplCopyWith<_$ChildProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
