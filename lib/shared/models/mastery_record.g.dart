// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastery_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MasteryRecordImpl _$$MasteryRecordImplFromJson(Map<String, dynamic> json) =>
    _$MasteryRecordImpl(
      skillId: json['skillId'] as String,
      level: $enumDecodeNullable(_$MasteryLevelEnumMap, json['level']) ??
          MasteryLevel.newSkill,
      consecutiveCorrect: (json['consecutiveCorrect'] as num?)?.toInt() ?? 0,
      lastPracticed: DateTime.parse(json['lastPracticed'] as String),
      nextReview: DateTime.parse(json['nextReview'] as String),
      easeFactor: (json['easeFactor'] as num?)?.toDouble() ?? 2.5,
      intervalDays: (json['intervalDays'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$MasteryRecordImplToJson(_$MasteryRecordImpl instance) =>
    <String, dynamic>{
      'skillId': instance.skillId,
      'level': _$MasteryLevelEnumMap[instance.level]!,
      'consecutiveCorrect': instance.consecutiveCorrect,
      'lastPracticed': instance.lastPracticed.toIso8601String(),
      'nextReview': instance.nextReview.toIso8601String(),
      'easeFactor': instance.easeFactor,
      'intervalDays': instance.intervalDays,
    };

const _$MasteryLevelEnumMap = {
  MasteryLevel.newSkill: 'new',
  MasteryLevel.learning: 'learning',
  MasteryLevel.practiced: 'practiced',
  MasteryLevel.mastered: 'mastered',
  MasteryLevel.reinforced: 'reinforced',
};
