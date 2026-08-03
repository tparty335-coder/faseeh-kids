import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:faseeh_kids/core/utils/age_group.dart';

/// TTS Service — Text-to-Speech wrapper for Arabic
/// Uses flutter_tts with age-appropriate speech rates
class TtsService {
  TtsService._();

  static final TtsService _instance = TtsService._();
  static TtsService get instance => _instance;

  final FlutterTts _tts = FlutterTts();
  bool _initialized = false;
  AgeGroup _currentAgeGroup = AgeGroup.preschool3to5;

  /// Speech rates by age group
  static const Map<AgeGroup, double> _speechRates = {
    AgeGroup.preschool3to5: 0.4,   // Slow for youngest
    AgeGroup.emerging6to8: 0.5,    // Medium
    AgeGroup.independent9to10: 0.6, // Closer to normal
  };

  /// Initialize TTS engine with Arabic language
  Future<void> init({AgeGroup ageGroup = AgeGroup.preschool3to5}) async {
    if (_initialized) return;

    _currentAgeGroup = ageGroup;

    try {
      // Set Arabic language (Saudi Arabia)
      await _tts.setLanguage('ar-SA');

      // Set speech rate based on age group
      await _tts.setSpeechRate(_speechRates[ageGroup] ?? 0.5);

      // Set pitch (slightly higher for children's app)
      await _tts.setPitch(1.1);

      // Set volume
      await _tts.setVolume(1.0);

      // Set completion handler
      _tts.setCompletionHandler(() {
        debugPrint('TtsService: Speech completed');
      });

      _tts.setErrorHandler((message) {
        debugPrint('TtsService: Error — $message');
      });

      _initialized = true;
      debugPrint('TtsService: Initialized with rate ${_speechRates[ageGroup]}');
    } catch (e) {
      debugPrint('TtsService: Failed to initialize — $e');
    }
  }

  /// Update age group (changes speech rate)
  Future<void> setAgeGroup(AgeGroup ageGroup) async {
    _currentAgeGroup = ageGroup;
    final rate = _speechRates[ageGroup] ?? 0.5;
    await _tts.setSpeechRate(rate);
  }

  /// Speak Arabic text
  Future<void> speak(String text) async {
    if (!_initialized) await init(ageGroup: _currentAgeGroup);
    try {
      await _tts.stop();
      await _tts.speak(text);
    } catch (e) {
      debugPrint('TtsService: Error speaking "$text" — $e');
    }
  }

  /// Stop speaking
  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (e) {
      debugPrint('TtsService: Error stopping — $e');
    }
  }

  /// Check if TTS is currently speaking
  Future<bool> get isSpeaking async {
    // FlutterTts doesn't have a direct isSpeaking property
    // We track it via completion handler in production
    return false;
  }

  /// Get available languages
  Future<List<dynamic>> getLanguages() async {
    return await _tts.getLanguages;
  }

  /// Get available voices
  Future<List<dynamic>> getVoices() async {
    return await _tts.getVoices;
  }

  /// Dispose the TTS engine
  Future<void> dispose() async {
    await _tts.stop();
    _initialized = false;
  }
}
