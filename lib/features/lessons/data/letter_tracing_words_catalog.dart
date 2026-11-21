import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/all_letter_manifests.dart';
import 'package:faseeh_kids/features/lessons/data/letter_unit_manifest.dart';

/// كلمة مصوّرة ناطقة مرافقة لبطاقة تتبّع الحرف (مقصوصة بدقة على خلفية بيضاء ناصعة)
class TracingWordIllustration {
  final String word;
  final String imagePath;
  final String audioPath;
  final Rect cropRect;

  const TracingWordIllustration({
    required this.word,
    required this.imagePath,
    required this.audioPath,
    required this.cropRect,
  });
}

/// موضع كتابة واحد للحرف (منفصل / أول / وسط / آخر الكلمة)
class TracingPositionItem {
  final String position; // 'isolated' | 'start' | 'middle' | 'end'
  final String shortLabel;
  final String displayForm;
  final String audioPath;
  final String exampleWord;

  const TracingPositionItem({
    required this.position,
    required this.shortLabel,
    required this.displayForm,
    required this.audioPath,
    required this.exampleWord,
  });
}

/// الملف التعريفي الكامل لمحطة كتابة وتتبّع كل حرف من الحروف الـ 28 بأسلوب Kiwii / Montessori
class TracingLetterProfile {
  final String letterChar;
  final String definiteTitle;
  final Color accentColor;
  final String introAudioPath;
  final List<TracingPositionItem> positions;
  final List<TracingWordIllustration> words;

  const TracingLetterProfile({
    required this.letterChar,
    required this.definiteTitle,
    required this.accentColor,
    required this.introAudioPath,
    required this.positions,
    required this.words,
  });
}

class LetterTracingWordsCatalog {
  LetterTracingWordsCatalog._();

  static const Set<String> _kickingLetters = {'أ', 'د', 'ذ', 'ر', 'ز', 'و'};

  /// مفاتيح ملفات audio/letters/core/{key}_{name,pos_start,pos_middle,pos_end}.mp3
  static const Map<String, String> _coreAudioKey = {
    'أ': 'alif',
    'ب': 'baa',
    'ت': 'taa',
    'ث': 'thaa',
    'ج': 'jeem',
    'ح': 'haa_h',
    'خ': 'khaa',
    'د': 'daal',
    'ذ': 'dhaal',
    'ر': 'raa',
    'ز': 'zaay',
    'س': 'seen',
    'ش': 'sheen',
    'ص': 'saad',
    'ض': 'daad',
    'ط': 'taa_t',
    'ظ': 'dhaa_dh',
    'ع': 'ain',
    'غ': 'ghain',
    'ف': 'faa',
    'ق': 'qaaf',
    'ك': 'kaaf',
    'ل': 'laam',
    'م': 'meem',
    'ن': 'noon',
    'ه': 'haa',
    'و': 'waaw',
    'ي': 'yaa',
  };

  /// العنوان الكامل بالتعريف (مثل "حرف الألف" / "حرف الباء" / "حرف النون" في بطاقات Kiwii)
  static const Map<String, String> _definiteTitles = {
    'أ': 'حَرْفُ الْأَلِفِ',
    'ب': 'حَرْفُ الْبَاءِ',
    'ت': 'حَرْفُ التَّاءِ',
    'ث': 'حَرْفُ الثَّاءِ',
    'ج': 'حَرْفُ الْجِيمِ',
    'ح': 'حَرْفُ الْحَاءِ',
    'خ': 'حَرْفُ الْخَاءِ',
    'د': 'حَرْفُ الدَّالِ',
    'ذ': 'حَرْفُ الذَّالِ',
    'ر': 'حَرْفُ الرَّاءِ',
    'ز': 'حَرْفُ الزَّايِ',
    'س': 'حَرْفُ السِّينِ',
    'ش': 'حَرْفُ الشِّينِ',
    'ص': 'حَرْفُ الصَّادِ',
    'ض': 'حَرْفُ الضَّادِ',
    'ط': 'حَرْفُ الطَّاءِ',
    'ظ': 'حَرْفُ الظَّاءِ',
    'ع': 'حَرْفُ الْعَيْنِ',
    'غ': 'حَرْفُ الْغَيْنِ',
    'ف': 'حَرْفُ الْفَاءِ',
    'ق': 'حَرْفُ الْقَافِ',
    'ك': 'حَرْفُ الْكَافِ',
    'ل': 'حَرْفُ اللَّامِ',
    'م': 'حَرْفُ الْمِيمِ',
    'ن': 'حَرْفُ النُّونِ',
    'ه': 'حَرْفُ الْهَاءِ',
    'و': 'حَرْفُ الْوَاوِ',
    'ي': 'حَرْفُ الْيَاءِ',
  };

  /// ألوان الإطار الخارجي الزاهية المتطابقة مع بطاقات Kiwii المرجعية
  static const Map<String, Color> _kiwiiOutlineColors = {
    'أ': Color(0xFFE53935), // أحمر ناصع (مثل ا.jpg)
    'ب': Color(0xFFF59E0B), // برتقالي مشرق (مثل ب.jpg)
    'ت': Color(0xFF10B981), // أخضر زمردي
    'ث': Color(0xFF7C3AED), // بنفسجي زاهٍ
    'ج': Color(0xFF0EA5E9), // أزرق سماوي
    'ح': Color(0xFFEC4899), // وردي فوشيا
    'خ': Color(0xFF0891B2), // فيروزي عميق
    'د': Color(0xFF65A30D), // أخضر تفاحي (مثل د.jpg)
    'ذ': Color(0xFFF97316), // برتقالي دافئ
    'ر': Color(0xFF2563EB), // أزرق ملكي
    'ز': Color(0xFFD946EF), // أرجواني مشرق
    'س': Color(0xFF0284C7), // أزرق سماوي (مثل س.jpg)
    'ش': Color(0xFFE11D48), // قرمزي حيوي
    'ص': Color(0xFF84CC16), // أخضر ليموني (مثل ص.jpg)
    'ض': Color(0xFFEA580C), // برتقالي قاني
    'ط': Color(0xFF0D9488), // أخضر بترولي
    'ظ': Color(0xFF4F46E5), // نيلي زاهٍ
    'ع': Color(0xFFDB2777), // وردي توتي
    'غ': Color(0xFF16A34A), // أخضر عشبي
    'ف': Color(0xFF2563EB), // أزرق ساطع
    'ق': Color(0xFF9333EA), // بنفسجي عميق
    'ك': Color(0xFFDC2626), // أحمر ياقوتي
    'ل': Color(0xFFD97706), // كهرماني ذهبي
    'م': Color(0xFF9333EA), // بنفسجي زاهٍ (مثل م.jpg)
    'ن': Color(0xFF0284C7), // أزرق ناصع (مثل ن.jpg)
    'ه': Color(0xFFE53935), // أحمر صريح (مثل ه.jpg)
    'و': Color(0xFF059669), // أخضر غابة
    'ي': Color(0xFF0284C7), // أزرق بحري
  };

  /// مستطيل القص النظيف (0..1) لاستخراج الرسم الكرتوني فقط على خلفية بيضاء نقية
  static Rect cropRectForImage(String imagePath) {
    if (imagePath.contains('words_round_1.webp') ||
        imagePath.contains('words_round_2.webp') ||
        imagePath.contains('words_round_3.webp')) {
      return const Rect.fromLTRB(0.45, 0.29, 0.86, 0.76);
    }
    if (imagePath.contains('baa_words_round_2.webp')) {
      return const Rect.fromLTRB(0.41, 0.33, 0.86, 0.77);
    }
    if (imagePath.contains('baa_words_round_4.webp')) {
      return const Rect.fromLTRB(0.43, 0.33, 0.86, 0.70);
    }
    if (imagePath.contains('baa_words_round_')) {
      return const Rect.fromLTRB(0.41, 0.33, 0.86, 0.72);
    }
    if (imagePath.contains('thaa_words_round_')) {
      return const Rect.fromLTRB(0.44, 0.38, 0.88, 0.82);
    }
    // جميع صور 800×446 القياسية (match/*/*_match_1..4.webp)
    return const Rect.fromLTRB(0.44, 0.38, 0.88, 0.84);
  }

  static String normalizeLetter(String letterChar) {
    final trimmed = letterChar.trim();
    if (trimmed == 'هـ') return 'ه';
    if (trimmed == 'ا') return 'أ';
    return trimmed;
  }

  static List<String> _displayFormsFor(String letter) {
    if (letter == 'ه') return const ['ه', 'هـ', 'ـهـ', 'ـه'];
    if (_kickingLetters.contains(letter)) {
      return [letter, letter, 'ـ$letter', 'ـ$letter'];
    }
    return [letter, '$letterـ', 'ـ$letterـ', 'ـ$letter'];
  }

  static List<TracingWordIllustration> _alifWords() => const [
        TracingWordIllustration(
          word: 'أَسَدٌ',
          imagePath: 'assets/images/games/words/words_round_3.webp',
          audioPath: 'audio/words_game/alif_word_lion.mp3',
          cropRect: Rect.fromLTRB(0.45, 0.29, 0.86, 0.76),
        ),
        TracingWordIllustration(
          word: 'أَرْنَبٌ',
          imagePath: 'assets/images/games/words/words_round_1.webp',
          audioPath: 'audio/words_game/alif_word_rabbit.mp3',
          cropRect: Rect.fromLTRB(0.45, 0.29, 0.86, 0.76),
        ),
        TracingWordIllustration(
          word: 'أَهْرَامٌ',
          imagePath: 'assets/images/games/words/words_round_2.webp',
          audioPath: 'audio/words_game/alif_word_pyramids.mp3',
          cropRect: Rect.fromLTRB(0.45, 0.29, 0.86, 0.76),
        ),
        TracingWordIllustration(
          word: 'إِبْرَةٌ',
          imagePath: 'assets/images/games/words/baa_words_round_4.webp',
          audioPath: 'audio/stories/alif_word_ibra.mp3',
          cropRect: Rect.fromLTRB(0.43, 0.33, 0.86, 0.70),
        ),
      ];

  static List<TracingWordIllustration> _baaWords() => const [
        TracingWordIllustration(
          word: 'بَقَرَةٌ',
          imagePath: 'assets/images/games/words/baa_words_round_1.webp',
          audioPath: 'audio/games/fishing/ba52.mp3',
          cropRect: Rect.fromLTRB(0.41, 0.33, 0.86, 0.72),
        ),
        TracingWordIllustration(
          word: 'بَابٌ',
          imagePath: 'assets/images/games/words/baa_words_round_2.webp',
          audioPath: 'audio/letters/long_vowels/baa_madd_alif.mp3',
          cropRect: Rect.fromLTRB(0.41, 0.33, 0.86, 0.77),
        ),
        TracingWordIllustration(
          word: 'بِطِّيخٌ',
          imagePath: 'assets/images/games/words/baa_words_round_3.webp',
          audioPath: 'audio/lessons/baa/sounds/word_betteekh.mp3',
          cropRect: Rect.fromLTRB(0.41, 0.33, 0.86, 0.72),
        ),
        TracingWordIllustration(
          word: 'إِبْرَةٌ',
          imagePath: 'assets/images/games/words/baa_words_round_4.webp',
          audioPath: 'audio/lessons/baa/words/p2_ibra.mp3',
          cropRect: Rect.fromLTRB(0.43, 0.33, 0.86, 0.70),
        ),
      ];

  static TracingLetterProfile getProfile(String rawLetter, {TracingSpec? tracingSpec}) {
    final letter = normalizeLetter(rawLetter);
    final manifest = findManifestForLetter(letter);
    final coreKey = _coreAudioKey[letter] ?? 'alif';
    final forms = _displayFormsFor(letter);

    // 1. الكلمات الـ 4 المصوّرة الناطقة
    final List<TracingWordIllustration> words;
    if (letter == 'أ') {
      words = _alifWords();
    } else if (letter == 'ب') {
      words = _baaWords();
    } else if (manifest != null && manifest.games.wordsMatch.isNotEmpty) {
      words = manifest.games.wordsMatch.take(4).map((pair) {
        return TracingWordIllustration(
          word: pair.word,
          imagePath: pair.imagePath,
          audioPath: pair.audioPath,
          cropRect: cropRectForImage(pair.imagePath),
        );
      }).toList(growable: false);
    } else {
      words = _alifWords();
    }

    // 2. صوت مقدمة الكتابة
    final String introAudio;
    if (tracingSpec != null && tracingSpec.audioIntroPath.isNotEmpty) {
      introAudio = tracingSpec.audioIntroPath;
    } else if (manifest != null && manifest.tracing.audioIntroPath.isNotEmpty) {
      introAudio = manifest.tracing.audioIntroPath;
    } else if (letter == 'ب') {
      introAudio = 'audio/lessons/baa/writing/baa_write_w8.mp3';
    } else {
      introAudio = 'audio/instructions/alif_trace_step_01.mp3';
    }

    // 3. المواضع الـ 4 الموحّدة (منفصل، أول الكلمة، وسط الكلمة، آخر الكلمة)
    final specPositions = tracingSpec?.positions ?? manifest?.tracing.positions;
    TracingPositionSpec? findPos(String code) {
      if (specPositions == null) return null;
      for (final p in specPositions) {
        if (p.position == code) return p;
      }
      return null;
    }

    final isoSpec = findPos('isolated');
    final startSpec = findPos('start');
    final midSpec = findPos('middle');
    final endSpec = findPos('end');

    final defaultWord0 = words.isNotEmpty ? words[0].word : letter;
    final defaultWord1 = words.length > 1 ? words[1].word : defaultWord0;
    final defaultWord2 = words.length > 2 ? words[2].word : defaultWord0;
    final defaultWord3 = words.length > 3 ? words[3].word : defaultWord0;

    final positions = <TracingPositionItem>[
      TracingPositionItem(
        position: 'isolated',
        shortLabel: 'مُنْفَصِلٌ',
        displayForm: forms[0],
        audioPath: (isoSpec != null && isoSpec.audioPath.isNotEmpty)
            ? isoSpec.audioPath
            : 'audio/letters/core/${coreKey}_name.mp3',
        exampleWord: isoSpec?.exampleWord ?? defaultWord0,
      ),
      TracingPositionItem(
        position: 'start',
        shortLabel: 'أَوَّلُ الْكَلِمَةِ',
        displayForm: forms[1],
        audioPath: (startSpec != null && startSpec.audioPath.isNotEmpty)
            ? startSpec.audioPath
            : 'audio/letters/core/${coreKey}_pos_start.mp3',
        exampleWord: startSpec?.exampleWord ?? defaultWord1,
      ),
      TracingPositionItem(
        position: 'middle',
        shortLabel: 'وَسَطُ الْكَلِمَةِ',
        displayForm: forms[2],
        audioPath: (midSpec != null && midSpec.audioPath.isNotEmpty)
            ? midSpec.audioPath
            : 'audio/letters/core/${coreKey}_pos_middle.mp3',
        exampleWord: midSpec?.exampleWord ?? defaultWord2,
      ),
      TracingPositionItem(
        position: 'end',
        shortLabel: 'آخِرُ الْكَلِمَةِ',
        displayForm: forms[3],
        audioPath: (endSpec != null && endSpec.audioPath.isNotEmpty)
            ? endSpec.audioPath
            : 'audio/letters/core/${coreKey}_pos_end.mp3',
        exampleWord: endSpec?.exampleWord ?? defaultWord3,
      ),
    ];

    return TracingLetterProfile(
      letterChar: letter,
      definiteTitle: _definiteTitles[letter] ?? 'حَرْفُ ($letter)',
      accentColor: _kiwiiOutlineColors[letter] ?? const Color(0xFFE53935),
      introAudioPath: introAudio,
      positions: positions,
      words: words,
    );
  }
}
