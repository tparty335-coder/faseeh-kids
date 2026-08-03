// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityResultImpl _$$ActivityResultImplFromJson(Map<String, dynamic> json) =>
    _$ActivityResultImpl(
      activityId: json['activityId'] as String,
      type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
      correct: json['correct'] as bool,
      timeSpentMs: (json['timeSpentMs'] as num).toInt(),
      attempts: (json['attempts'] as num?)?.toInt() ?? 1,
      completedAt: DateTime.parse(json['completedAt'] as String),
      targetLetter: json['targetLetter'] as String?,
      hintsUsed: (json['hintsUsed'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ActivityResultImplToJson(
        _$ActivityResultImpl instance) =>
    <String, dynamic>{
      'activityId': instance.activityId,
      'type': _$ActivityTypeEnumMap[instance.type]!,
      'correct': instance.correct,
      'timeSpentMs': instance.timeSpentMs,
      'attempts': instance.attempts,
      'completedAt': instance.completedAt.toIso8601String(),
      'targetLetter': instance.targetLetter,
      'hintsUsed': instance.hintsUsed,
    };

const _$ActivityTypeEnumMap = {
  ActivityType.phonemeListen: 'phoneme_listen',
  ActivityType.letterTrace: 'letter_trace',
  ActivityType.letterMatch: 'letter_match',
  ActivityType.wordBuild: 'word_build',
  ActivityType.picturePick: 'picture_pick',
  ActivityType.diacriticsSort: 'diacritics_sort',
  ActivityType.sentenceOrder: 'sentence_order',
  ActivityType.storyListen: 'story_listen',
  ActivityType.fillBlank: 'fill_blank',
  ActivityType.recordSpeak: 'record_speak',
  ActivityType.dragDrop: 'drag_drop',
  ActivityType.colorLetter: 'color_letter',
};
