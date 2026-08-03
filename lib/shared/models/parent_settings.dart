import 'package:freezed_annotation/freezed_annotation.dart';

part 'parent_settings.freezed.dart';
part 'parent_settings.g.dart';

/// Parent settings model — parental controls and preferences
@freezed
class ParentSettings with _$ParentSettings {
  const factory ParentSettings({
    /// Parent identifier
    required String parentId,

    /// Whether sound effects are enabled
    @Default(true) bool soundEnabled,

    /// Whether background music is enabled
    @Default(true) bool bgmEnabled,

    /// Daily usage limit in minutes (0 = unlimited)
    @Default(30) int dailyLimitMinutes,

    /// Hashed PIN for parent gate (null = no PIN set)
    String? pinHash,
  }) = _ParentSettings;

  factory ParentSettings.fromJson(Map<String, dynamic> json) =>
      _$ParentSettingsFromJson(json);
}
