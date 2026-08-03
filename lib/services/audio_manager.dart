import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:faseeh_kids/services/audio_registry.dart';
import 'package:faseeh_kids/services/audio_service.dart';
import 'package:faseeh_kids/services/tts_service.dart';
import 'package:faseeh_kids/core/utils/age_group.dart';

/// Audio Manager — Unified facade for all audio playback
/// Strategy: Try pre-recorded asset first, fall back to TTS
class AudioManager {
  AudioManager._();

  static final AudioManager _instance = AudioManager._();
  static AudioManager get instance => _instance;

  final AudioService _audioService = AudioService.instance;
  final TtsService _ttsService = TtsService.instance;
  bool _soundEnabled = true;

  /// Initialize with age group
  Future<void> init({AgeGroup ageGroup = AgeGroup.preschool3to5}) async {
    await _ttsService.init(ageGroup: ageGroup);
  }

  /// Enable or disable all sound
  void setSoundEnabled(bool enabled) {
    _soundEnabled = enabled;
  }

  /// Play audio by registry key
  /// Falls back to TTS if asset is not found
  Future<void> playByKey(String key, {String? fallbackText}) async {
    if (!_soundEnabled) return;

    final assetPath = AudioRegistry.getPath(key);
    if (assetPath != null) {
      // Try pre-recorded audio first
      final exists = await _assetExists(assetPath);
      if (exists) {
        // Strip 'assets/' prefix for audioplayers AssetSource
        final relativePath = assetPath.replaceFirst('assets/', '');
        await _audioService.playAsset(relativePath);
        return;
      }
    }

    // Fall back to TTS
    if (fallbackText != null && fallbackText.isNotEmpty) {
      debugPrint('AudioManager: Asset not found for "$key", using TTS');
      await _ttsService.speak(fallbackText);
    } else {
      debugPrint('AudioManager: No audio available for key "$key"');
    }
  }

  /// Play a letter's audio variant
  /// [letterKey] e.g., 'alif', 'baa'
  /// [variant] e.g., 'name', 'sound', 'fatha', 'kasra', 'damma', 'word'
  Future<void> playLetterAudio(String letterKey, String variant) async {
    final key = '${letterKey}_$variant';

    // Determine fallback text based on variant
    String? fallback;
    switch (variant) {
      case 'name':
        fallback = AudioRegistry.letterNamesArabic[letterKey];
        break;
      case 'word':
        fallback = AudioRegistry.exampleWords[letterKey];
        break;
      case 'sound':
      case 'fatha':
        final char = AudioRegistry.letterCharsArabic[letterKey];
        if (char != null) fallback = '$char\u064E'; // Add fatha
        break;
      case 'kasra':
        final char = AudioRegistry.letterCharsArabic[letterKey];
        if (char != null) fallback = '$char\u0650'; // Add kasra
        break;
      case 'damma':
        final char = AudioRegistry.letterCharsArabic[letterKey];
        if (char != null) fallback = '$char\u064F'; // Add damma
        break;
      default:
        fallback = AudioRegistry.letterNamesArabic[letterKey];
    }

    await playByKey(key, fallbackText: fallback);
  }

  /// Play feedback audio (positive reinforcement)
  Future<void> playFeedback(String feedbackKey) async {
    final key = 'feedback_$feedbackKey';
    final fallbacks = {
      'excellent': 'أحسنت!',
      'great': 'ممتاز!',
      'wonderful': 'رائع!',
      'try_again': 'لنجرب مرة أخرى!',
      'close': 'قريب جداً!',
      'champion': 'بطل!',
      'wow': 'يا سلام!',
      'correct': 'صحيح!',
      'continue': 'هيا نكمل!',
      'smart': 'أنت ذكي!',
    };
    await playByKey(key, fallbackText: fallbacks[feedbackKey]);
  }

  /// Play SFX (no TTS fallback for sound effects)
  Future<void> playSfx(String sfxKey) async {
    if (!_soundEnabled) return;
    final key = 'sfx_$sfxKey';
    final assetPath = AudioRegistry.getPath(key);
    if (assetPath != null) {
      final relativePath = assetPath.replaceFirst('assets/', '');
      await _audioService.playAsset(relativePath);
    }
  }

  /// Speak arbitrary Arabic text via TTS
  Future<void> speakText(String text) async {
    if (!_soundEnabled) return;
    await _ttsService.speak(text);
  }

  /// Stop all audio
  Future<void> stop() async {
    await _audioService.stop();
    await _ttsService.stop();
  }

  /// Update age group (affects TTS speech rate)
  Future<void> setAgeGroup(AgeGroup ageGroup) async {
    await _ttsService.setAgeGroup(ageGroup);
  }

  /// Check if an asset file exists
  Future<bool> _assetExists(String assetPath) async {
    try {
      await rootBundle.load(assetPath);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Dispose all audio resources
  Future<void> dispose() async {
    _audioService.dispose();
    await _ttsService.dispose();
  }
}
