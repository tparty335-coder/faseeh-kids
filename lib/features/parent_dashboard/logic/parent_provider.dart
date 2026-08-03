import 'package:flutter_riverpod/flutter_riverpod.dart';

// Mocks to allow compilation if models are missing
class ParentSettings {
  final int dailyTimeLimit;
  final bool soundEnabled;
  final bool musicEnabled;
  final bool nightMode;

  const ParentSettings({
    this.dailyTimeLimit = 30,
    this.soundEnabled = true,
    this.musicEnabled = true,
    this.nightMode = false,
  });

  ParentSettings copyWith({
    int? dailyTimeLimit,
    bool? soundEnabled,
    bool? musicEnabled,
    bool? nightMode,
  }) {
    return ParentSettings(
      dailyTimeLimit: dailyTimeLimit ?? this.dailyTimeLimit,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      musicEnabled: musicEnabled ?? this.musicEnabled,
      nightMode: nightMode ?? this.nightMode,
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
    return const ParentSettings();
  }

  void updateSettings(ParentSettings settings) {
    state = settings;
    // TODO: Save to Hive
  }
}

final parentSettingsProvider = NotifierProvider<ParentSettingsNotifier, ParentSettings>(
  () => ParentSettingsNotifier(),
);

final childProfilesProvider = StateProvider<List<ChildProfile>>((ref) {
  return [
    const ChildProfile(id: '1', name: 'أحمد', age: 6, avatar: 'avatar1.png'),
  ];
});

final weeklyStatsProvider = Provider<List<double>>((ref) {
  return [15, 20, 0, 30, 45, 10, 0]; // Sat-Fri dummy data
});

final letterMasteryGridProvider = Provider<Map<String, double>>((ref) {
  final letters = 'أبتثجحخدذرزسشصضطظعغفقكلمنهوي';
  final map = <String, double>{};
  for (int i = 0; i < letters.length; i++) {
    map[letters[i]] = (i % 3) * 0.5; // 0.0, 0.5, 1.0 dummy data
  }
  return map;
});
