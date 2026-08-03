// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LessonProgressImpl _$$LessonProgressImplFromJson(Map<String, dynamic> json) =>
    _$LessonProgressImpl(
      lessonId: json['lessonId'] as String,
      status: $enumDecodeNullable(_$LessonStatusEnumMap, json['status']) ??
          LessonStatus.locked,
      attempts: (json['attempts'] as num?)?.toInt() ?? 0,
      bestScore: (json['bestScore'] as num?)?.toInt() ?? 0,
      starsEarned: (json['starsEarned'] as num?)?.toInt() ?? 0,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      xpEarned: (json['xpEarned'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$LessonProgressImplToJson(
        _$LessonProgressImpl instance) =>
    <String, dynamic>{
      'lessonId': instance.lessonId,
      'status': _$LessonStatusEnumMap[instance.status]!,
      'attempts': instance.attempts,
      'bestScore': instance.bestScore,
      'starsEarned': instance.starsEarned,
      'completedAt': instance.completedAt?.toIso8601String(),
      'xpEarned': instance.xpEarned,
    };

const _$LessonStatusEnumMap = {
  LessonStatus.locked: 'locked',
  LessonStatus.available: 'available',
  LessonStatus.inProgress: 'in_progress',
  LessonStatus.completed: 'completed',
  LessonStatus.mastered: 'mastered',
};
