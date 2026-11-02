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
import 'package:faseeh_kids/services/audio_service.dart';
import 'package:faseeh_kids/features/lessons/screens/alif/alif_train_navbar.dart';
import 'package:faseeh_kids/features/lessons/screens/alif/alif_objectives_station.dart';
import 'package:faseeh_kids/features/lessons/screens/alif/alif_story_station.dart';
import 'package:faseeh_kids/features/lessons/screens/alif/alif_sounds_station.dart';
import 'package:faseeh_kids/features/lessons/screens/alif/alif_madd_station.dart';
import 'package:faseeh_kids/features/lessons/screens/alif/alif_writing_station.dart';
import 'package:faseeh_kids/features/lessons/screens/alif/alif_words_station.dart';
import 'package:faseeh_kids/features/lessons/screens/alif/alif_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/baa/baa_lesson_screen.dart';

/// شاشة درس حرف الألف — نسخة مرآة هيكلية وبصرية 1:1 من BaaLessonScreen
/// المحطات السبع: الأهداف، قصة الحرف، أصوات الحرف، الألف الممدودة، كتابة الحرف، كلمات الحرف، ألعاب
class AlifLessonScreen extends ConsumerStatefulWidget {
  final int initialStationIndex;

  const AlifLessonScreen({
    super.key,
    this.initialStationIndex = 0,
  });

  @override
  ConsumerState<AlifLessonScreen> createState() => _AlifLessonScreenState();
}

class _AlifLessonScreenState extends ConsumerState<AlifLessonScreen> {
  late final PageController _pageController;
  late final ConfettiController _confettiController;
  late int _currentStationIndex;

  static const int _stationCount = 7; // الأهداف + قصة + أصوات + مدود + كتابة + كلمات الحرف + ألعاب

  @override
  void initState() {
    super.initState();
    _currentStationIndex = widget.initialStationIndex.clamp(0, _stationCount - 1);
    _pageController = PageController(initialPage: _currentStationIndex);
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _pageController.dispose();
    AudioService.instance.stop();
    super.dispose();
  }

  void _goToStation(int index) {
    if (index < 0 || index >= _stationCount) return;
    AudioService.instance.stop();
    setState(() => _currentStationIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _nextStation() {
    if (_currentStationIndex < _stationCount - 1) {
      _goToStation(_currentStationIndex + 1);
    } else {
      _handleLessonCompleted();
    }
  }

  void _previousStation() {
    if (_currentStationIndex > 0) {
      _goToStation(_currentStationIndex - 1);
    } else {
      AudioService.instance.stop();
      Navigator.of(context).pop();
    }
  }

  /// توثيق إنجاز حرف الألف وفتح حرف الباء تلقائياً وعرض نافذة الاحتفال
  void _handleLessonCompleted() {
    AudioService.instance.stop();

    // 1. توثيق إنهاء حرف الألف وفتح حرف الباء تلقائياً في Hive و Riverpod
    ref.read(unlockedUnitsProvider.notifier).unlockNext('أ');
    ref.read(currentLessonProvider.notifier).completeLesson();

    // 2. تحديد بيانات الحرف التالي (حرف الباء)
    final baaIndex = arabicLetters.indexWhere((l) => l.letter == 'ب');
    final baaLetterData = baaIndex >= 0 ? arabicLetters[baaIndex] : null;

    // 3. تشغيل صوت الاحتفال والكونفيتي
    _confettiController.play();
    AudioManager.instance.playFeedback('congrats');

    // 4. عرض نافذة الاحتفال والانتقال المباشر لدرس حرف الباء
    _showCompletionDialog(baaLetterData);
  }

  void _showCompletionDialog(ArabicLetter? nextLetterData) {
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
                  Text(
                    'أَكْمَلْتَ دَرْسَ حَرْفِ (أ) بِنَجَاحٍ!\nوَتَمَّ فَتْحُ حَرْفِ (ب) وَتَوْثِيقُ التَّقَدُّمِ ⭐',
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
                  if (nextLetterData != null) ...[
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                          ref.read(currentLessonProvider.notifier).setLetter(nextLetterData);
                          final regKey = AudioRegistry.letterKeyFromChar(nextLetterData.letter);
                          AudioManager.instance.playLetterAudio(regKey, 'name');
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const BaaLessonScreen(initialStationIndex: 1),
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
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        Navigator.of(context).pop();
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
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      _goToStation(0);
                    },
                    icon: const Icon(Icons.replay_rounded, size: 18),
                    label: Text(
                      'إِعَادَةُ دَرْسِ حَرْفِ (أ) 🔄',
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
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                // شريط العنوان العلوي المدمج (نسخة مطابقة من BaaLessonScreen)
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  color: AppColors.baaTopBar,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close_rounded, color: Colors.white, size: 26),
                        onPressed: () {
                          AudioService.instance.stop();
                          Navigator.of(context).pop();
                        },
                      ),
                      const Flexible(
                        child: Text(
                          'الْوَحْدَةُ الْأُولَى | حَرْفُ الْأَلِفِ (أ)',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.baaHighlightYellow,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'حَرْفُ (أ)',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.baaTopBar,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // المحتوى الرئيسي — المحطات السبع بملفات مستقلة متطابقة مع حرف الباء
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (i) => setState(() => _currentStationIndex = i),
                    children: [
                      AlifObjectivesStation(onNext: _nextStation),
                      AlifStoryStation(onNext: _nextStation, onPrevious: _previousStation),
                      AlifSoundsStation(
                        onNext: _nextStation,
                        onPrevious: _previousStation,
                        isActive: _currentStationIndex == 2,
                      ),
                      AlifMaddStation(
                        onNext: _nextStation,
                        onPrevious: _previousStation,
                        isActive: _currentStationIndex == 3,
                      ),
                      AlifWritingStation(
                        onNext: _nextStation,
                        onPrevious: _previousStation,
                      ),
                      AlifWordsStation(
                        onNext: _nextStation,
                        onPrevious: _previousStation,
                      ),
                      AlifGamesStation(
                        onNext: _nextStation,
                        onPrevious: _previousStation,
                      ),
                    ],
                  ),
                ),

                // شريط التنقل السفلي ذو المحطات السبع
                AlifTrainNavBar(
                  activeStationIndex: _currentStationIndex,
                  onStationSelected: _goToStation,
                ),
              ],
            ),
          ),
        ),

        // كونفيتي الاحتفال عند إنهاء الدرس
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
