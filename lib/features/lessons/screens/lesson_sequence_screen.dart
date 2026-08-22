import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/story_sequence_widget.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/short_vowels_sequence_widget.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/long_vowels_sequence_widget.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/trace_sequence_widget.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/words_sequence_widget.dart';

class LessonSequenceScreen extends ConsumerStatefulWidget {
  const LessonSequenceScreen({super.key});

  @override
  ConsumerState<LessonSequenceScreen> createState() => _LessonSequenceScreenState();
}

class _LessonSequenceScreenState extends ConsumerState<LessonSequenceScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPageIndex < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      // Finished sequence, return to Hub
      Navigator.of(context).pop();
    }
  }

  void _previousPage() {
    if (_currentPageIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final lessonState = ref.watch(currentLessonProvider);
    final letterChar = lessonState.letter?.letter ?? 'أ';

    return Scaffold(
      backgroundColor: AppColors.backgroundDay,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimaryDay),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'الدرس المتسلسل: حرف $letterChar',
          style: const TextStyle(
            color: AppColors.textPrimaryDay,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Force navigation via buttons
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: [
          StorySequenceWidget(onNext: _nextPage, letterChar: letterChar),
          ShortVowelsSequenceWidget(
            onNext: _nextPage,
            onPrevious: _previousPage,
            letterChar: letterChar,
            isActive: _currentPageIndex == 1,
          ),
          LongVowelsSequenceWidget(
            onNext: _nextPage,
            onPrevious: _previousPage,
            letterChar: letterChar,
            isActive: _currentPageIndex == 2,
          ),
          WordsSequenceWidget(
            onNext: _nextPage,
            onPrevious: _previousPage,
            letterChar: letterChar,
            isActive: _currentPageIndex == 3,
          ),
          TraceSequenceWidget(onNext: _nextPage, onPrevious: _previousPage, letterChar: letterChar),
        ],
      ),
    );
  }
}
