import 'package:hive/hive.dart';
import 'package:faseeh_kids/shared/models/child_profile.dart';
import 'package:faseeh_kids/shared/models/lesson_progress.dart';
import 'package:faseeh_kids/shared/models/activity_result.dart';
import 'package:faseeh_kids/shared/models/mastery_record.dart';
import 'package:faseeh_kids/shared/models/streak_data.dart';
import 'package:faseeh_kids/shared/models/story_progress.dart';
import 'package:faseeh_kids/shared/models/parent_settings.dart';
import 'package:faseeh_kids/shared/models/sync_queue_item.dart';

/// Manual Hive TypeAdapters for all data models
/// TypeIds: 0-7 (reserved range for core models)

// ══════════════════════════════════════════════
// TypeId 0: ChildProfile
// ══════════════════════════════════════════════
class ChildProfileAdapter extends TypeAdapter<ChildProfile> {
  @override
  final int typeId = 0;

  @override
  ChildProfile read(BinaryReader reader) {
    final map = reader.readMap().cast<String, dynamic>();
    return ChildProfile(
      id: map['id'] as String,
      name: map['name'] as String,
      avatarIndex: map['avatarIndex'] as int,
      ageGroup: map['ageGroup'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      currentUnit: map['currentUnit'] as String? ?? 'unit_01_alif',
      totalXP: map['totalXP'] as int? ?? 0,
    );
  }

  @override
  void write(BinaryWriter writer, ChildProfile obj) {
    writer.writeMap({
      'id': obj.id,
      'name': obj.name,
      'avatarIndex': obj.avatarIndex,
      'ageGroup': obj.ageGroup,
      'createdAt': obj.createdAt.toIso8601String(),
      'currentUnit': obj.currentUnit,
      'totalXP': obj.totalXP,
    });
  }
}

// ══════════════════════════════════════════════
// TypeId 1: LessonProgress
// ══════════════════════════════════════════════
class LessonProgressAdapter extends TypeAdapter<LessonProgress> {
  @override
  final int typeId = 1;

  @override
  LessonProgress read(BinaryReader reader) {
    final map = reader.readMap().cast<String, dynamic>();
    return LessonProgress(
      lessonId: map['lessonId'] as String,
      status: LessonStatus.values.firstWhere(
        (e) => e.name == (map['status'] as String? ?? 'locked'),
        orElse: () => LessonStatus.locked,
      ),
      attempts: map['attempts'] as int? ?? 0,
      bestScore: map['bestScore'] as int? ?? 0,
      starsEarned: map['starsEarned'] as int? ?? 0,
      completedAt: map['completedAt'] != null
          ? DateTime.parse(map['completedAt'] as String)
          : null,
      xpEarned: map['xpEarned'] as int? ?? 0,
    );
  }

  @override
  void write(BinaryWriter writer, LessonProgress obj) {
    writer.writeMap({
      'lessonId': obj.lessonId,
      'status': obj.status.name,
      'attempts': obj.attempts,
      'bestScore': obj.bestScore,
      'starsEarned': obj.starsEarned,
      'completedAt': obj.completedAt?.toIso8601String(),
      'xpEarned': obj.xpEarned,
    });
  }
}

// ══════════════════════════════════════════════
// TypeId 2: ActivityResult
// ══════════════════════════════════════════════
class ActivityResultAdapter extends TypeAdapter<ActivityResult> {
  @override
  final int typeId = 2;

  @override
  ActivityResult read(BinaryReader reader) {
    final map = reader.readMap().cast<String, dynamic>();
    return ActivityResult(
      activityId: map['activityId'] as String,
      type: ActivityType.values.firstWhere(
        (e) => e.name == (map['type'] as String? ?? 'phonemeListen'),
        orElse: () => ActivityType.phonemeListen,
      ),
      correct: map['correct'] as bool? ?? false,
      timeSpentMs: map['timeSpentMs'] as int? ?? 0,
      attempts: map['attempts'] as int? ?? 1,
      completedAt: DateTime.parse(
        map['completedAt'] as String? ?? DateTime.now().toIso8601String(),
      ),
      targetLetter: map['targetLetter'] as String?,
      hintsUsed: map['hintsUsed'] as int? ?? 0,
    );
  }

  @override
  void write(BinaryWriter writer, ActivityResult obj) {
    writer.writeMap({
      'activityId': obj.activityId,
      'type': obj.type.name,
      'correct': obj.correct,
      'timeSpentMs': obj.timeSpentMs,
      'attempts': obj.attempts,
      'completedAt': obj.completedAt.toIso8601String(),
      'targetLetter': obj.targetLetter,
      'hintsUsed': obj.hintsUsed,
    });
  }
}

// ══════════════════════════════════════════════
// TypeId 3: MasteryRecord
// ══════════════════════════════════════════════
class MasteryRecordAdapter extends TypeAdapter<MasteryRecord> {
  @override
  final int typeId = 3;

  @override
  MasteryRecord read(BinaryReader reader) {
    final map = reader.readMap().cast<String, dynamic>();
    return MasteryRecord(
      skillId: map['skillId'] as String,
      level: MasteryLevel.values.firstWhere(
        (e) => e.name == (map['level'] as String? ?? 'newSkill'),
        orElse: () => MasteryLevel.newSkill,
      ),
      consecutiveCorrect: map['consecutiveCorrect'] as int? ?? 0,
      lastPracticed: DateTime.parse(map['lastPracticed'] as String),
      nextReview: DateTime.parse(map['nextReview'] as String),
      easeFactor: (map['easeFactor'] as num?)?.toDouble() ?? 2.5,
      intervalDays: map['intervalDays'] as int? ?? 1,
    );
  }

  @override
  void write(BinaryWriter writer, MasteryRecord obj) {
    writer.writeMap({
      'skillId': obj.skillId,
      'level': obj.level.name,
      'consecutiveCorrect': obj.consecutiveCorrect,
      'lastPracticed': obj.lastPracticed.toIso8601String(),
      'nextReview': obj.nextReview.toIso8601String(),
      'easeFactor': obj.easeFactor,
      'intervalDays': obj.intervalDays,
    });
  }
}

// ══════════════════════════════════════════════
// TypeId 4: StreakData
// ══════════════════════════════════════════════
class StreakDataAdapter extends TypeAdapter<StreakData> {
  @override
  final int typeId = 4;

  @override
  StreakData read(BinaryReader reader) {
    final map = reader.readMap().cast<String, dynamic>();
    return StreakData(
      currentStreak: map['currentStreak'] as int? ?? 0,
      longestStreak: map['longestStreak'] as int? ?? 0,
      lastActiveDate: DateTime.parse(map['lastActiveDate'] as String),
    );
  }

  @override
  void write(BinaryWriter writer, StreakData obj) {
    writer.writeMap({
      'currentStreak': obj.currentStreak,
      'longestStreak': obj.longestStreak,
      'lastActiveDate': obj.lastActiveDate.toIso8601String(),
    });
  }
}

// ══════════════════════════════════════════════
// TypeId 5: StoryProgress
// ══════════════════════════════════════════════
class StoryProgressAdapter extends TypeAdapter<StoryProgress> {
  @override
  final int typeId = 5;

  @override
  StoryProgress read(BinaryReader reader) {
    final map = reader.readMap().cast<String, dynamic>();
    return StoryProgress(
      storyId: map['storyId'] as String,
      currentPage: map['currentPage'] as int? ?? 0,
      isCompleted: map['isCompleted'] as bool? ?? false,
      lastRead: map['lastRead'] != null
          ? DateTime.parse(map['lastRead'] as String)
          : null,
    );
  }

  @override
  void write(BinaryWriter writer, StoryProgress obj) {
    writer.writeMap({
      'storyId': obj.storyId,
      'currentPage': obj.currentPage,
      'isCompleted': obj.isCompleted,
      'lastRead': obj.lastRead?.toIso8601String(),
    });
  }
}

// ══════════════════════════════════════════════
// TypeId 6: ParentSettings
// ══════════════════════════════════════════════
class ParentSettingsAdapter extends TypeAdapter<ParentSettings> {
  @override
  final int typeId = 6;

  @override
  ParentSettings read(BinaryReader reader) {
    final map = reader.readMap().cast<String, dynamic>();
    return ParentSettings(
      parentId: map['parentId'] as String,
      soundEnabled: map['soundEnabled'] as bool? ?? true,
      bgmEnabled: map['bgmEnabled'] as bool? ?? true,
      dailyLimitMinutes: map['dailyLimitMinutes'] as int? ?? 30,
      pinHash: map['pinHash'] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ParentSettings obj) {
    writer.writeMap({
      'parentId': obj.parentId,
      'soundEnabled': obj.soundEnabled,
      'bgmEnabled': obj.bgmEnabled,
      'dailyLimitMinutes': obj.dailyLimitMinutes,
      'pinHash': obj.pinHash,
    });
  }
}

// ══════════════════════════════════════════════
// TypeId 7: SyncQueueItem
// ══════════════════════════════════════════════
class SyncQueueItemAdapter extends TypeAdapter<SyncQueueItem> {
  @override
  final int typeId = 7;

  @override
  SyncQueueItem read(BinaryReader reader) {
    final map = reader.readMap().cast<String, dynamic>();
    return SyncQueueItem(
      id: map['id'] as String,
      collection: map['collection'] as String,
      documentId: map['documentId'] as String,
      data: (map['data'] as Map).cast<String, dynamic>(),
      timestamp: DateTime.parse(map['timestamp'] as String),
      synced: map['synced'] as bool? ?? false,
    );
  }

  @override
  void write(BinaryWriter writer, SyncQueueItem obj) {
    writer.writeMap({
      'id': obj.id,
      'collection': obj.collection,
      'documentId': obj.documentId,
      'data': obj.data,
      'timestamp': obj.timestamp.toIso8601String(),
      'synced': obj.synced,
    });
  }
}
