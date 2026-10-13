import 'package:flutter/material.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/services/audio_service.dart';
import 'package:flutter_animate/flutter_animate.dart';

// â•گâ•گâ•گ UPGRADED: taa_objectives_station.dart â•گâ•گâ•گ

class TaaObjectivesStation extends StatefulWidget {
  final VoidCallback onNext;

  const TaaObjectivesStation({
    super.key,
    required this.onNext,
  });

  @override
  State<TaaObjectivesStation> createState() => _TaaObjectivesStationState();
}

class _TaaObjectivesStationState extends State<TaaObjectivesStation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _duckBobController;
  late final Animation<double> _duckBobAnimation;
  bool _isPlaying = false;

  static const List<String> _objectives = [
    'ظٹظژطھظژط¹ظژط±ظژظ‘ظپظڈ ط¹ظژظ„ظژظ‰ ط§ط³ظ’ظ…ظگ ط­ظژط±ظ’ظپظگ ط§ظ„ظ’ط¨ظژط§ط،ظگ ظˆظژط´ظژظƒظ’ظ„ظگظ‡ظگ',
    'ظٹظڈظ…ظژظٹظگظ‘ط²ظڈ طµظژظˆظ’طھظژ ط­ظژط±ظ’ظپظگ (ط¨) ظ…ظژط¶ظ’ط¨ظڈظˆط·ظ‹ط§ ط¨ظگط§ظ„ظ’ط­ظژط±ظژظƒظژط§طھظگ',
    'ظٹظژطھظژط¹ظژط±ظژظ‘ظپظڈ ط¹ظژظ„ظژظ‰ ط­ظژط±ظ’ظپظگ ط§ظ„ظ’ط¨ظژط§ط،ظگ ظپظگظٹ ط£ظژظˆظژظ‘ظ„ظگ ط§ظ„ظ’ظƒظژظ„ظگظ…ظژط©ظگ ظˆظژظˆظژط³ظژط·ظگظ‡ظژط§ ظˆظژط¢ط®ظگط±ظگظ‡ظژط§',
    'ظٹظژظ†ظ’ط·ظگظ‚ظڈ ظƒظژظ„ظگظ…ظژط§طھظچ ط¨ظگظ‡ظژط§ طµظژظˆظ’طھظڈ ط­ظژط±ظ’ظپظگ (ط¨)',
    'ظٹظژظƒظ’طھظڈط¨ظڈ ط­ظژط±ظ’ظپظژ ط§ظ„ظ’ط¨ظژط§ط،ظگ ط¨ظگطµظڈظˆط±ظژط©ظچ طµظژط­ظگظٹط­ظژط©ظچ',
    'ظٹظڈظƒظژظˆظگظ‘ظ†ظڈ ظƒظژظ„ظگظ…ظژط§طھظچ طھظژط´ظ’طھظژظ…ظگظ„ظڈ ط¹ظژظ„ظژظ‰ ط­ظژط±ظ’ظپظگ ط§ظ„ظ’ط¨ظژط§ط،ظگ',
    'ظٹظژطھظژط¹ظژط±ظژظ‘ظپظڈ ط¹ظژظ„ظژظ‰ ط­ظژط±ظ’ظپظگ ط§ظ„ظ’ط¨ظژط§ط،ظگ ط§ظ„ظ’ظ…ظژظ…ظ’ط¯ظڈظˆط¯ظگ',
    'ظٹظژظ†ظ’ط·ظگظ‚ظڈ طµظژظˆظ’طھظژ ط­ظژط±ظ’ظپظگ (ط¨) ط§ظ„ظ’ظ…ظژظ…ظ’ط¯ظڈظˆط¯ظگ ظپظگظٹ ظƒظژظ„ظگظ…ظژط§طھظچ ظٹظژط³ظ’طھظژظ…ظگط¹ظڈ ط¥ظگظ„ظژظٹظ’ظ‡ظژط§',
  ];

  @override
  void initState() {
    super.initState();
    _duckBobController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _duckBobAnimation = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(parent: _duckBobController, curve: Curves.easeInOut),
    );

    _playObjectivesAudio();
  }

  @override
  void dispose() {
    _duckBobController.dispose();
    AudioService.instance.stop();
    super.dispose();
  }

  Future<void> _playObjectivesAudio() async {
    if (!mounted) return;
    setState(() => _isPlaying = true);
    await AudioService.instance.stop();
    // taa_10.mp3 is the authentic lesson intro / objectives audio
    await AudioService.instance.playAsset('audio/lessons/Taa/long/taa_10.mp3');
    if (mounted) setState(() => _isPlaying = false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // â”€â”€ 1. Authentic Nature Background with fallback â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        Positioned.fill(
          child: Image.asset(
            'assets/images/lessons/Taa/taa_story.jpg',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.lessonSky, AppColors.lessonGrass],
                ),
              ),
            ),
          ),
        ),

        // Subtle dark overlay to make text pop
        Positioned.fill(
          child: Container(
            color: Colors.black.withValues(alpha: 0.15),
          ),
        ),

        // â”€â”€ 2. Top Header / White Cloud â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        Positioned(
          top: 12,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.TaaObjectivesTitle, width: 2),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 3)),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.wb_sunny_rounded, color: Colors.orange, size: 24),
                  SizedBox(width: 8),
                  Text(
                    'ظ‡ظژظٹظژظ‘ط§ ظ†ظژظ‚ظ’ط±ظژط£ظڈ ط§ظ„ظ„ظڈظ‘ط؛ظژط©ظژ ط§ظ„ظ’ط¹ظژط±ظژط¨ظگظٹظژظ‘ط©ظژ â€” ط­ظژط±ظ’ظپظڈ ط§ظ„ظ’ط¨ظژط§ط،ظگ (ط¨)',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.TaaTopBar,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),
          ),
        ),

        // â”€â”€ 3. Main Center Area (Duck on Left + Yellow Objectives Oval on Right) â”€â”€
        Positioned(
          top: 65,
          left: 16,
          right: 16,
          bottom: 75,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left: Animated Bobbing Duck Character
              Expanded(
                flex: 3,
                child: AnimatedBuilder(
                  animation: _duckBobAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _duckBobAnimation.value),
                      child: child,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.9),
                            border: Border.all(color: AppColors.TaaHighlightYellow, width: 4),
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'ًں¦†',
                              style: TextStyle(fontSize: 62),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.TaaTopBar,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: const Text(
                            'ط¨ظژط·ظژظ‘ط©ظڈ ط§ظ„ظ’ط¨ظژط§ط،ظگ',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        // Audio speaker button
                        ElevatedButton.icon(
                          onPressed: _playObjectivesAudio,
                          icon: Icon(
                            _isPlaying ? Icons.pause_rounded : Icons.volume_up_rounded,
                            size: 20,
                          ),
                          label: Text(
                            _isPlaying ? 'ط¬ط§ط±ظچ ط§ظ„ط§ط³طھظ…ط§ط¹' : 'ط§ط³طھظ…ط¹ ظ„ظ„ط£ظ‡ط¯ط§ظپ',
                            style: const TextStyle(fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.TaaSpeaker,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Right: Large Yellow Objectives Oval Card
              Expanded(
                flex: 7,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.TaaObjectivesYellow.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: AppColors.TaaObjectivesTitle, width: 3.5),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Objectives Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star_rounded, color: AppColors.TaaObjectivesTitle, size: 24),
                          const SizedBox(width: 6),
                          Text(
                            'ط£ظژظ‡ظ’ط¯ظژط§ظپظڈ ط¯ظژط±ظ’ط³ظگ ط­ظژط±ظ’ظپظگ ط§ظ„ظ’ط¨ظژط§ط،ظگ :',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.TaaObjectivesTitle,
                              shadows: [
                                Shadow(color: Colors.white.withValues(alpha: 0.8), blurRadius: 4),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Divider(color: AppColors.TaaObjectivesTitle, thickness: 1.5, height: 8),
                      const SizedBox(height: 4),

                      // List of 8 Objectives with Red Dot Bullets
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: _objectives.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 6, left: 6),
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.TaaCardRed,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _objectives[index],
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.TaaObjectivesText,
                                        height: 1.35,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ).animate(delay: (index * 60).ms).fadeIn().slideX(begin: 0.1);
                          },
                        ),
                      ),
                    ],
                  ),
                ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
              ),
            ],
          ),
        ),

        // â”€â”€ 4. Bottom Start Lesson Button â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        Positioned(
          bottom: 12,
          right: 24,
          child: ElevatedButton.icon(
            onPressed: widget.onNext,
            icon: const Text(
              'ط§ط¨ط¯ط£ ط§ظ„ط¯ط±ط³ (ظ‚طµط© ط§ظ„ط­ط±ظپ)',
              style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold),
            ),
            label: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.nextButton,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              elevation: 6,
            ),
          ).animate(delay: 500.ms).shimmer(duration: 2.seconds),
        ),
      ],
    );
  }
}

// â•گâ•گâ•گ END OF FILE â•گâ•گâ•گ


