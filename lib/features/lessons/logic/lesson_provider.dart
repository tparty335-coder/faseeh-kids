import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faseeh_kids/features/lessons/data/arabic_letters_data.dart';

enum LessonActivity { listen, trace, words, positions, longVowels, phrases, quiz }

class LessonState {
  final ArabicLetter? letter;
  final LessonActivity currentActivity;
  final int completedActivities;

  const LessonState({
    this.letter,
    this.currentActivity = LessonActivity.listen,
    this.completedActivities = 0,
  });

  LessonState copyWith({
    ArabicLetter? letter,
    LessonActivity? currentActivity,
    int? completedActivities,
  }) {
    return LessonState(
      letter: letter ?? this.letter,
      currentActivity: currentActivity ?? this.currentActivity,
      completedActivities: completedActivities ?? this.completedActivities,
    );
  }
}

class LessonNotifier extends StateNotifier<LessonState> {
  LessonNotifier() : super(const LessonState());

  void setLetter(ArabicLetter letter) {
    state = LessonState(letter: letter, currentActivity: LessonActivity.listen, completedActivities: 0);
  }

  void setActivity(LessonActivity activity) {
    state = state.copyWith(currentActivity: activity);
  }

  void completeCurrentActivity() {
    state = state.copyWith(completedActivities: state.completedActivities + 1);
  }
  
  void nextActivity() {
    int nextIndex = state.currentActivity.index + 1;
    if (nextIndex < LessonActivity.values.length) {
      state = state.copyWith(currentActivity: LessonActivity.values[nextIndex]);
    }
  }
}

final currentLessonProvider = StateNotifierProvider<LessonNotifier, LessonState>((ref) {
  return LessonNotifier();
});

final lessonProgressProvider = Provider<double>((ref) {
  final state = ref.watch(currentLessonProvider);
  return state.completedActivities / LessonActivity.values.length;
});

final activityResultProvider = StateProvider<bool?>((ref) => null);
