import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/features/home/logic/home_provider.dart';
import 'package:faseeh_kids/features/lessons/data/arabic_letters_data.dart';
import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:faseeh_kids/services/audio_registry.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/story_sequence_widget.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/short_vowels_sequence_widget.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/long_vowels_sequence_widget.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/words_sequence_widget.dart';
import 'package:faseeh_kids/features/lessons/screens/sequence_widgets/trace_sequence_widget.dart';

class LessonSequenceScreen extends ConsumerStatefulWidget {
  const LessonSequenceScreen({super.key});

  @override
  ConsumerState<LessonSequenceScreen> createState() => _LessonSequenceScreenState();
}

class _LessonSequenceScreenState extends ConsumerState<LessonSequenceScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  late final ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
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
      _handleLessonCompleted();
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

  void _handleLessonCompleted() {
    final lessonState = ref.read(currentLessonProvider);
    final letterChar = lessonState.letter?.letter ?? 'أ';

    // 1. توثيق إنهاء الحرف وفتح الحرف التالي تلقائياً في Hive و Riverpod
    ref.read(unlockedUnitsProvider.notifier).unlockNext(letterChar);
    ref.read(currentLessonProvider.notifier).completeLesson();

    // 2. تحديد بيانات الحرف التالي
    final allLetters = arabicLetters;
    final currentIndex = allLetters.indexWhere((l) => l.letter == letterChar);
    final nextLetterData = (currentIndex >= 0 && currentIndex < allLetters.length - 1)
        ? allLetters[currentIndex + 1]
        : null;

    // 3. تشغيل صوت الاحتفال والكونفيتي
    _confettiController.play();
    AudioManager.instance.playFeedback('congrats');

    // 4. عرض نافذة الاحتفال والانتقال المباشر للحرف التالي
    _showCompletionDialog(letterChar, nextLetterData);
  }

  void _showCompletionDialog(String currentLetter, ArabicLetter? nextLetterData) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            elevation: 12,
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // رمز الاحتفال والكأس
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.oasisGreen.withValues(alpha: 0.15),
                      border: Border.all(color: AppColors.oasisGreen, width: 3),
                    ),
                    child: const Center(
                      child: Text('🏆', style: TextStyle(fontSize: 48)),
                    ),
                  ).animate().scale(duration: 500.ms, curve: Curves.elasticOut),

                  const SizedBox(height: 16),

                  // عنوان التهنئة
                  const Text(
                    'مُمْتَازٌ يَا بَطَل! 🎉',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryDay,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // نص التوثيق
                  Text(
                    'أَكْمَلْتَ دَرْسَ حَرْفِ ($currentLetter) بِنَجَاحٍ!\nوَتَمَّ فَتْحُ وَتَوْثِيقُ التَّقَدُّمِ بِنَجَاح ⭐',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // زر الانتقال المباشر للحرف التالي
                  if (nextLetterData != null) ...[
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(dialogContext).pop(); // إغلاق النافذة
                          // الانتقال المباشر لدرس الحرف التالي
                          ref.read(currentLessonProvider.notifier).setLetter(nextLetterData);
                          final regKey = AudioRegistry.letterKeyFromChar(nextLetterData.letter);
                          AudioManager.instance.playLetterAudio(regKey, 'name');
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const LessonSequenceScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.play_arrow_rounded, size: 28),
                        label: Text(
                          'الانْتِقَالُ إِلَى حَرْفِ (${nextLetterData.letter}) مُبَاشَرَةً 🚀',
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.oasisGreen,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                          elevation: 4,
                        ),
                      ),
                    ).animate().shimmer(delay: 500.ms, duration: 1500.ms),
                    const SizedBox(height: 12),
                  ],

                  // زر العودة إلى خريطة الواحة
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(dialogContext).pop(); // إغلاق النافذة
                        Navigator.of(context).pop(); // العودة للخريطة/الرئيسية
                      },
                      icon: const Icon(Icons.map_rounded, size: 22),
                      label: const Text(
                        'الْعَوْدَةُ إِلَى خَرِيطَةِ الْحُرُوفِ 🗺️',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryDay,
                        side: const BorderSide(color: AppColors.primaryDay, width: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // زر إعادة الدرس
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      _pageController.jumpToPage(0);
                    },
                    icon: const Icon(Icons.replay_rounded, size: 18),
                    label: Text(
                      'إِعَادَةُ دَرْسِ حَرْفِ ($currentLetter) 🔄',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final lessonState = ref.watch(currentLessonProvider);
    final letterChar = lessonState.letter?.letter ?? 'أ';

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.backgroundDay,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close, color: AppColors.textPrimaryDay),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'الدرس المتسلسل: حرف $letterChar',
                  style: const TextStyle(
                    color: AppColors.textPrimaryDay,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDay.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${_currentPageIndex + 1} / 5',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDay,
                    ),
                  ),
                ),
              ],
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(6),
              child: ClipRRect(
                child: LinearProgressIndicator(
                  value: (_currentPageIndex + 1) / 5.0,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.oasisGreen),
                  minHeight: 6,
                ),
              ),
            ),
          ),
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // التنقل عبر الأزرار
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
        ),

        // كونفيتي الاحتفال في أعلى الشاشة
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple,
              Colors.amber,
            ],
          ),
        ),
      ],
    );
  }
}
