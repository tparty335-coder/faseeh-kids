import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:faseeh_kids/core/utils/constants.dart';
import 'package:faseeh_kids/features/home/logic/home_provider.dart';
import 'package:faseeh_kids/features/lessons/data/arabic_letters_data.dart';
import 'package:faseeh_kids/services/audio_manager.dart';

class ParentSettings {
  final int dailyTimeLimit;
  final bool soundEnabled;
  final bool musicEnabled;
  final bool nightMode;
  final bool unlockAllLettersForReview;

  const ParentSettings({
    this.dailyTimeLimit = 30,
    this.soundEnabled = true,
    this.musicEnabled = true,
    this.nightMode = false,
    // مراجعة مؤقتة: جميع المراحل مفتوحة للمعاينة. للإنتاج أعدها إلى false.
    this.unlockAllLettersForReview = false,
  });

  ParentSettings copyWith({
    int? dailyTimeLimit,
    bool? soundEnabled,
    bool? musicEnabled,
    bool? nightMode,
    bool? unlockAllLettersForReview,
  }) {
    return ParentSettings(
      dailyTimeLimit: dailyTimeLimit ?? this.dailyTimeLimit,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      musicEnabled: musicEnabled ?? this.musicEnabled,
      nightMode: nightMode ?? this.nightMode,
      unlockAllLettersForReview:
          unlockAllLettersForReview ?? this.unlockAllLettersForReview,
    );
  }
}

class ChildProfile {
  final String id;
  final String name;
  final int age;
  final String avatar;

  const ChildProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.avatar,
  });
}

class ParentSettingsNotifier extends Notifier<ParentSettings> {
  @override
  ParentSettings build() {
    try {
      if (Hive.isBoxOpen(AppConstants.parentSettingsBox)) {
        final box = Hive.box(AppConstants.parentSettingsBox);
        if (box.get('unlockedAllForReviewV1') != true) {
          box.put('unlockAllLettersForReview', false);
          box.put('unlockedAllForReviewV1', true);
        }
        final settings = ParentSettings(
          dailyTimeLimit: (box.get('dailyTimeLimit', defaultValue: 30) as int?) ?? 30,
          soundEnabled: (box.get('soundEnabled', defaultValue: true) as bool?) ?? true,
          musicEnabled: (box.get('musicEnabled', defaultValue: true) as bool?) ?? true,
          nightMode: (box.get('nightMode', defaultValue: false) as bool?) ?? false,
          unlockAllLettersForReview:
              (box.get('unlockAllLettersForReview', defaultValue: false) as bool?) ?? false,
        );
        AudioManager.instance.setSoundEnabled(settings.soundEnabled);
        return settings;
      }
    } catch (_) {}
    return const ParentSettings();
  }

  void updateSettings(ParentSettings settings) {
    state = settings;
    AudioManager.instance.setSoundEnabled(settings.soundEnabled);
    try {
      if (Hive.isBoxOpen(AppConstants.parentSettingsBox)) {
        final box = Hive.box(AppConstants.parentSettingsBox);
        box.put('dailyTimeLimit', settings.dailyTimeLimit);
        box.put('soundEnabled', settings.soundEnabled);
        box.put('musicEnabled', settings.musicEnabled);
        box.put('nightMode', settings.nightMode);
        box.put('unlockAllLettersForReview', settings.unlockAllLettersForReview);
      }
    } catch (_) {}
  }
}

final parentSettingsProvider = NotifierProvider<ParentSettingsNotifier, ParentSettings>(
  ParentSettingsNotifier.new,
);

final childProfilesProvider = StateProvider<List<ChildProfile>>((ref) {
  try {
    if (Hive.isBoxOpen(AppConstants.childProfileBox)) {
      final box = Hive.box(AppConstants.childProfileBox);
      final name = (box.get('child_name', defaultValue: 'بطل فصيح') as String?) ?? 'بطل فصيح';
      final age = (box.get('child_age', defaultValue: 6) as int?) ?? 6;
      final avatarIdx = (box.get('avatar_index', defaultValue: 0) as int?) ?? 0;
      return [
        ChildProfile(id: '1', name: name, age: age, avatar: 'avatar_${avatarIdx + 1}.webp'),
      ];
    }
  } catch (_) {}
  return const [
    ChildProfile(id: '1', name: 'بطل فصيح', age: 6, avatar: 'avatar_1.webp'),
  ];
});

final weeklyStatsProvider = Provider<List<double>>((ref) {
  final unlocked = ref.watch(unlockedUnitsProvider).length;
  final base = (unlocked * 5.0).clamp(10.0, 45.0);
  return [base, base + 5, 15, base, base + 10, 20, 15];
});

final letterMasteryGridProvider = Provider<Map<String, double>>((ref) {
  final unlocked = ref.watch(unlockedUnitsProvider);
  final map = <String, double>{};
  for (final l in arabicLetters) {
    if (unlocked.contains(l.letter)) {
      map[l.letter] = unlocked.last == l.letter ? 0.6 : 1.0;
    } else {
      map[l.letter] = 0.0;
    }
  }
  return map;
});
