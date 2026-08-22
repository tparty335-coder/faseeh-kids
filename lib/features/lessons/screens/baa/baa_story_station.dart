import 'package:flutter/material.dart';
import 'package:faseeh_kids/services/audio_service.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BaaStoryStation extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const BaaStoryStation({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<BaaStoryStation> createState() => _BaaStoryStationState();
}

class _BaaStoryStationState extends State<BaaStoryStation> {
  bool _isPlaying = false;
  bool _showReward = false;

  final String _storyText = 'بَاءٌ بَطَّةٌ وَضَعَتْ بَيْضَةً خَلْفَ الْبَقَرَةِ جَنْبَ الشَّجَرَةِ';

  @override
  void initState() {
    super.initState();
    _playStoryAudio();
  }

  @override
  void dispose() {
    AudioService.instance.stop();
    super.dispose();
  }

  Future<void> _playStoryAudio() async {
    setState(() => _isPlaying = true);
    await AudioService.instance.stop();
    await AudioService.instance.playAsset('audio/lessons/baa/long/baa_1.mp3');
    if (mounted) setState(() => _isPlaying = false);
  }

  Future<void> _onInteractiveElementTapped() async {
    setState(() => _showReward = true);
    await AudioService.instance.stop();
    await AudioService.instance.playAsset('audio/lessons/baa/short/baa_5.mp3'); // أحسنت!
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _showReward = false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ── 1. Authentic Background Image ──────────────────────────
        Positioned.fill(
          child: Image.asset(
            'assets/images/lessons/baa/baa_story.jpg',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: const Color(0xFFC8E6C9)),
          ),
        ),

        // ── 2. Top Header Bar ─────────────────────────────────────
        Positioned(
          top: 16,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF8D6E63),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
              ),
              child: const Text(
                'قِصَّةُ الْحَرْفِ',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        // ── 3. Speech Bubble with Story Text ──────────────────────
        Positioned(
          top: 80,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.92),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFF81C784), width: 3),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _storyText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _playStoryAudio,
                  icon: Icon(_isPlaying ? Icons.pause_rounded : Icons.volume_up_rounded, size: 24),
                  label: const Text(
                    'استمع للقصة',
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),
        ),

        // ── 4. Interactive Hotspots on the Background Scene ───────
        // Duck by the pond
        Positioned(
          bottom: 120,
          right: 40,
          width: 90,
          height: 90,
          child: GestureDetector(
            onTap: _onInteractiveElementTapped,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.amber.withOpacity(0.6), width: 3),
                color: Colors.amber.withOpacity(0.15),
              ),
              child: const Icon(Icons.touch_app_rounded, color: Colors.amber, size: 36),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1)),
          ),
        ),

        // ── 5. Reward Pop-up ──────────────────────────────────────
        if (_showReward)
          Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.amber, width: 4),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 16)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('🎉', style: TextStyle(fontSize: 48)),
                  SizedBox(height: 8),
                  Text(
                    'أَحْسَنْتَ!',
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFE65100)),
                  ),
                ],
              ),
            ).animate().scale(duration: 300.ms),
          ),

        // ── 6. Bottom Navigation Arrows ───────────────────────────
        Positioned(
          bottom: 16,
          left: 24,
          right: 24,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton.icon(
                onPressed: widget.onPrevious,
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                label: const Text('السابق', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  foregroundColor: Colors.brown.shade800,
                  side: BorderSide(color: Colors.brown.shade400, width: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
              ElevatedButton.icon(
                onPressed: widget.onNext,
                icon: const Text('التالي', style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold)),
                label: const Icon(Icons.arrow_forward_ios, size: 18),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9800),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
