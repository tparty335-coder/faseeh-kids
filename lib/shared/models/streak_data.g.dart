// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StreakDataImpl _$$StreakDataImplFromJson(Map<String, dynamic> json) =>
    _$StreakDataImpl(
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
      lastActiveDate: DateTime.parse(json['lastActiveDate'] as String),
      totalActiveDays: (json['totalActiveDays'] as num?)?.toInt() ?? 0,
      todayCompleted: json['todayCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$StreakDataImplToJson(_$StreakDataImpl instance) =>
    <String, dynamic>{
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'lastActiveDate': instance.lastActiveDate.toIso8601String(),
      'totalActiveDays': instance.totalActiveDays,
      'todayCompleted': instance.todayCompleted,
    };
