import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faseeh_kids/features/stories/data/stories_data.dart';

final storiesProvider = Provider<List<Story>>((ref) {
  return storiesData;
});

class StoryProgressNotifier extends StateNotifier<int> {
  StoryProgressNotifier() : super(0);

  void updateProgress(int pageIndex) {
    state = pageIndex;
  }
}

final storyProgressProvider = StateNotifierProvider.family<StoryProgressNotifier, int, String>((ref, storyId) {
  return StoryProgressNotifier();
});
