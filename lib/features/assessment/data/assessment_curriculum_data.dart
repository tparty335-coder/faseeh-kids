import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/lessons/data/all_letter_manifests.dart';
import 'package:faseeh_kids/features/lessons/data/letter_tracing_words_catalog.dart';

/// وحدة تقييم واحدة تضم ٧ حروف عربية متتالية (٢٨ حرفاً = ٤ وحدات قياس)
class AssessmentUnitSpec {
  final int unitIndex; // 1..4
  final String titleAr;
  final String subtitleAr;
  final List<String> letters; // 7 letters
  final Color primaryColor;
  final Color secondaryColor;
  final String badgeEmoji;
  final List<UnitSentenceSpec> sentences;

  const AssessmentUnitSpec({
    required this.unitIndex,
    required this.titleAr,
    required this.subtitleAr,
    required this.letters,
    required this.primaryColor,
    required this.secondaryColor,
    required this.badgeEmoji,
    required this.sentences,
  });
}

/// جملة بسيطة مضبوطة بالشكل لتمرين تكوين الجملة لكل وحدة
class UnitSentenceSpec {
  final String fullSentence;
  final List<String> words;
  final String hintLetter; // حرف مرتبط بالصورة التوضيحية المضمونة من الكتالوج

  const UnitSentenceSpec({
    required this.fullSentence,
    required this.words,
    required this.hintLetter,
  });
}

/// كلمة قابلة للتركيب والتقطيع والتحليل الصوتي (٣ أو ٤ حروف حقيقية مضبوطة)
class BuildableWordSpec {
  final String plainWord; // بدون تشكيل لتقطيع الحروف بدقة (مثل: أسد)
  final String voweledWord; // بالتشكيل الكامل (مثل: أَسَدٌ)
  final List<String> baseLetters; // الحروف الأساسية بالترتيب (مثل: ['أ','س','د'])
  final List<String> positionalTiles; // أشكال الحروف المقطّعة للتمرين (مثل: ['أ','سَـ','ـدٌ'])
  final String targetLetter; // الحرف المستهدف في هذه الكلمة
  final String positionInWord; // 'start' | 'middle' | 'end'
  final String? harakaOnStart; // 'fatha' | 'damma' | 'kasra' (عندما يكون في أول الكلمة)

  const BuildableWordSpec({
    required this.plainWord,
    required this.voweledWord,
    required this.baseLetters,
    required this.positionalTiles,
    required this.targetLetter,
    required this.positionInWord,
    this.harakaOnStart,
  });
}

/// الملف اللغوي الكامل لكل حرف من الحروف الـ ٢٨
class LetterKnowledgeSpec {
  final String letter; // 'أ'..'ي'
  final String displayChar; // 'هـ' للهاء، والباقي كما هو
  final String nameAr; // الْأَلِفُ
  final String coreAudioKey; // alif..yaa
  final int unitIndex; // 1..4
  final bool isKicking; // الحروف الرافسة الستة: أ د ذ ر ز و
  final String isolatedForm;
  final String initialForm;
  final String medialConnectedForm;
  final String medialDisconnectedForm;
  final String finalConnectedForm;
  final String finalDisconnectedForm;
  final int dotCount;
  final String dotDescriptionAr;
  final List<String> similarLetters;
  final String fathaWord;
  final String dammaWord;
  final String kasraWord;
  final List<BuildableWordSpec> words;

  const LetterKnowledgeSpec({
    required this.letter,
    required this.displayChar,
    required this.nameAr,
    required this.coreAudioKey,
    required this.unitIndex,
    required this.isKicking,
    required this.isolatedForm,
    required this.initialForm,
    required this.medialConnectedForm,
    required this.medialDisconnectedForm,
    required this.finalConnectedForm,
    required this.finalDisconnectedForm,
    required this.dotCount,
    required this.dotDescriptionAr,
    required this.similarLetters,
    required this.fathaWord,
    required this.dammaWord,
    required this.kasraWord,
    required this.words,
  });

  String get nameAudioPath => 'audio/letters/core/${coreAudioKey}_name.mp3';
  String get fathaAudioPath => 'audio/letters/short_vowels/${coreAudioKey}_fatha.mp3';
  String get dammaAudioPath => 'audio/letters/short_vowels/${coreAudioKey}_damma.mp3';
  String get kasraAudioPath => 'audio/letters/short_vowels/${coreAudioKey}_kasra.mp3';
}

/// قاعدة البيانات العلمية الشاملة لجميع الوحدات الأربع (٢٨ حرفاً)
class AssessmentCurriculumData {
  AssessmentCurriculumData._();

  static const Set<String> kickingLetters = {'أ', 'ا', 'د', 'ذ', 'ر', 'ز', 'و'};

  /// الوحدات الأربع القياسية — اختبار قياس مستوى بعد كل ٧ حروف
  static const List<AssessmentUnitSpec> units = [
    AssessmentUnitSpec(
      unitIndex: 1,
      titleAr: 'الْوَحْدَةُ الْأُولَى',
      subtitleAr: 'أ • ب • ت • ث • ج • ح • خ',
      letters: ['أ', 'ب', 'ت', 'ث', 'ج', 'ح', 'خ'],
      primaryColor: Color(0xFFE53935),
      secondaryColor: Color(0xFFF59E0B),
      badgeEmoji: '🦁',
      sentences: [
        UnitSentenceSpec(
          fullSentence: 'الْأَسَدُ مَلِكُ الْغَابَةِ',
          words: ['الْأَسَدُ', 'مَلِكُ', 'الْغَابَةِ'],
          hintLetter: 'أ',
        ),
        UnitSentenceSpec(
          fullSentence: 'الْجَمَلُ فِي الصَّحْرَاءِ',
          words: ['الْجَمَلُ', 'فِي', 'الصَّحْرَاءِ'],
          hintLetter: 'ج',
        ),
        UnitSentenceSpec(
          fullSentence: 'الْحِصَانُ يَجْرِي سَرِيعًا',
          words: ['الْحِصَانُ', 'يَجْرِي', 'سَرِيعًا'],
          hintLetter: 'ح',
        ),
        UnitSentenceSpec(
          fullSentence: 'التُّفَّاحَةُ حُلْوَةٌ وَلَذِيذَةٌ',
          words: ['التُّفَّاحَةُ', 'حُلْوَةٌ', 'وَلَذِيذَةٌ'],
          hintLetter: 'ت',
        ),
        UnitSentenceSpec(
          fullSentence: 'الْخَرُوفُ يَأْكُلُ الْعُشْبَ',
          words: ['الْخَرُوفُ', 'يَأْكُلُ', 'الْعُشْبَ'],
          hintLetter: 'خ',
        ),
      ],
    ),
    AssessmentUnitSpec(
      unitIndex: 2,
      titleAr: 'الْوَحْدَةُ الثَّانِيَةُ',
      subtitleAr: 'د • ذ • ر • ز • س • ش • ص',
      letters: ['د', 'ذ', 'ر', 'ز', 'س', 'ش', 'ص'],
      primaryColor: Color(0xFF0284C7),
      secondaryColor: Color(0xFF0D9488),
      badgeEmoji: '🐟',
      sentences: [
        UnitSentenceSpec(
          fullSentence: 'السَّمَكَةُ تَسْبَحُ فِي الْبَحْرِ',
          words: ['السَّمَكَةُ', 'تَسْبَحُ', 'فِي', 'الْبَحْرِ'],
          hintLetter: 'س',
        ),
        UnitSentenceSpec(
          fullSentence: 'الشَّمْسُ تُشْرِقُ صَبَاحًا',
          words: ['الشَّمْسُ', 'تُشْرِقُ', 'صَبَاحًا'],
          hintLetter: 'ش',
        ),
        UnitSentenceSpec(
          fullSentence: 'الزَّرَافَةُ رَقَبَتُهَا طَوِيلَةٌ',
          words: ['الزَّرَافَةُ', 'رَقَبَتُهَا', 'طَوِيلَةٌ'],
          hintLetter: 'ز',
        ),
        UnitSentenceSpec(
          fullSentence: 'الصَّقْرُ يَطِيرُ عَالِيًا',
          words: ['الصَّقْرُ', 'يَطِيرُ', 'عَالِيًا'],
          hintLetter: 'ص',
        ),
        UnitSentenceSpec(
          fullSentence: 'الدُّبُّ يُحِبُّ الْعَسَلَ',
          words: ['الدُّبُّ', 'يُحِبُّ', 'الْعَسَلَ'],
          hintLetter: 'د',
        ),
      ],
    ),
    AssessmentUnitSpec(
      unitIndex: 3,
      titleAr: 'الْوَحْدَةُ الثَّالِثَةُ',
      subtitleAr: 'ض • ط • ظ • ع • غ • ف • ق',
      letters: ['ض', 'ط', 'ظ', 'ع', 'غ', 'ف', 'ق'],
      primaryColor: Color(0xFF7C3AED),
      secondaryColor: Color(0xFFDB2777),
      badgeEmoji: '🐘',
      sentences: [
        UnitSentenceSpec(
          fullSentence: 'الضِّفْدَعُ يَقْفِزُ فِي الْمَاءِ',
          words: ['الضِّفْدَعُ', 'يَقْفِزُ', 'فِي', 'الْمَاءِ'],
          hintLetter: 'ض',
        ),
        UnitSentenceSpec(
          fullSentence: 'الْفِيلُ كَبِيرٌ وَقَوِيٌّ',
          words: ['الْفِيلُ', 'كَبِيرٌ', 'وَقَوِيٌّ'],
          hintLetter: 'ف',
        ),
        UnitSentenceSpec(
          fullSentence: 'الْقَمَرُ يُنِيرُ اللَّيْلَ',
          words: ['الْقَمَرُ', 'يُنِيرُ', 'اللَّيْلَ'],
          hintLetter: 'ق',
        ),
        UnitSentenceSpec(
          fullSentence: 'الْعُصْفُورُ يُغَرِّدُ فَوْقَ الشَّجَرَةِ',
          words: ['الْعُصْفُورُ', 'يُغَرِّدُ', 'فَوْقَ', 'الشَّجَرَةِ'],
          hintLetter: 'ع',
        ),
        UnitSentenceSpec(
          fullSentence: 'الْغَزَالُ يَرْكُضُ بِخِفَّةٍ',
          words: ['الْغَزَالُ', 'يَرْكُضُ', 'بِخِفَّةٍ'],
          hintLetter: 'غ',
        ),
      ],
    ),
    AssessmentUnitSpec(
      unitIndex: 4,
      titleAr: 'الْوَحْدَةُ الرَّابِعَةُ',
      subtitleAr: 'ك • ل • م • ن • هـ • و • ي',
      letters: ['ك', 'ل', 'م', 'ن', 'ه', 'و', 'ي'],
      primaryColor: Color(0xFF16A34A),
      secondaryColor: Color(0xFFD97706),
      badgeEmoji: '🍌',
      sentences: [
        UnitSentenceSpec(
          fullSentence: 'الْمَوْزُ أَصْفَرُ وَلَذِيذٌ',
          words: ['الْمَوْزُ', 'أَصْفَرُ', 'وَلَذِيذٌ'],
          hintLetter: 'م',
        ),
        UnitSentenceSpec(
          fullSentence: 'الْكَلْبُ صَدِيقٌ وَفِيٌّ',
          words: ['الْكَلْبُ', 'صَدِيقٌ', 'وَفِيٌّ'],
          hintLetter: 'ك',
        ),
        UnitSentenceSpec(
          fullSentence: 'النَّحْلَةُ تَصْنَعُ الْعَسَلَ',
          words: ['النَّحْلَةُ', 'تَصْنَعُ', 'الْعَسَلَ'],
          hintLetter: 'ن',
        ),
        UnitSentenceSpec(
          fullSentence: 'الْوَرْدَةُ عِطْرُهَا جَمِيلٌ',
          words: ['الْوَرْدَةُ', 'عِطْرُهَا', 'جَمِيلٌ'],
          hintLetter: 'و',
        ),
        UnitSentenceSpec(
          fullSentence: 'الْهِلَالُ يَظْهَرُ فِي السَّمَاءِ',
          words: ['الْهِلَالُ', 'يَظْهَرُ', 'فِي', 'السَّمَاءِ'],
          hintLetter: 'ه',
        ),
      ],
    ),
  ];

  static AssessmentUnitSpec unitByIndex(int index) {
    return units.firstWhere(
      (u) => u.unitIndex == index,
      orElse: () => units.first,
    );
  }

  /// البيانات اللغوية الكاملة للحروف الـ ٢٨
  static final Map<String, LetterKnowledgeSpec> letters = _buildLettersMap();

  static List<String> get allLetterChars =>
      units.expand((u) => u.letters).toList(growable: false);

  static LetterKnowledgeSpec letterSpec(String raw) {
    final normalized = LetterTracingWordsCatalog.normalizeLetter(raw);
    return letters[normalized] ?? letters['أ']!;
  }

  /// مستطيل القص النظيف لبطاقات محطة الكلمات (words_p*_card_*.webp)
  static const Rect _wordCardCropRect = Rect.fromLTRB(0.135, 0.37, 0.47, 0.88);

  /// إزالة جميع علامات التشكيل والتطويل من الكلمة العربية للتحليل اللغوي الدقيق
  static String stripDiacritics(String input) {
    return input
        .replaceAll(RegExp(r'[\u064B-\u065F\u0670\u0640]'), '')
        .trim();
  }

  /// توحيد الحرف العربي (أ/إ/آ/ا -> أ ، هـ -> ه)
  static String normalizeChar(String ch) {
    final t = ch.trim();
    if (t == 'أ' || t == 'إ' || t == 'آ' || t == 'ا') return 'أ';
    if (t == 'هـ') return 'ه';
    return t;
  }

  /// استخراج جميع الحروف الأساسية داخل الكلمة (مع تضمين ت و هـ عند وجود ة لمنع أي لبس للمشتتات)
  static Set<String> wordLetterSet(String word) {
    final plain = stripDiacritics(word);
    final result = <String>{};
    for (int i = 0; i < plain.length; i++) {
      final ch = plain[i];
      if (ch == 'ة') {
        result.add('ت');
        result.add('ه');
      } else if (ch == 'ى') {
        result.add('ي');
        result.add('أ');
      } else {
        result.add(normalizeChar(ch));
      }
    }
    return result;
  }

  /// هل تحتوي الكلمة على هذا الحرف في أي موضع؟
  static bool wordContainsLetter(String word, String letter) {
    return wordLetterSet(word).contains(normalizeChar(letter));
  }

  /// هل تبدأ الكلمة فعلاً بهذا الحرف؟
  static bool wordStartsWithLetter(String word, String letter) {
    final plain = stripDiacritics(word);
    if (plain.isEmpty) return false;
    return normalizeChar(plain[0]) == normalizeChar(letter);
  }

  /// إزالة الحركة عن الحرف الأول فقط (لإخفاء إجابة سؤال الحركة قبل الحل)
  static String stripFirstLetterHaraka(String voweledWord) {
    if (voweledWord.isEmpty) return voweledWord;
    int i = 1;
    while (i < voweledWord.length &&
        RegExp(r'[\u064B-\u065F\u0670]').hasMatch(voweledWord[i])) {
      i++;
    }
    // توحيد الهمزة المكسورة (إ) إلى (أ) عند إخفاء الحركة حتى لا تكشف الإجابة!
    final first = voweledWord[0] == 'إ' ? 'أ' : voweledWord[0];
    return '$first${voweledWord.substring(i)}';
  }

  /// استخراج الحركة القصيرة على الحرف الأول من الكلمة المشكولة ('fatha' | 'damma' | 'kasra' | null)
  static String? leadingHarakaOf(String voweledWord) {
    if (voweledWord.isEmpty) return null;
    if (voweledWord[0] == 'إ') return 'kasra';
    for (int i = 1; i < voweledWord.length; i++) {
      final ch = voweledWord[i];
      if (ch == '\u064E') return 'fatha';
      if (ch == '\u064F') return 'damma';
      if (ch == '\u0650') return 'kasra';
      if (ch == '\u0651') continue; // تخطي الشدة إن وُجدت
      break;
    }
    return null;
  }

  /// بنك الصور الكرتونية الموثّقة الشامل لكل التطبيق (مبني مرة واحدة من كتالوج التتبع + بطاقات الكلمات)
  static List<TracingWordIllustration>? _cachedGlobalBank;

  static List<TracingWordIllustration> get globalIllustrationBank {
    if (_cachedGlobalBank != null) return _cachedGlobalBank!;
    final bank = <TracingWordIllustration>[];
    final seenKey = <String>{};

    void addItem(TracingWordIllustration item) {
      final cleanWord = stripDiacritics(item.word);
      if (cleanWord.isEmpty || item.imagePath.isEmpty) return;
      final key = '${cleanWord}_${item.imagePath}';
      if (seenKey.add(key)) {
        bank.add(item);
      }
    }

    // 1. جميع بطاقات الكلمات الموثّقة من كتالوج التتبع (٢٨ حرفاً × ٤ كلمات)
    for (final l in allLetterChars) {
      final profile = LetterTracingWordsCatalog.getProfile(l);
      for (final w in profile.words) {
        addItem(w);
      }
    }

    // 2. جميع بطاقات محطة الكلمات في المانيفستات الـ ٢٦ (تغطية ضخمة وموثّقة على القرص)
    for (final manifest in allCurriculumManifests) {
      for (final page in manifest.words.pages) {
        for (final card in page.words) {
          addItem(
            TracingWordIllustration(
              word: card.word,
              imagePath: card.cardImagePath,
              audioPath: card.audioPath,
              cropRect: _wordCardCropRect,
            ),
          );
        }
      }
    }

    _cachedGlobalBank = List.unmodifiable(bank);
    return _cachedGlobalBank!;
  }

  /// جميع الصور الموثّقة التي تبدأ كلمتها فعلياً بالحرف المطلوب (مضمونة لكل الـ ٢٨ حرفاً!)
  static List<TracingWordIllustration> startingIllustrationsFor(String rawLetter) {
    final target = normalizeChar(rawLetter);
    final seenWords = <String>{};
    final result = <TracingWordIllustration>[];
    for (final item in globalIllustrationBank) {
      if (wordStartsWithLetter(item.word, target)) {
        final plain = stripDiacritics(item.word);
        if (seenWords.add(plain)) {
          result.add(item);
        }
      }
    }
    return result;
  }

  /// البحث عن صورة كرتونية مطابقة تماماً للكلمة المطلوبة (مع دعم حذف الـ التعريف مثل الْحِصَانُ -> حِصَان)
  static TracingWordIllustration? illustrationForExactWord(String rawWord) {
    var clean = stripDiacritics(rawWord);
    if (clean.startsWith('ال') && clean.length > 3) {
      clean = clean.substring(2);
    }
    // توحيد الهمزات للمطابقة فقط
    String normWord(String s) => s
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ة', 'ه');

    final targetNorm = normWord(clean);
    for (final item in globalIllustrationBank) {
      var itemClean = stripDiacritics(item.word);
      if (itemClean.startsWith('ال') && itemClean.length > 3) {
        itemClean = itemClean.substring(2);
      }
      if (normWord(itemClean) == targetNorm) {
        return item;
      }
    }
    return null;
  }

  /// البحث عن صورة كرتونية تبدأ بالحرف المطلوب وبنفس الحركة القصيرة تماماً
  static TracingWordIllustration? illustrationForLetterAndHaraka(
    String rawLetter,
    String haraka,
  ) {
    for (final item in startingIllustrationsFor(rawLetter)) {
      if (leadingHarakaOf(item.word) == haraka) {
        return item;
      }
    }
    return null;
  }

  /// استخراج كلمة مصورة تبدأ بالحرف المطلوب (بديل آمن تماماً لـ primaryIllustrationFor)
  static TracingWordIllustration primaryIllustrationFor(String rawLetter, {int index = 0}) {
    final starts = startingIllustrationsFor(rawLetter);
    if (starts.isNotEmpty) {
      return starts[index % starts.length];
    }
    final profile = LetterTracingWordsCatalog.getProfile(rawLetter);
    if (profile.words.isEmpty) {
      return LetterTracingWordsCatalog.getProfile('أ').words.first;
    }
    return profile.words[index % profile.words.length];
  }

  /// دالة مساعدة لتوليد المقاطع المقطّعة الصحيحة إملائياً لأي كلمة عربية
  static List<String> buildPositionalTiles(List<String> baseLetters) {
    final result = <String>[];
    for (int i = 0; i < baseLetters.length; i++) {
      final ch = baseLetters[i];
      final prevConnects = i > 0 && !kickingLetters.contains(baseLetters[i - 1]);
      final nextExists = i < baseLetters.length - 1;
      final selfConnectsForward = !kickingLetters.contains(ch) && ch != 'ة' && ch != 'ء';

      final prefix = prevConnects ? 'ـ' : '';
      final suffix = (nextExists && selfConnectsForward) ? 'ـ' : '';
      result.add('$prefix$ch$suffix');
    }
    return result;
  }

  static BuildableWordSpec _w(
    String plain,
    String voweled,
    List<String> chars,
    String target,
    String pos, {
    String? haraka,
  }) {
    return BuildableWordSpec(
      plainWord: plain,
      voweledWord: voweled,
      baseLetters: chars,
      positionalTiles: buildPositionalTiles(chars),
      targetLetter: target,
      positionInWord: pos,
      harakaOnStart: haraka,
    );
  }

  static LetterKnowledgeSpec _makeLetter({
    required String letter,
    required String nameAr,
    required String coreKey,
    required int unitIndex,
    required int dotCount,
    required String dotDesc,
    required List<String> similar,
    required String fathaWord,
    required String dammaWord,
    required String kasraWord,
    required List<BuildableWordSpec> words,
  }) {
    final kicking = kickingLetters.contains(letter);
    final initial = kicking ? letter : '$letterـ';
    final medialConn = kicking ? 'ـ$letter' : 'ـ$letterـ';
    final medialDisc = kicking ? letter : '$letterـ';
    final finalConn = 'ـ$letter';
    final finalDisc = letter;

    return LetterKnowledgeSpec(
      letter: letter,
      displayChar: letter == 'ه' ? 'هـ' : letter,
      nameAr: nameAr,
      coreAudioKey: coreKey,
      unitIndex: unitIndex,
      isKicking: kicking,
      isolatedForm: letter,
      initialForm: initial,
      medialConnectedForm: medialConn,
      medialDisconnectedForm: medialDisc,
      finalConnectedForm: finalConn,
      finalDisconnectedForm: finalDisc,
      dotCount: dotCount,
      dotDescriptionAr: dotDesc,
      similarLetters: similar,
      fathaWord: fathaWord,
      dammaWord: dammaWord,
      kasraWord: kasraWord,
      words: words,
    );
  }

  static Map<String, LetterKnowledgeSpec> _buildLettersMap() {
    final list = <LetterKnowledgeSpec>[
      // ═══════════════════════ الوحدة 1 ═══════════════════════
      _makeLetter(
        letter: 'أ',
        nameAr: 'الْأَلِفُ',
        coreKey: 'alif',
        unitIndex: 1,
        dotCount: 0,
        dotDesc: 'عَمُودٌ مُسْتَقِيمٌ فَوْقَهُ هَمْزَةٌ وَلَا نُقَطَ لَهُ',
        similar: ['ل', 'و', 'د'],
        fathaWord: 'أَسَدٌ',
        dammaWord: 'أُذُنٌ',
        kasraWord: 'إِبْرَةٌ',
        words: [
          _w('أسد', 'أَسَدٌ', ['أ', 'س', 'د'], 'أ', 'start', haraka: 'fatha'),
          _w('أرنب', 'أَرْنَبٌ', ['أ', 'ر', 'ن', 'ب'], 'أ', 'start', haraka: 'fatha'),
          _w('أذن', 'أُذُنٌ', ['أ', 'ذ', 'ن'], 'أ', 'start', haraka: 'damma'),
          _w('فأس', 'فَأْسٌ', ['ف', 'أ', 'س'], 'أ', 'middle'),
          _w('قرأ', 'قَرَأَ', ['ق', 'ر', 'أ'], 'أ', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'ب',
        nameAr: 'الْبَاءُ',
        coreKey: 'baa',
        unitIndex: 1,
        dotCount: 1,
        dotDesc: 'نُقْطَةٌ وَاحِدَةٌ تَحْتَ الْحَرْفِ',
        similar: ['ت', 'ث', 'ن', 'ي'],
        fathaWord: 'بَطَّةٌ',
        dammaWord: 'بُرْتُقَالٌ',
        kasraWord: 'بِطِّيخٌ',
        words: [
          _w('بطة', 'بَطَّةٌ', ['ب', 'ط', 'ة'], 'ب', 'start', haraka: 'fatha'),
          _w('بيت', 'بَيْتٌ', ['ب', 'ي', 'ت'], 'ب', 'start', haraka: 'fatha'),
          _w('جبل', 'جَبَلٌ', ['ج', 'ب', 'ل'], 'ب', 'middle'),
          _w('عنب', 'عِنَبٌ', ['ع', 'ن', 'ب'], 'ب', 'end'),
          _w('كلب', 'كَلْبٌ', ['ك', 'ل', 'ب'], 'ب', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'ت',
        nameAr: 'التَّاءُ',
        coreKey: 'taa',
        unitIndex: 1,
        dotCount: 2,
        dotDesc: 'نُقْطَتَانِ فَوْقَ الْحَرْفِ',
        similar: ['ب', 'ث', 'ن', 'ي'],
        fathaWord: 'تَمْرٌ',
        dammaWord: 'تُفَّاحٌ',
        kasraWord: 'تِمْسَاحٌ',
        words: [
          _w('تمر', 'تَمْرٌ', ['ت', 'م', 'ر'], 'ت', 'start', haraka: 'fatha'),
          _w('توت', 'تُوتٌ', ['ت', 'و', 'ت'], 'ت', 'start', haraka: 'damma'),
          _w('تاج', 'تَاجٌ', ['ت', 'ا', 'ج'], 'ت', 'start', haraka: 'fatha'),
          _w('كتاب', 'كِتَابٌ', ['ك', 'ت', 'ا', 'ب'], 'ت', 'middle'),
          _w('بيت', 'بَيْتٌ', ['ب', 'ي', 'ت'], 'ت', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'ث',
        nameAr: 'الثَّاءُ',
        coreKey: 'thaa',
        unitIndex: 1,
        dotCount: 3,
        dotDesc: 'ثَلَاثُ نُقَطٍ فَوْقَ الْحَرْفِ',
        similar: ['ت', 'ب', 'ش'],
        fathaWord: 'ثَعْلَبٌ',
        dammaWord: 'ثُعْبَانٌ',
        kasraWord: 'ثِمَارٌ',
        words: [
          _w('ثور', 'ثَوْرٌ', ['ث', 'و', 'ر'], 'ث', 'start', haraka: 'fatha'),
          _w('ثلج', 'ثَلْجٌ', ['ث', 'ل', 'ج'], 'ث', 'start', haraka: 'fatha'),
          _w('ثعلب', 'ثَعْلَبٌ', ['ث', 'ع', 'ل', 'ب'], 'ث', 'start', haraka: 'fatha'),
          _w('مثلث', 'مُثَلَّثٌ', ['م', 'ث', 'ل', 'ث'], 'ث', 'middle'),
          _w('أثاث', 'أَثَاثٌ', ['أ', 'ث', 'ا', 'ث'], 'ث', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'ج',
        nameAr: 'الْجِيمُ',
        coreKey: 'jeem',
        unitIndex: 1,
        dotCount: 1,
        dotDesc: 'نُقْطَةٌ وَاحِدَةٌ فِي بَطْنِ الْحَرْفِ',
        similar: ['ح', 'خ'],
        fathaWord: 'جَمَلٌ',
        dammaWord: 'جُبْنٌ',
        kasraWord: 'جِسْرٌ',
        words: [
          _w('جمل', 'جَمَلٌ', ['ج', 'م', 'ل'], 'ج', 'start', haraka: 'fatha'),
          _w('جزر', 'جَزَرٌ', ['ج', 'ز', 'ر'], 'ج', 'start', haraka: 'fatha'),
          _w('جبن', 'جُبْنٌ', ['ج', 'ب', 'ن'], 'ج', 'start', haraka: 'damma'),
          _w('شجرة', 'شَجَرَةٌ', ['ش', 'ج', 'ر', 'ة'], 'ج', 'middle'),
          _w('برج', 'بُرْجٌ', ['ب', 'ر', 'ج'], 'ج', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'ح',
        nameAr: 'الْحَاءُ',
        coreKey: 'haa_h',
        unitIndex: 1,
        dotCount: 0,
        dotDesc: 'لَا نُقَطَ لَهُ أَبَدًا',
        similar: ['ج', 'خ'],
        fathaWord: 'حَمَامَةٌ',
        dammaWord: 'حُوتٌ',
        kasraWord: 'حِصَانٌ',
        words: [
          _w('حوت', 'حُوتٌ', ['ح', 'و', 'ت'], 'ح', 'start', haraka: 'damma'),
          _w('حبل', 'حَبْلٌ', ['ح', 'ب', 'ل'], 'ح', 'start', haraka: 'fatha'),
          _w('حصان', 'حِصَانٌ', ['ح', 'ص', 'ا', 'ن'], 'ح', 'start', haraka: 'kasra'),
          _w('نحلة', 'نَحْلَةٌ', ['ن', 'ح', 'ل', 'ة'], 'ح', 'middle'),
          _w('ملح', 'مِلْحٌ', ['م', 'ل', 'ح'], 'ح', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'خ',
        nameAr: 'الْخَاءُ',
        coreKey: 'khaa',
        unitIndex: 1,
        dotCount: 1,
        dotDesc: 'نُقْطَةٌ وَاحِدَةٌ فَوْقَ رَأْسِ الْحَرْفِ',
        similar: ['ج', 'ح'],
        fathaWord: 'خَرُوفٌ',
        dammaWord: 'خُبْزٌ',
        kasraWord: 'خِيَارٌ',
        words: [
          _w('خبز', 'خُبْزٌ', ['خ', 'ب', 'ز'], 'خ', 'start', haraka: 'damma'),
          _w('خوخ', 'خَوْخٌ', ['خ', 'و', 'خ'], 'خ', 'start', haraka: 'fatha'),
          _w('خروف', 'خَرُوفٌ', ['خ', 'ر', 'و', 'ف'], 'خ', 'start', haraka: 'fatha'),
          _w('نخلة', 'نَخْلَةٌ', ['ن', 'خ', 'ل', 'ة'], 'خ', 'middle'),
          _w('مطبخ', 'مَطْبَخٌ', ['م', 'ط', 'ب', 'خ'], 'خ', 'end'),
        ],
      ),

      // ═══════════════════════ الوحدة 2 ═══════════════════════
      _makeLetter(
        letter: 'د',
        nameAr: 'الدَّالُ',
        coreKey: 'daal',
        unitIndex: 2,
        dotCount: 0,
        dotDesc: 'حَرْفٌ رَافِسٌ بِلَا نُقَطٍ',
        similar: ['ذ', 'ر', 'ز'],
        fathaWord: 'دَجَاجَةٌ',
        dammaWord: 'دُبٌّ',
        kasraWord: 'دِيكٌ',
        words: [
          _w('ديك', 'دِيكٌ', ['د', 'ي', 'ك'], 'د', 'start', haraka: 'kasra'),
          _w('دلو', 'دَلْوٌ', ['د', 'ل', 'و'], 'د', 'start', haraka: 'fatha'),
          _w('دب', 'دُبٌّ', ['د', 'ب'], 'د', 'start', haraka: 'damma'),
          _w('هدية', 'هَدِيَّةٌ', ['ه', 'د', 'ي', 'ة'], 'د', 'middle'),
          _w('ولد', 'وَلَدٌ', ['و', 'ل', 'د'], 'د', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'ذ',
        nameAr: 'الذَّالُ',
        coreKey: 'dhaal',
        unitIndex: 2,
        dotCount: 1,
        dotDesc: 'مِثْلُ الدَّالِ وَلَكِنْ فَوْقَهُ نُقْطَةٌ وَاحِدَةٌ',
        similar: ['د', 'ز', 'ر'],
        fathaWord: 'ذَهَبٌ',
        dammaWord: 'ذُرَةٌ',
        kasraWord: 'ذِئْبٌ',
        words: [
          _w('ذرة', 'ذُرَةٌ', ['ذ', 'ر', 'ة'], 'ذ', 'start', haraka: 'damma'),
          _w('ذئب', 'ذِئْبٌ', ['ذ', 'ئ', 'ب'], 'ذ', 'start', haraka: 'kasra'),
          _w('ذهب', 'ذَهَبٌ', ['ذ', 'ه', 'ب'], 'ذ', 'start', haraka: 'fatha'),
          _w('أذن', 'أُذُنٌ', ['أ', 'ذ', 'ن'], 'ذ', 'middle'),
          _w('قنفذ', 'قُنْفُذٌ', ['ق', 'ن', 'ف', 'ذ'], 'ذ', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'ر',
        nameAr: 'الرَّاءُ',
        coreKey: 'raa',
        unitIndex: 2,
        dotCount: 0,
        dotDesc: 'يَنْزِلُ تَحْتَ السَّطْرِ بِلَا نُقَطٍ',
        similar: ['ز', 'د', 'و'],
        fathaWord: 'رَجُلٌ',
        dammaWord: 'رُمَّانٌ',
        kasraWord: 'رِيشَةٌ',
        words: [
          _w('رجل', 'رَجُلٌ', ['ر', 'ج', 'ل'], 'ر', 'start', haraka: 'fatha'),
          _w('رمل', 'رَمْلٌ', ['ر', 'م', 'ل'], 'ر', 'start', haraka: 'fatha'),
          _w('كرز', 'كَرَزٌ', ['ك', 'ر', 'ز'], 'ر', 'middle'),
          _w('قمر', 'قَمَرٌ', ['ق', 'م', 'ر'], 'ر', 'end'),
          _w('نهر', 'نَهْرٌ', ['ن', 'ه', 'ر'], 'ر', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'ز',
        nameAr: 'الزَّايُ',
        coreKey: 'zaay',
        unitIndex: 2,
        dotCount: 1,
        dotDesc: 'مِثْلُ الرَّاءِ وَفَوْقَهُ نُقْطَةٌ وَاحِدَةٌ',
        similar: ['ر', 'ذ', 'د'],
        fathaWord: 'زَرَافَةٌ',
        dammaWord: 'زُهُورٌ',
        kasraWord: 'زِرٌّ',
        words: [
          _w('زهرة', 'زَهْرَةٌ', ['ز', 'ه', 'ر', 'ة'], 'ز', 'start', haraka: 'fatha'),
          _w('زيت', 'زَيْتٌ', ['ز', 'ي', 'ت'], 'ز', 'start', haraka: 'fatha'),
          _w('جزر', 'جَزَرٌ', ['ج', 'ز', 'ر'], 'ز', 'middle'),
          _w('موز', 'مَوْزٌ', ['م', 'و', 'ز'], 'ز', 'end'),
          _w('خبز', 'خُبْزٌ', ['خ', 'ب', 'ز'], 'ز', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'س',
        nameAr: 'السِّينُ',
        coreKey: 'seen',
        unitIndex: 2,
        dotCount: 0,
        dotDesc: 'ثَلَاثُ سِنَّاتٍ بِلَا نُقَطٍ',
        similar: ['ش', 'ص', 'ض'],
        fathaWord: 'سَمَكَةٌ',
        dammaWord: 'سُلَحْفَاةٌ',
        kasraWord: 'سِتَارَةٌ',
        words: [
          _w('سمك', 'سَمَكٌ', ['س', 'م', 'ك'], 'س', 'start', haraka: 'fatha'),
          _w('سفن', 'سُفُنٌ', ['س', 'ف', 'ن'], 'س', 'start', haraka: 'damma'),
          _w('أسد', 'أَسَدٌ', ['أ', 'س', 'د'], 'س', 'middle'),
          _w('عسل', 'عَسَلٌ', ['ع', 'س', 'ل'], 'س', 'middle'),
          _w('شمس', 'شَمْسٌ', ['ش', 'م', 'س'], 'س', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'ش',
        nameAr: 'الشِّينُ',
        coreKey: 'sheen',
        unitIndex: 2,
        dotCount: 3,
        dotDesc: 'مِثْلُ السِّينِ وَفَوْقَهُ ثَلَاثُ نُقَطٍ',
        similar: ['س', 'ث', 'ص'],
        fathaWord: 'شَمْسٌ',
        dammaWord: 'شُبَّاكٌ',
        kasraWord: 'شِرَاعٌ',
        words: [
          _w('شمس', 'شَمْسٌ', ['ش', 'م', 'س'], 'ش', 'start', haraka: 'fatha'),
          _w('شجر', 'شَجَرٌ', ['ش', 'ج', 'ر'], 'ش', 'start', haraka: 'fatha'),
          _w('شمع', 'شَمْعٌ', ['ش', 'م', 'ع'], 'ش', 'start', haraka: 'fatha'),
          _w('عشب', 'عُشْبٌ', ['ع', 'ش', 'ب'], 'ش', 'middle'),
          _w('فراش', 'فِرَاشٌ', ['ف', 'ر', 'ا', 'ش'], 'ش', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'ص',
        nameAr: 'الصَّادُ',
        coreKey: 'saad',
        unitIndex: 2,
        dotCount: 0,
        dotDesc: 'حَلْقَةٌ مَغْلَقَةٌ وَصَحْنٌ عَمِيقٌ بِلَا نُقَطٍ',
        similar: ['ض', 'س', 'ط'],
        fathaWord: 'صَقْرٌ',
        dammaWord: 'صُنْدُوقٌ',
        kasraWord: 'صِنَّارَةٌ',
        words: [
          _w('صقر', 'صَقْرٌ', ['ص', 'ق', 'ر'], 'ص', 'start', haraka: 'fatha'),
          _w('صحن', 'صَحْنٌ', ['ص', 'ح', 'ن'], 'ص', 'start', haraka: 'fatha'),
          _w('بصل', 'بَصَلٌ', ['ب', 'ص', 'ل'], 'ص', 'middle'),
          _w('قصر', 'قَصْرٌ', ['ق', 'ص', 'ر'], 'ص', 'middle'),
          _w('مقص', 'مِقَصٌّ', ['م', 'ق', 'ص'], 'ص', 'end'),
        ],
      ),

      // ═══════════════════════ الوحدة 3 ═══════════════════════
      _makeLetter(
        letter: 'ض',
        nameAr: 'الضَّادُ',
        coreKey: 'daad',
        unitIndex: 3,
        dotCount: 1,
        dotDesc: 'مِثْلُ الصَّادِ وَفَوْقَهُ نُقْطَةٌ وَاحِدَةٌ',
        similar: ['ص', 'ظ', 'ط'],
        fathaWord: 'ضَابِطٌ',
        dammaWord: 'ضُيُوفٌ',
        kasraWord: 'ضِفْدَعٌ',
        words: [
          _w('ضرس', 'ضِرْسٌ', ['ض', 'ر', 'س'], 'ض', 'start', haraka: 'kasra'),
          _w('ضوء', 'ضَوْءٌ', ['ض', 'و', 'ء'], 'ض', 'start', haraka: 'fatha'),
          _w('ضفدع', 'ضِفْدَعٌ', ['ض', 'ف', 'د', 'ع'], 'ض', 'start', haraka: 'kasra'),
          _w('خضر', 'خُضَرٌ', ['خ', 'ض', 'ر'], 'ض', 'middle'),
          _w('أرض', 'أَرْضٌ', ['أ', 'ر', 'ض'], 'ض', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'ط',
        nameAr: 'الطَّاءُ',
        coreKey: 'taa_t',
        unitIndex: 3,
        dotCount: 0,
        dotDesc: 'بِأَلِفٍ عَمُودِيَّةٍ وَبِلَا نُقَطٍ',
        similar: ['ظ', 'ص', 'ض'],
        fathaWord: 'طَائِرَةٌ',
        dammaWord: 'طُيُورٌ',
        kasraWord: 'طِفْلٌ',
        words: [
          _w('طبل', 'طَبْلٌ', ['ط', 'ب', 'ل'], 'ط', 'start', haraka: 'fatha'),
          _w('طفل', 'طِفْلٌ', ['ط', 'ف', 'ل'], 'ط', 'start', haraka: 'kasra'),
          _w('طبق', 'طَبَقٌ', ['ط', 'ب', 'ق'], 'ط', 'start', haraka: 'fatha'),
          _w('مطر', 'مَطَرٌ', ['م', 'ط', 'ر'], 'ط', 'middle'),
          _w('بط', 'بَطٌّ', ['ب', 'ط'], 'ط', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'ظ',
        nameAr: 'الظَّاءُ',
        coreKey: 'dhaa_dh',
        unitIndex: 3,
        dotCount: 1,
        dotDesc: 'مِثْلُ الطَّاءِ وَفَوْقَهُ نُقْطَةٌ وَاحِدَةٌ',
        similar: ['ط', 'ض', 'ذ'],
        fathaWord: 'ظَرْفٌ',
        dammaWord: 'ظُفْرٌ',
        kasraWord: 'ظِلٌّ',
        words: [
          _w('ظرف', 'ظَرْفٌ', ['ظ', 'ر', 'ف'], 'ظ', 'start', haraka: 'fatha'),
          _w('ظبي', 'ظَبْيٌ', ['ظ', 'ب', 'ي'], 'ظ', 'start', haraka: 'fatha'),
          _w('ظفر', 'ظُفْرٌ', ['ظ', 'ف', 'ر'], 'ظ', 'start', haraka: 'damma'),
          _w('عظم', 'عَظْمٌ', ['ع', 'ظ', 'م'], 'ظ', 'middle'),
          _w('حفظ', 'حَفِظَ', ['ح', 'ف', 'ظ'], 'ظ', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'ع',
        nameAr: 'الْعَيْنُ',
        coreKey: 'ain',
        unitIndex: 3,
        dotCount: 0,
        dotDesc: 'نِصْفُ دَائِرَةٍ صَغِيرَةٍ وَتَحْتَهَا كَبِيرَةٌ بِلَا نُقَطٍ',
        similar: ['غ', 'ح', 'خ'],
        fathaWord: 'عَلَمٌ',
        dammaWord: 'عُصْفُورٌ',
        kasraWord: 'عِنَبٌ',
        words: [
          _w('عنب', 'عِنَبٌ', ['ع', 'ن', 'ب'], 'ع', 'start', haraka: 'kasra'),
          _w('علم', 'عَلَمٌ', ['ع', 'ل', 'م'], 'ع', 'start', haraka: 'fatha'),
          _w('عسل', 'عَسَلٌ', ['ع', 'س', 'ل'], 'ع', 'start', haraka: 'fatha'),
          _w('ثعلب', 'ثَعْلَبٌ', ['ث', 'ع', 'ل', 'ب'], 'ع', 'middle'),
          _w('شمع', 'شَمْعٌ', ['ش', 'م', 'ع'], 'ع', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'غ',
        nameAr: 'الْغَيْنُ',
        coreKey: 'ghain',
        unitIndex: 3,
        dotCount: 1,
        dotDesc: 'مِثْلُ الْعَيْنِ وَفَوْقَهُ نُقْطَةٌ وَاحِدَةٌ',
        similar: ['ع', 'ف', 'خ'],
        fathaWord: 'غَزَالٌ',
        dammaWord: 'غُرَابٌ',
        kasraWord: 'غِذَاءٌ',
        words: [
          _w('غزال', 'غَزَالٌ', ['غ', 'ز', 'ا', 'ل'], 'غ', 'start', haraka: 'fatha'),
          _w('غراب', 'غُرَابٌ', ['غ', 'ر', 'ا', 'ب'], 'غ', 'start', haraka: 'damma'),
          _w('غصن', 'غُصْنٌ', ['غ', 'ص', 'ن'], 'غ', 'start', haraka: 'damma'),
          _w('ببغاء', 'بَبْغَاءُ', ['ب', 'ب', 'غ', 'ا', 'ء'], 'غ', 'middle'),
          _w('صمغ', 'صَمْغٌ', ['ص', 'م', 'غ'], 'غ', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'ف',
        nameAr: 'الْفَاءُ',
        coreKey: 'faa',
        unitIndex: 3,
        dotCount: 1,
        dotDesc: 'رَأْسٌ مُسْتَدِيرٌ فَوْقَهُ نُقْطَةٌ وَاحِدَةٌ',
        similar: ['ق', 'غ', 'و'],
        fathaWord: 'فَرَاشَةٌ',
        dammaWord: 'فُؤَادٌ',
        kasraWord: 'فِيلٌ',
        words: [
          _w('فيل', 'فِيلٌ', ['ف', 'ي', 'ل'], 'ف', 'start', haraka: 'kasra'),
          _w('فول', 'فُولٌ', ['ف', 'و', 'ل'], 'ف', 'start', haraka: 'damma'),
          _w('فأس', 'فَأْسٌ', ['ف', 'أ', 'س'], 'ف', 'start', haraka: 'fatha'),
          _w('سفن', 'سُفُنٌ', ['س', 'ف', 'ن'], 'ف', 'middle'),
          _w('أنف', 'أَنْفٌ', ['أ', 'ن', 'ف'], 'ف', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'ق',
        nameAr: 'الْقَافُ',
        coreKey: 'qaaf',
        unitIndex: 3,
        dotCount: 2,
        dotDesc: 'مِثْلُ الْفَاءِ لَكِنَّ صَحْنَهُ عَمِيقٌ وَفَوْقَهُ نُقْطَتَانِ',
        similar: ['ف', 'ن', 'ت'],
        fathaWord: 'قَلَمٌ',
        dammaWord: 'قُبَّعَةٌ',
        kasraWord: 'قِرْدٌ',
        words: [
          _w('قمر', 'قَمَرٌ', ['ق', 'م', 'ر'], 'ق', 'start', haraka: 'fatha'),
          _w('قلم', 'قَلَمٌ', ['ق', 'ل', 'م'], 'ق', 'start', haraka: 'fatha'),
          _w('قرد', 'قِرْدٌ', ['ق', 'ر', 'د'], 'ق', 'start', haraka: 'kasra'),
          _w('صقر', 'صَقْرٌ', ['ص', 'ق', 'ر'], 'ق', 'middle'),
          _w('طبق', 'طَبَقٌ', ['ط', 'ب', 'ق'], 'ق', 'end'),
        ],
      ),

      // ═══════════════════════ الوحدة 4 ═══════════════════════
      _makeLetter(
        letter: 'ك',
        nameAr: 'الْكَافُ',
        coreKey: 'kaaf',
        unitIndex: 4,
        dotCount: 0,
        dotDesc: 'بِشَارَةِ كَافٍ صَغِيرَةٍ دَاخِلَهُ وَبِلَا نُقَطٍ',
        similar: ['ل', 'د', 'أ'],
        fathaWord: 'كَلْبٌ',
        dammaWord: 'كُرَةٌ',
        kasraWord: 'كِتَابٌ',
        words: [
          _w('كلب', 'كَلْبٌ', ['ك', 'ل', 'ب'], 'ك', 'start', haraka: 'fatha'),
          _w('كرة', 'كُرَةٌ', ['ك', 'ر', 'ة'], 'ك', 'start', haraka: 'damma'),
          _w('كرز', 'كَرَزٌ', ['ك', 'ر', 'ز'], 'ك', 'start', haraka: 'fatha'),
          _w('مكتب', 'مَكْتَبٌ', ['م', 'ك', 'ت', 'ب'], 'ك', 'middle'),
          _w('سمك', 'سَمَكٌ', ['س', 'م', 'ك'], 'ك', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'ل',
        nameAr: 'اللَّامُ',
        coreKey: 'laam',
        unitIndex: 4,
        dotCount: 0,
        dotDesc: 'طَوِيلٌ وَمُقَوَّسٌ مِنْ أَسْفَلُ بِلَا نُقَطٍ',
        similar: ['أ', 'ك', 'ن'],
        fathaWord: 'لَيْمُونٌ',
        dammaWord: 'لُعْبَةٌ',
        kasraWord: 'لِسَانٌ',
        words: [
          _w('لبن', 'لَبَنٌ', ['ل', 'ب', 'ن'], 'ل', 'start', haraka: 'fatha'),
          _w('لحم', 'لَحْمٌ', ['ل', 'ح', 'م'], 'ل', 'start', haraka: 'fatha'),
          _w('قلم', 'قَلَمٌ', ['ق', 'ل', 'م'], 'ل', 'middle'),
          _w('ملح', 'مِلْحٌ', ['م', 'ل', 'ح'], 'ل', 'middle'),
          _w('جمل', 'جَمَلٌ', ['ج', 'م', 'ل'], 'ل', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'م',
        nameAr: 'الْمِيمُ',
        coreKey: 'meem',
        unitIndex: 4,
        dotCount: 0,
        dotDesc: 'دَائِرَةٌ صَغِيرَةٌ وَذَيْلٌ نَازِلٌ بِلَا نُقَطٍ',
        similar: ['ه', 'و', 'ع'],
        fathaWord: 'مَوْزٌ',
        dammaWord: 'مُرَبَّعٌ',
        kasraWord: 'مِفْتَاحٌ',
        words: [
          _w('موز', 'مَوْزٌ', ['م', 'و', 'ز'], 'م', 'start', haraka: 'fatha'),
          _w('ملك', 'مَلِكٌ', ['م', 'ل', 'ك'], 'م', 'start', haraka: 'fatha'),
          _w('مقص', 'مِقَصٌّ', ['م', 'ق', 'ص'], 'م', 'start', haraka: 'kasra'),
          _w('قمر', 'قَمَرٌ', ['ق', 'م', 'ر'], 'م', 'middle'),
          _w('قلم', 'قَلَمٌ', ['ق', 'ل', 'م'], 'م', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'ن',
        nameAr: 'النُّونُ',
        coreKey: 'noon',
        unitIndex: 4,
        dotCount: 1,
        dotDesc: 'صَحْنٌ عَمِيقٌ وَفِي وَسَطِهِ نُقْطَةٌ وَاحِدَةٌ',
        similar: ['ب', 'ت', 'ق', 'ي'],
        fathaWord: 'نَمْلَةٌ',
        dammaWord: 'نُجُومٌ',
        kasraWord: 'نِمْرٌ',
        words: [
          _w('نمل', 'نَمْلٌ', ['ن', 'م', 'ل'], 'ن', 'start', haraka: 'fatha'),
          _w('نهر', 'نَهْرٌ', ['ن', 'ه', 'ر'], 'ن', 'start', haraka: 'fatha'),
          _w('نجم', 'نَجْمٌ', ['ن', 'ج', 'م'], 'ن', 'start', haraka: 'fatha'),
          _w('عنب', 'عِنَبٌ', ['ع', 'ن', 'ب'], 'ن', 'middle'),
          _w('لبن', 'لَبَنٌ', ['ل', 'ب', 'ن'], 'ن', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'ه',
        nameAr: 'الْهَاءُ',
        coreKey: 'haa',
        unitIndex: 4,
        dotCount: 0,
        dotDesc: 'بِلَا نُقَطٍ، وَفِي أَوَّلِ الْكَلِمَةِ يُكْتَبُ (هـ) بِحَلْقَةٍ دَاخِلِيَّةٍ',
        similar: ['م', 'و', 'ت'],
        fathaWord: 'هَرَمٌ',
        dammaWord: 'هُدْهُدٌ',
        kasraWord: 'هِلَالٌ',
        words: [
          _w('هرم', 'هَرَمٌ', ['ه', 'ر', 'م'], 'ه', 'start', haraka: 'fatha'),
          _w('هلال', 'هِلَالٌ', ['ه', 'ل', 'ا', 'ل'], 'ه', 'start', haraka: 'kasra'),
          _w('نهر', 'نَهْرٌ', ['ن', 'ه', 'ر'], 'ه', 'middle'),
          _w('ذهب', 'ذَهَبٌ', ['ذ', 'ه', 'ب'], 'ه', 'middle'),
          _w('وجه', 'وَجْهٌ', ['و', 'ج', 'ه'], 'ه', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'و',
        nameAr: 'الْوَاوُ',
        coreKey: 'waaw',
        unitIndex: 4,
        dotCount: 0,
        dotDesc: 'رَأْسٌ مُسْتَدِيرٌ وَذَيْلٌ مُنْحَنٍ بِلَا نُقَطٍ (حَرْفٌ رَافِسٌ)',
        similar: ['ر', 'ز', 'ف', 'ق'],
        fathaWord: 'وَرْدَةٌ',
        dammaWord: 'وُرُودٌ',
        kasraWord: 'وِسَادَةٌ',
        words: [
          _w('ولد', 'وَلَدٌ', ['و', 'ل', 'د'], 'و', 'start', haraka: 'fatha'),
          _w('ورد', 'وَرْدٌ', ['و', 'ر', 'د'], 'و', 'start', haraka: 'fatha'),
          _w('وجه', 'وَجْهٌ', ['و', 'ج', 'ه'], 'و', 'start', haraka: 'fatha'),
          _w('موز', 'مَوْزٌ', ['م', 'و', 'ز'], 'و', 'middle'),
          _w('دلو', 'دَلْوٌ', ['د', 'ل', 'و'], 'و', 'end'),
        ],
      ),
      _makeLetter(
        letter: 'ي',
        nameAr: 'الْيَاءُ',
        coreKey: 'yaa',
        unitIndex: 4,
        dotCount: 2,
        dotDesc: 'تَحْتَهُ نُقْطَتَانِ دَائِمًا',
        similar: ['ب', 'ت', 'ن'],
        fathaWord: 'يَدٌ',
        dammaWord: 'يُسْرٌ',
        kasraWord: 'يَمَامَةٌ',
        words: [
          _w('يد', 'يَدٌ', ['ي', 'د'], 'ي', 'start', haraka: 'fatha'),
          _w('يمام', 'يَمَامٌ', ['ي', 'م', 'ا', 'م'], 'ي', 'start', haraka: 'fatha'),
          _w('بيت', 'بَيْتٌ', ['ب', 'ي', 'ت'], 'ي', 'middle'),
          _w('فيل', 'فِيلٌ', ['ف', 'ي', 'ل'], 'ي', 'middle'),
          _w('ظبي', 'ظَبْيٌ', ['ظ', 'ب', 'ي'], 'ي', 'end'),
        ],
      ),
    ];

    return {for (final spec in list) spec.letter: spec};
  }
}
