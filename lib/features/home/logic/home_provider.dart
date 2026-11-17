import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:faseeh_kids/core/utils/constants.dart';
import 'package:faseeh_kids/features/lessons/data/arabic_letters_data.dart';
import 'package:faseeh_kids/features/parent_dashboard/logic/parent_provider.dart';

/// Current active child profile name
final currentChildProvider = Provider<String>((ref) {
  try {
    if (Hive.isBoxOpen(AppConstants.childProfileBox)) {
      final box = Hive.box(AppConstants.childProfileBox);
      return (box.get('child_name', defaultValue: 'بطل فصيح') as String?) ?? 'بطل فصيح';
    }
  } catch (_) {}
  return 'بطل فصيح';
});

/// Progress Notifier — manages which letters are unlocked sequentially
/// Reads from / writes to Hive for persistence across sessions
class ProgressNotifier extends Notifier<List<String>> {
  static const String _hiveKey = 'unlocked_units';

  @override
  List<String> build() {
    final unlockAll = ref.watch(
      parentSettingsProvider.select((s) => s.unlockAllLettersForReview),
    );
    final allLetterChars = arabicLetters.map((l) => l.letter).toList();
    if (unlockAll) {
      return allLetterChars;
    }

    try {
      if (Hive.isBoxOpen(AppConstants.lessonProgressBox)) {
        final box = Hive.box(AppConstants.lessonProgressBox);
        final stored = box.get(_hiveKey);
        if (stored != null && stored is List && stored.isNotEmpty) {
          return List<String>.from(stored);
        }
      }
    } catch (_) {}

    // Default sequential start: first letter (أ) is unlocked
    return [arabicLetters.first.letter];
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

  /// Unlock letters up to a specific index (e.g., from placement test)
  void unlockUpTo(int index) {
    final allLetters = arabicLetters.map((l) => l.letter).toList();
    final unlocked = allLetters.sublist(0, (index + 1).clamp(1, allLetters.length));
    state = unlocked;
    _persist();
  }

  /// Unlock all 28 letters
  void unlockAll() {
    state = arabicLetters.map((l) => l.letter).toList();
    _persist();
  }

  /// Reset all progress back to letter Alif
  void reset() {
    state = [arabicLetters.first.letter];
    _persist();
  }

  /// Persist to Hive
  void _persist() {
    try {
      if (Hive.isBoxOpen(AppConstants.lessonProgressBox)) {
        final box = Hive.box(AppConstants.lessonProgressBox);
        box.put(_hiveKey, state);
      }
    } catch (_) {}
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
