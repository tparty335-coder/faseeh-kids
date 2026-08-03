// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parent_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ParentSettings _$ParentSettingsFromJson(Map<String, dynamic> json) {
  return _ParentSettings.fromJson(json);
}

/// @nodoc
mixin _$ParentSettings {
  /// Parent identifier
  String get parentId => throw _privateConstructorUsedError;

  /// Whether sound effects are enabled
  bool get soundEnabled => throw _privateConstructorUsedError;

  /// Whether background music is enabled
  bool get bgmEnabled => throw _privateConstructorUsedError;

  /// Daily usage limit in minutes (0 = unlimited)
  int get dailyLimitMinutes => throw _privateConstructorUsedError;

  /// Hashed PIN for parent gate (null = no PIN set)
  String? get pinHash => throw _privateConstructorUsedError;

  /// Serializes this ParentSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParentSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParentSettingsCopyWith<ParentSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParentSettingsCopyWith<$Res> {
  factory $ParentSettingsCopyWith(
          ParentSettings value, $Res Function(ParentSettings) then) =
      _$ParentSettingsCopyWithImpl<$Res, ParentSettings>;
  @useResult
  $Res call(
      {String parentId,
      bool soundEnabled,
      bool bgmEnabled,
      int dailyLimitMinutes,
      String? pinHash});
}

/// @nodoc
class _$ParentSettingsCopyWithImpl<$Res, $Val extends ParentSettings>
    implements $ParentSettingsCopyWith<$Res> {
  _$ParentSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParentSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parentId = null,
    Object? soundEnabled = null,
    Object? bgmEnabled = null,
    Object? dailyLimitMinutes = null,
    Object? pinHash = freezed,
  }) {
    return _then(_value.copyWith(
      parentId: null == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String,
      soundEnabled: null == soundEnabled
          ? _value.soundEnabled
          : soundEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      bgmEnabled: null == bgmEnabled
          ? _value.bgmEnabled
          : bgmEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      dailyLimitMinutes: null == dailyLimitMinutes
          ? _value.dailyLimitMinutes
          : dailyLimitMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      pinHash: freezed == pinHash
          ? _value.pinHash
          : pinHash // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ParentSettingsImplCopyWith<$Res>
    implements $ParentSettingsCopyWith<$Res> {
  factory _$$ParentSettingsImplCopyWith(_$ParentSettingsImpl value,
          $Res Function(_$ParentSettingsImpl) then) =
      __$$ParentSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String parentId,
      bool soundEnabled,
      bool bgmEnabled,
      int dailyLimitMinutes,
      String? pinHash});
}

/// @nodoc
class __$$ParentSettingsImplCopyWithImpl<$Res>
    extends _$ParentSettingsCopyWithImpl<$Res, _$ParentSettingsImpl>
    implements _$$ParentSettingsImplCopyWith<$Res> {
  __$$ParentSettingsImplCopyWithImpl(
      _$ParentSettingsImpl _value, $Res Function(_$ParentSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ParentSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parentId = null,
    Object? soundEnabled = null,
    Object? bgmEnabled = null,
    Object? dailyLimitMinutes = null,
    Object? pinHash = freezed,
  }) {
    return _then(_$ParentSettingsImpl(
      parentId: null == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String,
      soundEnabled: null == soundEnabled
          ? _value.soundEnabled
          : soundEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      bgmEnabled: null == bgmEnabled
          ? _value.bgmEnabled
          : bgmEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      dailyLimitMinutes: null == dailyLimitMinutes
          ? _value.dailyLimitMinutes
          : dailyLimitMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      pinHash: freezed == pinHash
          ? _value.pinHash
          : pinHash // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParentSettingsImpl implements _ParentSettings {
  const _$ParentSettingsImpl(
      {required this.parentId,
      this.soundEnabled = true,
      this.bgmEnabled = true,
      this.dailyLimitMinutes = 30,
      this.pinHash});

  factory _$ParentSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParentSettingsImplFromJson(json);

  /// Parent identifier
  @override
  final String parentId;

  /// Whether sound effects are enabled
  @override
  @JsonKey()
  final bool soundEnabled;

  /// Whether background music is enabled
  @override
  @JsonKey()
  final bool bgmEnabled;

  /// Daily usage limit in minutes (0 = unlimited)
  @override
  @JsonKey()
  final int dailyLimitMinutes;

  /// Hashed PIN for parent gate (null = no PIN set)
  @override
  final String? pinHash;

  @override
  String toString() {
    return 'ParentSettings(parentId: $parentId, soundEnabled: $soundEnabled, bgmEnabled: $bgmEnabled, dailyLimitMinutes: $dailyLimitMinutes, pinHash: $pinHash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParentSettingsImpl &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.soundEnabled, soundEnabled) ||
                other.soundEnabled == soundEnabled) &&
            (identical(other.bgmEnabled, bgmEnabled) ||
                other.bgmEnabled == bgmEnabled) &&
            (identical(other.dailyLimitMinutes, dailyLimitMinutes) ||
                other.dailyLimitMinutes == dailyLimitMinutes) &&
            (identical(other.pinHash, pinHash) || other.pinHash == pinHash));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, parentId, soundEnabled,
      bgmEnabled, dailyLimitMinutes, pinHash);

  /// Create a copy of ParentSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParentSettingsImplCopyWith<_$ParentSettingsImpl> get copyWith =>
      __$$ParentSettingsImplCopyWithImpl<_$ParentSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParentSettingsImplToJson(
      this,
    );
  }
}

abstract class _ParentSettings implements ParentSettings {
  const factory _ParentSettings(
      {required final String parentId,
      final bool soundEnabled,
      final bool bgmEnabled,
      final int dailyLimitMinutes,
      final String? pinHash}) = _$ParentSettingsImpl;

  factory _ParentSettings.fromJson(Map<String, dynamic> json) =
      _$ParentSettingsImpl.fromJson;

  /// Parent identifier
  @override
  String get parentId;

  /// Whether sound effects are enabled
  @override
  bool get soundEnabled;

  /// Whether background music is enabled
  @override
  bool get bgmEnabled;

  /// Daily usage limit in minutes (0 = unlimited)
  @override
  int get dailyLimitMinutes;

  /// Hashed PIN for parent gate (null = no PIN set)
  @override
  String? get pinHash;

  /// Create a copy of ParentSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParentSettingsImplCopyWith<_$ParentSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
