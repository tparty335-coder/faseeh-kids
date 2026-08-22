/// Audio Registry — maps audio keys to asset file paths
/// 28 Arabic letters × 7 core variants = 196 letter entries
/// + extended variants (harakat demos, positions, mudud)
/// + feedback + SFX + instructions + stories
class AudioRegistry {
  AudioRegistry._();

  // ═══════════════════════════════════════════
  // Arabic letter names in order
  // ═══════════════════════════════════════════
  static const List<String> letterKeys = [
    'alif', 'baa', 'taa', 'thaa', 'jeem', 'haa_h', 'khaa',
    'daal', 'dhaal', 'raa', 'zaay', 'seen', 'sheen', 'saad',
    'daad', 'taa_t', 'dhaa_dh', 'ain', 'ghain', 'faa',
    'qaaf', 'kaaf', 'laam', 'meem', 'noon', 'haa', 'waaw', 'yaa',
  ];

  // ═══════════════════════════════════════════
  // Core variant suffixes (required for every letter)
  // ═══════════════════════════════════════════
  static const List<String> variants = [
    'name',     // Letter name: ألف
    'sound',    // Letter sound: أَ
    'fatha',    // With fatha: بَ
    'kasra',    // With kasra: بِ
    'damma',    // With damma: بُ
    'word',     // Example word: أَرْنَب
    'sentence', // Example sentence
  ];

  // ═══════════════════════════════════════════
  // Extended variant suffixes (rich content from MOE CDs)
  // ═══════════════════════════════════════════
  static const List<String> extendedVariants = [
    'fatha_demo',   // Extended fatha demonstration
    'kasra_demo',   // Extended kasra demonstration
    'damma_demo',   // Extended damma demonstration
    'sukoon',       // With sukoon: بْ
    'madd_alif',    // Madd with alif: بَا
    'madd_demo',    // Full madd demonstration
    'word2',        // Second example word
    'word3',        // Third example word
    'word4',        // Fourth example word
    'pos_start',    // Letter at start of word
    'pos_middle',   // Letter in middle of word
    'pos_end',      // Letter at end of word
  ];

  /// Master audio map: key -> asset path
  /// Keys follow pattern: {letter}_{variant}
  static final Map<String, String> audioMap = {
    // ──── Core Letters (196 entries) ────
    ..._generateLetterEntries(),

    // ──── Extended Letters (available from MOE CDs) ────
    ..._generateExtendedLetterEntries(),

    // ──── Feedback Phrases (human voice from MOE CDs) ────
    'feedback_excellent': 'assets/audio/feedback/excellent.mp3',
    'feedback_great': 'assets/audio/feedback/great.mp3',
    'feedback_wonderful': 'assets/audio/feedback/wonderful.mp3',
    'feedback_try_again': 'assets/audio/feedback/try_again.mp3',
    'feedback_close': 'assets/audio/feedback/close.mp3',
    'feedback_champion': 'assets/audio/feedback/champion.mp3',
    'feedback_wow': 'assets/audio/feedback/wow.mp3',
    'feedback_correct': 'assets/audio/feedback/correct.mp3',
    'feedback_continue': 'assets/audio/feedback/continue.mp3',
    'feedback_smart': 'assets/audio/feedback/smart.mp3',

    // ──── SFX (UI sounds) ────
    'sfx_tap': 'assets/audio/sfx/tap.mp3',
    'sfx_correct': 'assets/audio/sfx/correct.mp3',
    'sfx_wrong': 'assets/audio/sfx/wrong.mp3',
    'sfx_complete': 'assets/audio/sfx/complete.mp3',
    'sfx_star': 'assets/audio/sfx/star.mp3',
    'sfx_level_up': 'assets/audio/sfx/level_up.mp3',
    'sfx_streak': 'assets/audio/sfx/streak.mp3',
    'sfx_celebration': 'assets/audio/sfx/celebration.mp3',

    // ──── Alif Story & Exploration (from MOE CD) ────
    'story_alif_welcome': 'assets/audio/stories/alif_welcome.mp3',
    'story_alif_intro': 'assets/audio/stories/alif_intro.mp3',
    'story_alif_goal': 'assets/audio/stories/alif_goal.mp3',
    'story_alif_full': 'assets/audio/stories/alif_story_full.mp3',
    'story_alif_harakat': 'assets/audio/stories/alif_harakat_full.mp3',
    'story_alif_harakat_demo': 'assets/audio/stories/alif_harakat_demo.mp3',
    'story_alif_mudud': 'assets/audio/stories/alif_mudud_full.mp3',
    'story_alif_words': 'assets/audio/stories/alif_words_demo.mp3',
    'story_alif_sentences': 'assets/audio/stories/alif_sentences_demo.mp3',
    'story_alif_review': 'assets/audio/stories/alif_review.mp3',
    for (int i = 1; i <= 9; i++)
      'story_alif_explore_${i.toString().padLeft(2, "0")}':
          'assets/audio/stories/alif_explore_${i.toString().padLeft(2, "0")}.mp3',

    // ──── Alif Tracing Instructions (from MOE CD) ────
    for (int i = 1; i <= 20; i++)
      'instr_alif_trace_${i.toString().padLeft(2, "0")}':
          'assets/audio/instructions/alif_trace_step_${i.toString().padLeft(2, "0")}.mp3',
    'instr_alif_trace_full': 'assets/audio/instructions/alif_trace_full.mp3',
    'instr_alif_trace_praise': 'assets/audio/instructions/alif_trace_praise.mp3',

    // ──── Alif Quiz/Game Instructions (from MOE CD) ────
    'instr_alif_quiz_bee': 'assets/audio/instructions/alif_quiz_bee_intro.mp3',
    'instr_alif_quiz_bee_explain': 'assets/audio/instructions/alif_quiz_bee_explain.mp3',
    'instr_alif_quiz_circle': 'assets/audio/instructions/alif_quiz_circle_intro.mp3',
    'instr_alif_quiz_fish': 'assets/audio/instructions/alif_quiz_fish_intro.mp3',
    'instr_alif_quiz_fish_explain': 'assets/audio/instructions/alif_quiz_fish_explain.mp3',
    'instr_alif_paint': 'assets/audio/instructions/alif_paint_intro.mp3',
    'instr_alif_paint_explain': 'assets/audio/instructions/alif_paint_explain.mp3',
    'instr_alif_words': 'assets/audio/instructions/alif_words_intro.mp3',
  };

  /// Get the correct subdirectory for a given variant
  static String _getFolderForVariant(String variant) {
    if (['name', 'sound', 'pos_start', 'pos_middle', 'pos_end'].contains(variant)) {
      return 'core';
    } else if (['fatha', 'kasra', 'damma', 'sukoon'].contains(variant)) {
      return 'short_vowels';
    } else if (['word', 'word2', 'word3', 'word4'].contains(variant)) {
      return 'words';
    } else if (['sentence', 'fatha_demo', 'kasra_demo', 'damma_demo'].contains(variant)) {
      return 'phrases';
    } else if (['madd_alif', 'madd_demo'].contains(variant)) {
      return 'long_vowels';
    }
    return 'core';
  }

  /// Generate core letter audio entries programmatically
  static Map<String, String> _generateLetterEntries() {
    final entries = <String, String>{};
    for (final letter in letterKeys) {
      for (final variant in variants) {
        final key = '${letter}_$variant';
        final folder = _getFolderForVariant(variant);
        entries[key] = 'assets/audio/letters/$folder/$key.mp3';
      }
    }
    return entries;
  }

  /// Generate extended letter audio entries (MOE CD content)
  static Map<String, String> _generateExtendedLetterEntries() {
    final entries = <String, String>{};
    for (final letter in letterKeys) {
      for (final variant in extendedVariants) {
        final key = '${letter}_$variant';
        final folder = _getFolderForVariant(variant);
        entries[key] = 'assets/audio/letters/$folder/$key.mp3';
      }
    }
    return entries;
  }

  /// Get audio path for a key, returns null if not found
  static String? getPath(String key) => audioMap[key];

  /// Check if an audio key exists
  static bool hasKey(String key) => audioMap.containsKey(key);

  /// Get all core keys for a specific letter
  static List<String> keysForLetter(String letterKey) {
    return variants.map((v) => '${letterKey}_$v').toList();
  }

  /// Get all keys (core + extended) for a specific letter
  static List<String> allKeysForLetter(String letterKey) {
    final keys = <String>[];
    for (final v in variants) {
      keys.add('${letterKey}_$v');
    }
    for (final v in extendedVariants) {
      keys.add('${letterKey}_$v');
    }
    return keys;
  }

  /// Get tracing instruction keys for a letter
  static List<String> tracingKeysForLetter(String letterKey) {
    final keys = <String>[];
    for (int i = 1; i <= 20; i++) {
      final key = 'instr_${letterKey}_trace_${i.toString().padLeft(2, "0")}';
      if (audioMap.containsKey(key)) {
        keys.add(key);
      }
    }
    return keys;
  }

  /// Get story/exploration keys for a letter
  static List<String> storyKeysForLetter(String letterKey) {
    return audioMap.keys
        .where((k) => k.startsWith('story_$letterKey'))
        .toList();
  }

  /// Total number of audio entries
  static int get totalEntries => audioMap.length;

  /// Arabic letter names for display
  static const Map<String, String> letterNamesArabic = {
    'alif': 'ألف', 'baa': 'باء', 'taa': 'تاء', 'thaa': 'ثاء',
    'jeem': 'جيم', 'haa_h': 'حاء', 'khaa': 'خاء', 'daal': 'دال',
    'dhaal': 'ذال', 'raa': 'راء', 'zaay': 'زاي', 'seen': 'سين',
    'sheen': 'شين', 'saad': 'صاد', 'daad': 'ضاد', 'taa_t': 'طاء',
    'dhaa_dh': 'ظاء', 'ain': 'عين', 'ghain': 'غين', 'faa': 'فاء',
    'qaaf': 'قاف', 'kaaf': 'كاف', 'laam': 'لام', 'meem': 'ميم',
    'noon': 'نون', 'haa': 'هاء', 'waaw': 'واو', 'yaa': 'ياء',
  };

  /// Arabic letter characters (isolated form)
  static const Map<String, String> letterCharsArabic = {
    'alif': 'أ', 'baa': 'ب', 'taa': 'ت', 'thaa': 'ث',
    'jeem': 'ج', 'haa_h': 'ح', 'khaa': 'خ', 'daal': 'د',
    'dhaal': 'ذ', 'raa': 'ر', 'zaay': 'ز', 'seen': 'س',
    'sheen': 'ش', 'saad': 'ص', 'daad': 'ض', 'taa_t': 'ط',
    'dhaa_dh': 'ظ', 'ain': 'ع', 'ghain': 'غ', 'faa': 'ف',
    'qaaf': 'ق', 'kaaf': 'ك', 'laam': 'ل', 'meem': 'م',
    'noon': 'ن', 'haa': 'ه', 'waaw': 'و', 'yaa': 'ي',
  };

  /// Example words for each letter
  static const Map<String, String> exampleWords = {
    'alif': 'أَسَد', 'baa': 'بَيْت', 'taa': 'تُفَّاحَة', 'thaa': 'ثَعْلَب',
    'jeem': 'جَمَل', 'haa_h': 'حِصَان', 'khaa': 'خَرُوف', 'daal': 'دُبّ',
    'dhaal': 'ذِئْب', 'raa': 'رُمَّان', 'zaay': 'زَرَافَة', 'seen': 'سَمَكَة',
    'sheen': 'شَجَرَة', 'saad': 'صَقْر', 'daad': 'ضِفْدَع', 'taa_t': 'طَائِر',
    'dhaa_dh': 'ظَرْف', 'ain': 'عِنَب', 'ghain': 'غَزَال', 'faa': 'فِيل',
    'qaaf': 'قِطَّة', 'kaaf': 'كَلْب', 'laam': 'لَيْمُون', 'meem': 'مَوْز',
    'noon': 'نَحْلَة', 'haa': 'هِلَال', 'waaw': 'وَرْدَة', 'yaa': 'يَد',
  };
  /// Reverse lookup: Arabic character → registry key (cached)
  static final Map<String, String> _charToKey = {
    for (final entry in letterCharsArabic.entries) entry.value: entry.key,
  };

  /// Convert Arabic letter character to its AudioRegistry key
  /// e.g., 'أ' → 'alif', 'ب' → 'baa'
  static String letterKeyFromChar(String letterChar) {
    return _charToKey[letterChar] ?? 'alif';
  }
}
