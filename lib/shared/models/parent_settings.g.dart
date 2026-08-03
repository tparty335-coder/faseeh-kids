// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParentSettingsImpl _$$ParentSettingsImplFromJson(Map<String, dynamic> json) =>
    _$ParentSettingsImpl(
      parentId: json['parentId'] as String,
      soundEnabled: json['soundEnabled'] as bool? ?? true,
      bgmEnabled: json['bgmEnabled'] as bool? ?? true,
      dailyLimitMinutes: (json['dailyLimitMinutes'] as num?)?.toInt() ?? 30,
      pinHash: json['pinHash'] as String?,
    );

Map<String, dynamic> _$$ParentSettingsImplToJson(
        _$ParentSettingsImpl instance) =>
    <String, dynamic>{
      'parentId': instance.parentId,
      'soundEnabled': instance.soundEnabled,
      'bgmEnabled': instance.bgmEnabled,
      'dailyLimitMinutes': instance.dailyLimitMinutes,
      'pinHash': instance.pinHash,
    };
