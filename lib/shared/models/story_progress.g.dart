// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryProgressImpl _$$StoryProgressImplFromJson(Map<String, dynamic> json) =>
    _$StoryProgressImpl(
      storyId: json['storyId'] as String,
      currentPage: (json['currentPage'] as num?)?.toInt() ?? 0,
      isCompleted: json['isCompleted'] as bool? ?? false,
      lastRead: json['lastRead'] == null
          ? null
          : DateTime.parse(json['lastRead'] as String),
    );

Map<String, dynamic> _$$StoryProgressImplToJson(_$StoryProgressImpl instance) =>
    <String, dynamic>{
      'storyId': instance.storyId,
      'currentPage': instance.currentPage,
      'isCompleted': instance.isCompleted,
      'lastRead': instance.lastRead?.toIso8601String(),
    };
