/// Audio Registry — maps audio keys to asset file paths
/// 28 Arabic letters × 7 variants = 196 letter entries + feedback entries
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
  // Variant suffixes
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

  /// Master audio map: key -> asset path
  /// Keys follow pattern: {letter}_{variant}
  /// e.g., 'alif_name' -> 'assets/audio/letters/alif_name.mp3'
  static final Map<String, String> audioMap = {
    // ──── Letters (196 entries) ────
    ..._generateLetterEntries(),

    // ──── Feedback Phrases (10 entries) ────
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
  };

  /// Generate all letter audio entries programmatically
  static Map<String, String> _generateLetterEntries() {
    final entries = <String, String>{};
    for (final letter in letterKeys) {
      for (final variant in variants) {
        final key = '${letter}_$variant';
        entries[key] = 'assets/audio/letters/$key.mp3';
      }
    }
    return entries;
  }

  /// Get audio path for a key, returns null if not found
  static String? getPath(String key) => audioMap[key];

  /// Check if an audio key exists
  static bool hasKey(String key) => audioMap.containsKey(key);

  /// Get all keys for a specific letter
  static List<String> keysForLetter(String letterKey) {
    return variants.map((v) => '${letterKey}_$v').toList();
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
    'alif': 'أَرْنَب', 'baa': 'بَيْت', 'taa': 'تُفَّاحَة', 'thaa': 'ثَعْلَب',
    'jeem': 'جَمَل', 'haa_h': 'حِصَان', 'khaa': 'خَرُوف', 'daal': 'دُبّ',
    'dhaal': 'ذِئْب', 'raa': 'رُمَّان', 'zaay': 'زَرَافَة', 'seen': 'سَمَكَة',
    'sheen': 'شَجَرَة', 'saad': 'صَقْر', 'daad': 'ضِفْدَع', 'taa_t': 'طَائِر',
    'dhaa_dh': 'ظَرْف', 'ain': 'عِنَب', 'ghain': 'غَزَال', 'faa': 'فِيل',
    'qaaf': 'قِطَّة', 'kaaf': 'كَلْب', 'laam': 'لَيْمُون', 'meem': 'مَوْز',
    'noon': 'نَحْلَة', 'haa': 'هِلَال', 'waaw': 'وَرْدَة', 'yaa': 'يَد',
  };
}
