import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/features/home/logic/home_provider.dart';
import 'package:faseeh_kids/features/lessons/data/arabic_letters_data.dart';
import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:faseeh_kids/services/audio_registry.dart';
import 'package:faseeh_kids/services/audio_service.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/stations/universal_objectives_station.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/stations/universal_story_station.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/stations/universal_sounds_station.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/stations/universal_madd_station.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/stations/universal_writing_station.dart';
import 'package:faseeh_kids/features/lessons/screens/universal/stations/universal_words_station.dart';
import 'package:faseeh_kids/features/lessons/screens/taa/taa_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/thaa/thaa_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/jeem/jeem_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/ha/ha_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/kha/kha_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/dal/dal_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/dhaal/dhaal_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/raa/raa_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/zaay/zaay_games_station.dart';
import 'package:faseeh_kids/features/lessons/screens/seen/seen_games_station.dart';

/// شاشة الدرس الشاملة — محرك موحّد يقبل أي LetterUnitManifest
/// يُستخدم لجميع الحروف من ت فصاعداً (أ و ب يبقيان على شاشاتهما المخصصة)
class LetterLessonShellScreen extends ConsumerStatefulWidget {
  final LetterUnitManifest manifest;
  final int initialStationIndex;

  const LetterLessonShellScreen({
    super.key,
    required this.manifest,
    this.initialStationIndex = 0,
  });

  @override
  ConsumerState<LetterLessonShellScreen> createState() =>
      _LetterLessonShellScreenState();
}

class _LetterLessonShellScreenState
    extends ConsumerState<LetterLessonShellScreen> {
  late final PageController _pageController;
  late final ConfettiController _confettiController;
  late int _currentStationIndex;

  static const int _stationCount = 7;

  static const List<String> _stationNames = [
    'أَهْدَافُ الْوَحْدَةِ',
    'قِصَّةُ الْحَرْفِ',
    'أَصْوَاتُ الْحَرْفِ',
    'الأَلِفُ الْمَمْدُودَةُ',
    'كِتَابَةُ الْحَرْفِ',
    'كَلِمَاتُ الْحَرْفِ',
    'أَلْعَابُ الْحَرْفِ',
  ];

  static const List<String> _stationEmojis = [
    '🎯', '📖', '🔊', '🔤', '✏️', '📝', '🎮',
  ];

  @override
  void initState() {
    super.initState();
    _currentStationIndex =
        widget.initialStationIndex.clamp(0, _stationCount - 1);
    _pageController = PageController(initialPage: _currentStationIndex);
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
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

  /// توثيق إنجاز الحرف وفتح التالي تلقائياً وعرض نافذة الاحتفال
  void _handleLessonCompleted() {
    AudioService.instance.stop();

    // توثيق الإنجاز في Hive و Riverpod
    ref.read(unlockedUnitsProvider.notifier).unlockNext(widget.manifest.letter);
    ref.read(currentLessonProvider.notifier).completeLesson();

    // بيانات الحرف التالي
    final nextChar = widget.manifest.nextLetter;
    ArabicLetter? nextLetterData;
    if (nextChar != null) {
      final idx = arabicLetters.indexWhere((l) => l.letter == nextChar);
      if (idx >= 0) nextLetterData = arabicLetters[idx];
    }

    // كونفيتي + صوت احتفال
    _confettiController.play();
    AudioManager.instance.playFeedback('congrats');

    _showCompletionDialog(nextLetterData);
  }

  void _showCompletionDialog(ArabicLetter? nextLetterData) {
    final m = widget.manifest;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Directionality(
        textDirection: TextDirection.rtl,
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          elevation: 12,
          backgroundColor: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // تروفي
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.oasisGreen.withValues(alpha: 0.15),
                    border:
                        Border.all(color: AppColors.oasisGreen, width: 3),
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
                  'أَكْمَلْتَ دَرْسَ حَرْفِ (${m.letter}) بِنَجَاحٍ!\n'
                  'وَتَمَّ فَتْحُ حَرْفِ (${m.nextLetter ?? '🎓'}) وَتَوْثِيقُ التَّقَدُّمِ ⭐',
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

                // زر الانتقال للحرف التالي
                if (nextLetterData != null) ...[
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        ref
                            .read(currentLessonProvider.notifier)
                            .setLetter(nextLetterData);
                        final regKey = AudioRegistry.letterKeyFromChar(
                            nextLetterData.letter);
                        AudioManager.instance.playLetterAudio(regKey, 'name');
                        // العودة للخارطة — شاشة الحرف التالي ستُفتح من الخارطة
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.play_arrow_rounded, size: 28),
                      label: Text(
                        'الانْتِقَالُ إِلَى حَرْفِ (${nextLetterData.letter}) 🚀',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.oasisGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        elevation: 4,
                      ),
                    ),
                  ).animate().shimmer(delay: 500.ms, duration: 1500.ms),
                  const SizedBox(height: 12),
                ],

                // العودة للخارطة
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
                          fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryDay,
                      side:
                          const BorderSide(color: AppColors.primaryDay, width: 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // إعادة الدرس
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    _goToStation(0);
                  },
                  icon: const Icon(Icons.replay_rounded, size: 18),
                  label: Text(
                    'إِعَادَةُ دَرْسِ حَرْفِ (${m.letter}) 🔄',
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
      ),
    );
  }

  /// يوزّع كل محطة لمكوّنها الحقيقي أو للـ placeholder إن لم يُبنَ بعد
  Widget _buildStation(LetterUnitManifest m, int i) {
    switch (i) {
      case 0: // الأهداف
        return UniversalObjectivesStation(
          spec: m.objectives,
          letter: m.letter,
          mascotEmoji: m.mascotEmoji,
          accentColor: m.topBarColor,
          onNext: _nextStation,
        );
      case 1: // القصة
        return UniversalStoryStation(
          spec: m.story,
          letter: m.letter,
          accentColor: m.topBarColor,
          mascotEmoji: m.mascotEmoji,
          onNext: _nextStation,
          onPrevious: _previousStation,
        );
      case 2: // أصوات الحرف
        return UniversalSoundsStation(
          spec: m.vowels,
          onNext: _nextStation,
          onPrevious: _previousStation,
        );
      case 3: // الألف الممدودة والمدود
        return UniversalMaddStation(
          spec: m.madd,
          onNext: _nextStation,
          onPrevious: _previousStation,
        );
      case 4: // كتابة الحرف
        return UniversalWritingStation(
          spec: m.tracing,
          onNext: _nextStation,
          onPrevious: _previousStation,
        );
      case 5: // كلمات الحرف
        return UniversalWordsStation(
          spec: m.words,
          letter: m.letter,
          onNext: _nextStation,
          onPrevious: _previousStation,
        );
      case 6: // ألعاب الحرف
        if (m.letter == 'ت') {
          return TaaGamesStation(
            onNext: _nextStation,
            onPrevious: _previousStation,
          );
        }
        if (m.letter == 'ث') {
          return ThaaGamesStation(
            onNext: _nextStation,
            onPrevious: _previousStation,
          );
        }
        if (m.letter == 'ج') {
          return JeemGamesStation(
            onNext: _nextStation,
            onPrevious: _previousStation,
          );
        }
        if (m.letter == 'ح') {
          return HaGamesStation(
            onNext: _nextStation,
            onPrevious: _previousStation,
          );
        }
                        if (m.letter == 'س') {
          return SeenGamesStation(
            onNext: _nextStation,
            onPrevious: _previousStation,
          );
        }
        if (m.letter == 'ز') {
          return ZaayGamesStation(
            onNext: _nextStation,
            onPrevious: _previousStation,
          );
        }
        if (m.letter == 'ر') {
          return RaaGamesStation(
            onNext: _nextStation,
            onPrevious: _previousStation,
          );
        }
        if (m.letter == 'ذ') {
          return DhaalGamesStation(
            onNext: _nextStation,
            onPrevious: _previousStation,
          );
        }
        if (m.letter == 'د') {
          return DalGamesStation(
            onNext: _nextStation,
            onPrevious: _previousStation,
          );
        }
        if (m.letter == 'خ') {
          return KhaGamesStation(
            onNext: _nextStation,
            onPrevious: _previousStation,
          );
        }
        return _StationPlaceholder(
          stationIndex: i,
          stationName: _stationNames[i],
          emoji: _stationEmojis[i],
          letter: m.letter,
          isLast: true,
          onNext: _nextStation,
          onPrevious: _previousStation,
        );
      default:
        return _StationPlaceholder(
          stationIndex: i,
          stationName: _stationNames[i],
          emoji: _stationEmojis[i],
          letter: m.letter,
          isLast: i == _stationCount - 1,
          onNext: _nextStation,
          onPrevious: i > 0 ? _previousStation : null,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.manifest;
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                // ── شريط العنوان العلوي ──────────────────────────────────
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  color: m.topBarColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close_rounded,
                            color: Colors.white, size: 26),
                        onPressed: () {
                          AudioService.instance.stop();
                          Navigator.of(context).pop();
                        },
                      ),
                      Flexible(
                        child: Text(
                          m.unitTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          color: m.highlightColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'حَرْفُ (${m.letter})',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: m.topBarColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── المحتوى — المحطات السبع ─────────────────────────────
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (i) =>
                        setState(() => _currentStationIndex = i),
                    children: List.generate(_stationCount, (i) {
                      return _buildStation(m, i);
                    }),
                  ),
                ),

                // ── شريط التنقل السفلي ──────────────────────────────────
                _UniversalTrainNavBar(
                  activeStationIndex: _currentStationIndex,
                  topBarColor: m.topBarColor,
                  letter: m.letter,
                  onStationSelected: _goToStation,
                ),
              ],
            ),
          ),
        ),

        // ── كونفيتي ─────────────────────────────────────────────────────
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

// ─────────────────────────────────────────────────────────────────────────────
// Placeholder محطة — يُستبدل بالمحطة الحقيقية عند بناء كل محطة
// ─────────────────────────────────────────────────────────────────────────────

class _StationPlaceholder extends StatelessWidget {
  final int stationIndex;
  final String stationName;
  final String emoji;
  final String letter;
  final bool isLast;
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const _StationPlaceholder({
    required this.stationIndex,
    required this.stationName,
    required this.emoji,
    required this.letter,
    required this.isLast,
    required this.onNext,
    this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 72)),
          const SizedBox(height: 16),
          Text(
            stationName,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.primaryDay,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'حَرْفُ ($letter) — قِيدَ الْبِنَاءِ 🔧',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 15,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (onPrevious != null) ...[
                ElevatedButton.icon(
                  onPressed: onPrevious,
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: const Text('السَّابِقُ',
                      style: TextStyle(fontFamily: 'Cairo')),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black87),
                ),
                const SizedBox(width: 16),
              ],
              ElevatedButton.icon(
                onPressed: onNext,
                icon: Icon(isLast
                    ? Icons.check_circle_rounded
                    : Icons.arrow_back_rounded),
                label: Text(
                  isLast ? 'إِنْهَاءُ الدَّرْسِ 🎉' : 'التَّالِي',
                  style: const TextStyle(fontFamily: 'Cairo'),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.oasisGreen,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// شريط التنقل السفلي الشامل — 7 محطات
// ─────────────────────────────────────────────────────────────────────────────

class _UniversalTrainNavBar extends StatelessWidget {
  final int activeStationIndex;
  final Color topBarColor;
  final String letter;
  final ValueChanged<int> onStationSelected;

  const _UniversalTrainNavBar({
    required this.activeStationIndex,
    required this.topBarColor,
    required this.letter,
    required this.onStationSelected,
  });

  static const List<IconData> _icons = [
    Icons.flag_rounded,
    Icons.auto_stories_rounded,
    Icons.record_voice_over_rounded,
    Icons.text_fields_rounded,
    Icons.edit_rounded,
    Icons.library_books_rounded,
    Icons.sports_esports_rounded,
  ];

  static const List<String> _labels = [
    'الأهداف', 'القصة', 'الأصوات', 'المدود', 'الكتابة', 'الكلمات', 'الألعاب',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: topBarColor.withValues(alpha: 0.12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(7, (i) {
          final isActive = i == activeStationIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onStationSelected(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                decoration: BoxDecoration(
                  color: isActive
                      ? topBarColor.withValues(alpha: 0.18)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _icons[i],
                        size: 22,
                        color: isActive ? topBarColor : Colors.grey.shade500,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _labels[i],
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 9,
                          fontWeight: isActive
                              ? FontWeight.w900
                              : FontWeight.normal,
                          color: isActive ? topBarColor : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

