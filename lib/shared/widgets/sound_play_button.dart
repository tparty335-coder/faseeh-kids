import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';

enum SoundButtonSize { small, medium, large }

class SoundPlayButton extends StatefulWidget {
  final String audioKey;
  final SoundButtonSize size;

  const SoundPlayButton({
    super.key,
    required this.audioKey,
    this.size = SoundButtonSize.medium,
  });

  @override
  State<SoundPlayButton> createState() => _SoundPlayButtonState();
}

class _SoundPlayButtonState extends State<SoundPlayButton> {
  bool _isPlaying = false;

  void _handleTap() async {
    if (_isPlaying) return;
    
    setState(() => _isPlaying = true);
    
    // Simulate playing audio
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() => _isPlaying = false);
    }
  }

  double get _sizeValue {
    switch (widget.size) {
      case SoundButtonSize.small:
        return 40.0;
      case SoundButtonSize.medium:
        return 56.0;
      case SoundButtonSize.large:
        return 72.0;
    }
  }

  double get _iconSize {
    switch (widget.size) {
      case SoundButtonSize.small:
        return 20.0;
      case SoundButtonSize.medium:
        return 28.0;
      case SoundButtonSize.large:
        return 36.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: _sizeValue,
        height: _sizeValue,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.skyBlue,
          boxShadow: [
            BoxShadow(
              color: AppColors.skyBlue.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          Icons.volume_up_rounded,
          color: Colors.white,
          size: _iconSize,
        ),
      )
          .animate(target: _isPlaying ? 1 : 0)
          .scaleXY(end: 1.1, duration: const Duration(milliseconds: 500))
          .then()
          .scaleXY(end: 1.0, duration: const Duration(milliseconds: 500)),
    );
  }
}
