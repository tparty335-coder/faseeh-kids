import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:faseeh_kids/core/utils/constants.dart';
import 'package:faseeh_kids/features/lessons/data/arabic_letters_data.dart';

/// Current active child profile name
final currentChildProvider = Provider<String>((ref) {
  final box = Hive.box(AppConstants.childProfileBox);
  return box.get('activeChild', defaultValue: 'طفل_1') as String;
});

/// Progress Notifier — manages which letters are unlocked
/// Reads from / writes to Hive for persistence across sessions
class ProgressNotifier extends Notifier<List<String>> {
  static const String _hiveKey = 'unlocked_units';

  @override
  List<String> build() {
    final box = Hive.box(AppConstants.lessonProgressBox);
    final stored = box.get(_hiveKey);
    if (stored != null && stored is List) {
      final list = List<String>.from(stored);
      if (!list.contains('أ')) list.insert(0, 'أ');
      if (!list.contains('ب')) list.add('ب');
      return list;
    }
    // Default unlocked letters: 'أ' and 'ب'
    return ['أ', 'ب'];
  }

  /// Unlock the next letter after completing a lesson
  void unlockNext(String completedLetter) {
    final allLetters = arabicLetters.map((l) => l.letter).toList();
    final currentIndex = allLetters.indexOf(completedLetter);

    if (currentIndex >= 0 && currentIndex < allLetters.length - 1) {
      final nextLetter = allLetters[currentIndex + 1];
      if (!state.contains(nextLetter)) {
        state = [...state, nextLetter];
        _persist();
      }
    }
  }

  /// Unlock a specific letter (e.g., from placement test)
  void unlockUpTo(int index) {
    final allLetters = arabicLetters.map((l) => l.letter).toList();
    final unlocked = allLetters.sublist(0, (index + 1).clamp(1, allLetters.length));
    state = unlocked;
    _persist();
  }

  /// Reset all progress
  void reset() {
    state = [arabicLetters.first.letter];
    _persist();
  }

  /// Persist to Hive
  void _persist() {
    final box = Hive.box(AppConstants.lessonProgressBox);
    box.put(_hiveKey, state);
  }
}

/// Provider for unlocked units — persisted in Hive
final unlockedUnitsProvider =
    NotifierProvider<ProgressNotifier, List<String>>(ProgressNotifier.new);

/// Current active unit (the last unlocked letter)
final currentUnitProvider = Provider<String>((ref) {
  final unlocked = ref.watch(unlockedUnitsProvider);
  return unlocked.isNotEmpty ? unlocked.last : arabicLetters.first.letter;
});

/// Bottom navigation bar index
final homeNavIndexProvider = StateProvider<int>((ref) => 0);
