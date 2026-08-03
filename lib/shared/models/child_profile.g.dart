// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChildProfileImpl _$$ChildProfileImplFromJson(Map<String, dynamic> json) =>
    _$ChildProfileImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarIndex: (json['avatarIndex'] as num).toInt(),
      ageGroup: json['ageGroup'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      currentUnit: json['currentUnit'] as String,
      totalXP: (json['totalXP'] as num?)?.toInt() ?? 0,
      lastSyncedAt: json['lastSyncedAt'] == null
          ? null
          : DateTime.parse(json['lastSyncedAt'] as String),
    );

Map<String, dynamic> _$$ChildProfileImplToJson(_$ChildProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarIndex': instance.avatarIndex,
      'ageGroup': instance.ageGroup,
      'createdAt': instance.createdAt.toIso8601String(),
      'currentUnit': instance.currentUnit,
      'totalXP': instance.totalXP,
      'lastSyncedAt': instance.lastSyncedAt?.toIso8601String(),
    };
