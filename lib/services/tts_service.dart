// ====================================================
// services/tts_service.dart
// محرك الصوت الهجين — يُشغّل الأصوات البشرية المستخرجة من الأسطوانة
// بالأولوية، ويتراجع للـ TTS الآلي فقط كملاذ أخير
// ====================================================
//
// هيكل المجلدات:
//   assets/audio/letters/short_vowels/{letter}_{fatha|kasra|damma|sukoon}.mp3
//   assets/audio/letters/long_vowels/{letter}_madd_demo.mp3
//   assets/audio/letters/core/{letter}_{name|sound|pos_start|pos_middle|pos_end}.mp3
//   assets/audio/letters/phrases/{letter}_{sentence|fatha_demo|kasra_demo|damma_demo}.mp3
//   assets/audio/letters/words/{letter}_word{1-4}.mp3
//   assets/audio/feedback/{excellent|great|try_again|correct|wonderful}.mp3
//   assets/audio/stories/{letter}_{intro|welcome|goal|explore_01...}.mp3
//   assets/audio/instructions/{letter}_{trace_step_01...|quiz_intro}.mp3
// ====================================================

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../core/constants/audio_manifest.dart';
import '../core/utils/age_group.dart';

class TtsService {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;
  TtsService._internal();

  /// Static getter for legacy singleton access (AudioManager compatibility)
  static TtsService get instance => _instance;

  final FlutterTts _tts = FlutterTts();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isInitialized = false;
  AgeGroup _currentAgeGroup = AgeGroup.preschool3to5;

  /// خريطة الحروف العربية → أسماء الملفات
  static const Map<String, String> letterIds = {
    'أ': 'alif', 'ا': 'alif', 'إ': 'alif', 'آ': 'alif', 'ء': 'alif',
    'ب': 'baa',  'ت': 'taa',  'ث': 'thaa', 'ج': 'jeem', 'ح': 'haa',
    'خ': 'khaa', 'د': 'daal', 'ذ': 'dhaal','ر': 'raa',  'ز': 'zaay',
    'س': 'seen', 'ش': 'sheen','ص': 'saad', 'ض': 'daad', 'ط': 'taa_t',
    'ظ': 'dhaa_dh','ع': 'ain','غ': 'ghain','ف': 'faa',  'ق': 'qaaf',
    'ك': 'kaaf', 'ل': 'laam', 'م': 'meem', 'ن': 'noon',
    'ه': 'haa_h','هـ': 'haa_h','و': 'waaw','ي': 'yaa',
  };

  /// خريطة الحركات → لاحقات الملفات
  static const Map<String, String> vowelIds = {
    'َ': 'fatha', 'ِ': 'kasra', 'ُ': 'damma', 'ْ': 'sukoon',
  };

  // ─── التهيئة ───
  Future<void> init({AgeGroup ageGroup = AgeGroup.preschool3to5}) async {
    if (_isInitialized) return;
    _currentAgeGroup = ageGroup;
    try {
      await _tts.setLanguage('ar-SA');
      await _tts.setSpeechRate(0.45);
      await _tts.setVolume(1.0);
      await _tts.setPitch(1.0);
      await _tts.awaitSpeakCompletion(true);
      _isInitialized = true;
    } catch (e) {
      debugPrint('TtsService: init error — $e');
    }
  }

  // ─── تحديد مسار الأصل بناءً على النص ───
  String? _resolveAssetPath(String text) {
    if (text.isEmpty) return null;

    final char = text[0];
    final id = letterIds[char];
    if (id == null) return null;

    // نص من حرفين: حرف + حركة (مثلاً: بَ، بِ، بُ)
    if (text.length == 2) {
      final vowelSuffix = vowelIds[text[1]];
      if (vowelSuffix != null) {
        return 'assets/audio/letters/short_vowels/${id}_$vowelSuffix.mp3';
      }
    }

    // حرف منفرد → نطق اسم الحرف
    return 'assets/audio/letters/core/${id}_name.mp3';
  }

  // ─── تشغيل صوت بشري محلي إذا وُجد، وإلا TTS ───
  Future<void> speak(String text) async {
    final clean = text.trim();
    if (clean.isEmpty) return;
    if (!_isInitialized) await init(ageGroup: _currentAgeGroup);

    final assetPath = _resolveAssetPath(clean);
    if (assetPath != null && AudioManifest.availableAssets.contains(assetPath)) {
      await _playLocalAsset(assetPath);
      return;
    }

    // Fallback: TTS
    debugPrint('TtsService: No asset for "$clean" — using TTS fallback');
    try {
      await _tts.stop();
      await _tts.speak(clean);
    } catch (e) {
      debugPrint('TtsService: TTS error — $e');
    }
  }

  // ─── تشغيل صوت محدد بالمسار النسبي (من assets/audio/) ───
  // مثال: playBySubpath('letters/core/baa_name.mp3')
  Future<void> playBySubpath(String subPath) async {
    final full = 'assets/audio/$subPath';
    if (AudioManifest.availableAssets.contains(full)) {
      await _playLocalAsset(full);
    } else {
      debugPrint('TtsService: Asset not in manifest: $full');
    }
  }

  // ─── تشغيل صوت اسم الحرف ───
  Future<void> speakLetterName(String letterId) async {
    await playBySubpath('letters/core/${letterId}_name.mp3');
  }

  // ─── تشغيل صوت الحرف (النطق الخالص) ───
  Future<void> speakLetterSound(String letterId) async {
    await playBySubpath('letters/core/${letterId}_sound.mp3');
  }

  // ─── تشغيل الحرف بحركة (الطبقة الصوتية المحورية في التطبيق) ───
  Future<void> speakWithVowel(String letterId, String vowel) async {
    await playBySubpath('letters/short_vowels/${letterId}_$vowel.mp3');
  }

  // ─── تشغيل كلمة ───
  Future<void> speakWord(String letterId, {int wordIndex = 1}) async {
    await playBySubpath('letters/words/${letterId}_word$wordIndex.mp3');
  }

  // ─── تشغيل صوت واجهة / تقييم ───
  Future<void> playFeedback(String key) async {
    // keys: correct, try_again, excellent, great, wonderful, champion, smart
    await playBySubpath('feedback/$key.mp3');
  }

  // ─── تشغيل صوت قصة / مقدمة ───
  Future<void> playStory(String subPath) async {
    await playBySubpath('stories/$subPath');
  }

  // ─── المشغّل الداخلي المشترك ───
  Future<void> _playLocalAsset(String fullAssetPath) async {
    try {
      await _audioPlayer.stop();
      // AssetSource تأخذ المسار بدون كلمة 'assets/'
      await _audioPlayer.play(
        AssetSource(fullAssetPath.replaceFirst('assets/', '')),
      );
      await _audioPlayer.onPlayerComplete.first.timeout(
        const Duration(seconds: 10),
        onTimeout: () => null,
      );
    } catch (e) {
      debugPrint('TtsService: playLocalAsset error ($fullAssetPath) — $e');
    }
  }

  /// Update age group speech rate (AudioManager compatibility)
  Future<void> setAgeGroup(AgeGroup ageGroup) async {
    _currentAgeGroup = ageGroup;
    final rates = {
      AgeGroup.preschool3to5: 0.4,
      AgeGroup.emerging6to8: 0.5,
      AgeGroup.independent9to10: 0.6,
    };
    try { await _tts.setSpeechRate(rates[ageGroup] ?? 0.45); } catch (_) {}
  }

  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
      await _tts.stop();
    } catch (_) {}
  }

  Future<void> dispose() async {
    await stop();
    await _audioPlayer.dispose();
  }
}
