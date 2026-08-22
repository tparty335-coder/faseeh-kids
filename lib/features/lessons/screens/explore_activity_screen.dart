import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/features/lessons/logic/lesson_provider.dart';
import 'package:faseeh_kids/services/audio_manager.dart';

class ExploreActivityScreen extends ConsumerStatefulWidget {
  const ExploreActivityScreen({super.key});

  @override
  ConsumerState<ExploreActivityScreen> createState() => _ExploreActivityScreenState();
}

class _ExploreActivityScreenState extends ConsumerState<ExploreActivityScreen> {
  late final ConfettiController _confettiController;

  int _currentRoundIndex = 0;
  int? _selectedImageIndex;
  bool _isPlaying = false;
  bool _hasAnswered = false;
  bool? _isCorrect;

  // Round data (hardcoded for Alif):
  static const List<Map<String, dynamic>> _rounds = [
    {
      'audioKey': 'story_alif_explore_03',
      'correctImageIndex': 0,
      'fallbackText': 'في يوم من الأيام كان الأسد يسير في الغابة',
    },
    {
      'audioKey': 'story_alif_explore_07',
      'correctImageIndex': 1,
      'fallbackText': 'فهو لم يأكل اليوم شيئاً وفجأةً شاهد أرنباً في الطريق',
    },
    {
      'audioKey': 'story_alif_explore_08',
      'correctImageIndex': 2,
      'fallbackText': 'حاول الأسد الجري وراء الأرنب ولكنه فشل',
    },
  ];

  static const List<String> _storyImages = [
    'assets/images/lessons/alif/alif_story_1.jpg',
    'assets/images/lessons/alif/alif_story_2.jpg',
    'assets/images/lessons/alif/alif_story_3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startIntroAndRoundSequence();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  /// Initial audio sequence: Intro (01) -> Instructions (06) -> Round 1 (03)
  Future<void> _startIntroAndRoundSequence() async {
    if (!mounted) return;
    setState(() => _isPlaying = true);

    // Play intro: story_alif_explore_01
    await AudioManager.instance.playByKey(
      'story_alif_explore_01',
      fallbackText: 'استمع إلى القصة ثم فكر معنا',
    );
    await Future.delayed(const Duration(milliseconds: 2500));
    if (!mounted) return;

    // Play instructions: story_alif_explore_06
    await AudioManager.instance.playByKey(
      'story_alif_explore_06',
      fallbackText: 'استمع إلى الصوت واضغط على الصورة المناسبة لما استمعت إليه حسب أحداث القصة',
    );
    await Future.delayed(const Duration(milliseconds: 4500));
    if (!mounted) return;

    // Play current round audio
    await _playCurrentRoundAudio();
  }

  /// Play audio for the current round
  Future<void> _playCurrentRoundAudio() async {
    if (!mounted) return;
    setState(() => _isPlaying = true);

    final round = _rounds[_currentRoundIndex];
    final audioKey = round['audioKey'] as String;
    final fallbackText = round['fallbackText'] as String;

    await AudioManager.instance.playByKey(
      audioKey,
      fallbackText: fallbackText,
    );

    await Future.delayed(const Duration(milliseconds: 3500));
    if (mounted) {
      setState(() => _isPlaying = false);
    }
  }

  /// Handle tapping a story image card
  void _handleImageTap(int index) async {
    if (_hasAnswered && _isCorrect == true) return;

    final correctIndex = _rounds[_currentRoundIndex]['correctImageIndex'] as int;
    final isCorrect = (index == correctIndex);

    setState(() {
      _selectedImageIndex = index;
      _hasAnswered = true;
      _isCorrect = isCorrect;
    });

    if (isCorrect) {
      HapticFeedback.heavyImpact();
      _confettiController.play();
      await AudioManager.instance.playFeedback('excellent');

      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;

      if (_currentRoundIndex < _rounds.length - 1) {
        setState(() {
          _currentRoundIndex++;
          _hasAnswered = false;
          _isCorrect = null;
          _selectedImageIndex = null;
        });
        _playCurrentRoundAudio();
      } else {
        // Complete current activity when all 3 rounds are completed
        ref.read(currentLessonProvider.notifier).completeCurrentActivity();
      }
    } else {
      HapticFeedback.lightImpact();
      await AudioManager.instance.playFeedback('try_again');

      await Future.delayed(const Duration(milliseconds: 1200));
      if (mounted) {
        setState(() {
          _hasAnswered = false;
          _isCorrect = null;
          _selectedImageIndex = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundDay,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 32 : 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Header & Progress
                    _buildHeader(isTablet),
                    const SizedBox(height: 16),

                    // Progress indicators (Rounds 1, 2, 3)
                    _buildProgressIndicator(),
                    const SizedBox(height: 24),

                    // Play Audio Button
                    _buildPlayAudioButton(isTablet),
                    const SizedBox(height: 32),

                    // Story Images Cards Row
                    Expanded(
                      child: _buildStoryImagesRow(isTablet),
                    ),
                  ],
                ),
              ),
            ),

            // Confetti overlay on correct answer
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                numberOfParticles: 30,
                gravity: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isTablet) {
    return Column(
      children: [
        Text(
          '🔍 استكشف القصة',
          style: TextStyle(
            fontSize: isTablet ? 32 : 26,
            fontWeight: FontWeight.bold,
            color: AppColors.desertSand,
            fontFamily: 'Cairo',
          ),
        ).animate().fadeIn().slideY(begin: -0.2),
        const SizedBox(height: 4),
        Text(
          'استمع إلى الصوت واضغط على الصورة المناسبة حسب الأحداث',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isTablet ? 16 : 14,
            color: AppColors.textSecondaryDay,
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_rounds.length, (index) {
        final isCompleted = index < _currentRoundIndex;
        final isActive = index == _currentRoundIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isCompleted
                ? AppColors.oasisGreen
                : isActive
                    ? AppColors.skyBlue
                    : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.skyBlue.withValues(alpha: 0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isCompleted)
                const Icon(Icons.check, size: 16, color: Colors.white)
              else
                Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.white : Colors.grey.shade600,
                    fontFamily: 'Cairo',
                  ),
                ),
              const SizedBox(width: 4),
              Text(
                'الجولة ${index + 1}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isCompleted || isActive ? Colors.white : Colors.grey.shade600,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPlayAudioButton(bool isTablet) {
    return ElevatedButton.icon(
      onPressed: _isPlaying ? null : _playCurrentRoundAudio,
      icon: Icon(
        _isPlaying ? Icons.volume_up_rounded : Icons.play_circle_fill_rounded,
        size: isTablet ? 36 : 30,
      ),
      label: Text(
        _isPlaying ? 'جاري التشغيل...' : 'استمع إلى الصوت 🔊',
        style: TextStyle(
          fontSize: isTablet ? 20 : 17,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.skyBlue,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 36 : 24,
          vertical: isTablet ? 18 : 14,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 6,
        shadowColor: AppColors.skyBlue.withValues(alpha: 0.4),
      ),
    ).animate(target: _isPlaying ? 1 : 0).scaleXY(end: 1.05, duration: 600.ms, curve: Curves.easeInOut);
  }

  Widget _buildStoryImagesRow(bool isTablet) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(_storyImages.length, (index) {
            final isSelected = _selectedImageIndex == index;
            final isCorrectCard = isSelected && _isCorrect == true;
            final isWrongCard = isSelected && _isCorrect == false;

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: GestureDetector(
                  onTap: () => _handleImageTap(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isCorrectCard
                            ? AppColors.oasisGreen
                            : isWrongCard
                                ? AppColors.errorDay
                                : Colors.white,
                        width: isSelected ? 4 : 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isCorrectCard
                              ? AppColors.oasisGreen.withValues(alpha: 0.5)
                              : isWrongCard
                                  ? AppColors.errorDay.withValues(alpha: 0.5)
                                  : Colors.black.withValues(alpha: 0.1),
                          blurRadius: isSelected ? 16 : 8,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Card Image
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              _storyImages[index],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: Colors.grey.shade200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
                                    const SizedBox(height: 8),
                                    Text(
                                      'قصة ${index + 1}',
                                      style: const TextStyle(fontFamily: 'Cairo', color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Correct feedback badge
                        if (isCorrectCard)
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.oasisGreen.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.check_circle_rounded,
                                  size: 64,
                                  color: Colors.white,
                                ),
                              ),
                            ).animate().scale(duration: 300.ms, curve: Curves.elasticOut),
                          ),

                        // Wrong feedback badge
                        if (isWrongCard)
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.errorDay.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.cancel_rounded,
                                  size: 64,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                  .animate(target: isWrongCard ? 1 : 0)
                  .shake(duration: 500.ms, hz: 4)
                  .animate(target: isCorrectCard ? 1 : 0)
                  .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 300.ms),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
