import 'package:flutter/material.dart';

/// المجالات المهارية العلمية الستة في تأسيس القراءة والكتابة العربية
enum SkillDomain {
  visualRecognition,
  similarLetters,
  letterPositions,
  phonicsHarakat,
  wordBuilding,
  sentenceAndTracing,
}

extension SkillDomainMeta on SkillDomain {
  String get id => name;

  String get titleAr {
    switch (this) {
      case SkillDomain.visualRecognition:
        return 'التَّعَرُّفُ الْبَصَرِيُّ';
      case SkillDomain.similarLetters:
        return 'الْحُرُوفُ الْمُتَشَابِهَةُ';
      case SkillDomain.letterPositions:
        return 'مَوَاضِعُ الْحَرْفِ';
      case SkillDomain.phonicsHarakat:
        return 'الْحَرَكَاتُ وَالصَّوْتُ';
      case SkillDomain.wordBuilding:
        return 'تَرْكِيبُ الْكَلِمَاتِ';
      case SkillDomain.sentenceAndTracing:
        return 'الْجُمْلَةُ وَالْكِتَابَةُ';
    }
  }

  String get subtitleAr {
    switch (this) {
      case SkillDomain.visualRecognition:
        return 'اصطياد الحرف والبحث عنه بصرياً وتمييزه سريعاً';
      case SkillDomain.similarLetters:
        return 'التفريق الدقيق بين الإخوة المتشابهين وعدد النقاط وموضعها';
      case SkillDomain.letterPositions:
        return 'شكل الحرف أول الكلمة ووسطها وآخرها (متصل ومنفصل)';
      case SkillDomain.phonicsHarakat:
        return 'الفتحة والضمة والكسرة وربط الصورة بالصوت الأول';
      case SkillDomain.wordBuilding:
        return 'ترتيب الحروف المبعثرة ووصل المقاطع وإكمال الحرف الناقص';
      case SkillDomain.sentenceAndTracing:
        return 'تكوين جملة مفيدة والتتبع الحركي الدقيق لمسار الحرف';
    }
  }

  String get remedialAdviceAr {
    switch (this) {
      case SkillDomain.visualRecognition:
        return 'نُكثّف تمارين البحث البصري والتلوين والتتبع لترسيخ صورة الحرف في الذهن.';
      case SkillDomain.similarLetters:
        return 'نُدرّب الطفل على مقارنة الحروف المتشابهة جنباً إلى جنب مع عدّ النقاط وموضعها.';
      case SkillDomain.letterPositions:
        return 'نُركّز على أشكال الحرف المتصل والمنفصل بعد الحروف الرافسة مع أمثلة واضحة.';
      case SkillDomain.phonicsHarakat:
        return 'نُعزّز الوعي الصوتي بالاستماع للحركة القصيرة ومطابقتها مع الصورة والكلمة.';
      case SkillDomain.wordBuilding:
        return 'نتدرّج من كلمتين ثلاثيتين بسيطتين ثم ترتيب الحروف ودمجها بمساعدة الصورة.';
      case SkillDomain.sentenceAndTracing:
        return 'نبدأ بالتتبع المفرّغ بالاتجاه الصحيح ثم تركيب جمل قصيرة من كلمتين إلى ثلاث.';
    }
  }

  IconData get icon {
    switch (this) {
      case SkillDomain.visualRecognition:
        return Icons.visibility_rounded;
      case SkillDomain.similarLetters:
        return Icons.compare_arrows_rounded;
      case SkillDomain.letterPositions:
        return Icons.view_week_rounded;
      case SkillDomain.phonicsHarakat:
        return Icons.record_voice_over_rounded;
      case SkillDomain.wordBuilding:
        return Icons.extension_rounded;
      case SkillDomain.sentenceAndTracing:
        return Icons.edit_note_rounded;
    }
  }

  Color get color {
    switch (this) {
      case SkillDomain.visualRecognition:
        return const Color(0xFF0284C7);
      case SkillDomain.similarLetters:
        return const Color(0xFF7C3AED);
      case SkillDomain.letterPositions:
        return const Color(0xFF0D9488);
      case SkillDomain.phonicsHarakat:
        return const Color(0xFFEA580C);
      case SkillDomain.wordBuilding:
        return const Color(0xFF16A34A);
      case SkillDomain.sentenceAndTracing:
        return const Color(0xFFDB2777);
    }
  }

  static SkillDomain? fromId(String id) {
    for (final d in SkillDomain.values) {
      if (d.name == id) return d;
    }
    return null;
  }
}

/// أنواع التمارين الـ 13 المولّدة لا نهائياً في محرك الأسئلة
enum ExerciseType {
  findAndTapGrid,
  circleMatchLetter,
  similarLettersSpot,
  oddOneOut,
  chooseLetterForm,
  identifyLetterPosition,
  chooseHaraka,
  matchPictureToLetter,
  unscrambleWord,
  joinLettersToWord,
  missingLetterInWord,
  buildSentence,
  tracingDrill,
}

extension ExerciseTypeMeta on ExerciseType {
  String get titleAr {
    switch (this) {
      case ExerciseType.findAndTapGrid:
        return 'ابْحَثْ عَنِ الْحَرْفِ وَلَوِّنْهُ';
      case ExerciseType.circleMatchLetter:
        return 'صِلِ الْحَرْفَ بِالدَّائِرَةِ';
      case ExerciseType.similarLettersSpot:
        return 'تَحَدِّي الْحُرُوفِ الْمُتَشَابِهَةِ';
      case ExerciseType.oddOneOut:
        return 'اكْتَشِفِ الْمُخْتَلِفَ';
      case ExerciseType.chooseLetterForm:
        return 'الشَّكْلُ الْمُتَّصِلُ وَالْمُنْفَصِلُ';
      case ExerciseType.identifyLetterPosition:
        return 'أَيْنَ الْحَرْفُ فِي الْكَلِمَةِ؟';
      case ExerciseType.chooseHaraka:
        return 'اخْتَرِ الْحَرَكَةَ الْمُنَاسِبَةَ';
      case ExerciseType.matchPictureToLetter:
        return 'صِلِ الصُّورَةَ بِحَرْفِهَا';
      case ExerciseType.unscrambleWord:
        return 'رَتِّبْ حُرُوفَ الْكَلِمَةِ';
      case ExerciseType.joinLettersToWord:
        return 'رَكِّبِ الْكَلِمَةَ مِنَ الْحُرُوفِ';
      case ExerciseType.missingLetterInWord:
        return 'أَكْمِلِ الْحَرْفَ النَّاقِصَ';
      case ExerciseType.buildSentence:
        return 'كَوِّنِ الْجُمْلَةَ الصَّحِيحَةَ';
      case ExerciseType.tracingDrill:
        return 'تَتَبَّعْ مَسَارَ الْحَرْفِ';
    }
  }

  SkillDomain get domain {
    switch (this) {
      case ExerciseType.findAndTapGrid:
      case ExerciseType.circleMatchLetter:
        return SkillDomain.visualRecognition;
      case ExerciseType.similarLettersSpot:
      case ExerciseType.oddOneOut:
        return SkillDomain.similarLetters;
      case ExerciseType.chooseLetterForm:
      case ExerciseType.identifyLetterPosition:
        return SkillDomain.letterPositions;
      case ExerciseType.chooseHaraka:
      case ExerciseType.matchPictureToLetter:
        return SkillDomain.phonicsHarakat;
      case ExerciseType.unscrambleWord:
      case ExerciseType.joinLettersToWord:
      case ExerciseType.missingLetterInWord:
        return SkillDomain.wordBuilding;
      case ExerciseType.buildSentence:
      case ExerciseType.tracingDrill:
        return SkillDomain.sentenceAndTracing;
    }
  }

  IconData get icon {
    switch (this) {
      case ExerciseType.findAndTapGrid:
        return Icons.grid_view_rounded;
      case ExerciseType.circleMatchLetter:
        return Icons.track_changes_rounded;
      case ExerciseType.similarLettersSpot:
        return Icons.difference_rounded;
      case ExerciseType.oddOneOut:
        return Icons.filter_center_focus_rounded;
      case ExerciseType.chooseLetterForm:
        return Icons.link_rounded;
      case ExerciseType.identifyLetterPosition:
        return Icons.linear_scale_rounded;
      case ExerciseType.chooseHaraka:
        return Icons.music_note_rounded;
      case ExerciseType.matchPictureToLetter:
        return Icons.image_search_rounded;
      case ExerciseType.unscrambleWord:
        return Icons.shuffle_rounded;
      case ExerciseType.joinLettersToWord:
        return Icons.join_inner_rounded;
      case ExerciseType.missingLetterInWord:
        return Icons.space_bar_rounded;
      case ExerciseType.buildSentence:
        return Icons.short_text_rounded;
      case ExerciseType.tracingDrill:
        return Icons.gesture_rounded;
    }
  }
}

/// مقياس التصنيف العلمي الخماسي بعد اختبار كل ٧ حروف
enum MasteryLevel {
  mastered, // 90 - 100%
  proficient, // 75 - 89%
  developing, // 60 - 74%
  needsSupport, // 40 - 59%
  intensiveSupport, // < 40%
}

extension MasteryLevelMeta on MasteryLevel {
  static MasteryLevel fromPercent(double percent) {
    if (percent >= 90) return MasteryLevel.mastered;
    if (percent >= 75) return MasteryLevel.proficient;
    if (percent >= 60) return MasteryLevel.developing;
    if (percent >= 40) return MasteryLevel.needsSupport;
    return MasteryLevel.intensiveSupport;
  }

  String get badgeEmoji {
    switch (this) {
      case MasteryLevel.mastered:
        return '🏆';
      case MasteryLevel.proficient:
        return '🌟';
      case MasteryLevel.developing:
        return '🌱';
      case MasteryLevel.needsSupport:
        return '🧩';
      case MasteryLevel.intensiveSupport:
        return '💪';
    }
  }

  String get titleAr {
    switch (this) {
      case MasteryLevel.mastered:
        return 'مُتَفَوِّقٌ وَمُتْقِنٌ';
      case MasteryLevel.proficient:
        return 'جَيِّدٌ جِدًّا';
      case MasteryLevel.developing:
        return 'مُتَوَسِّطٌ — يَحْتَاجُ تَثْبِيتًا';
      case MasteryLevel.needsSupport:
        return 'يَحْتَاجُ تَقْوِيَةً مُخَصَّصَةً';
      case MasteryLevel.intensiveSupport:
        return 'خُطَّةُ دَعْمٍ تَأْسِيسِيٍّ مُكَثَّفٍ';
    }
  }

  String get recommendationAr {
    switch (this) {
      case MasteryLevel.mastered:
        return 'أداء رائع! يتقن الطفل حروف هذه الوحدة بالكامل ومستعد للانتقال للوحدة التالية.';
      case MasteryLevel.proficient:
        return 'مستوى ممتاز! يمكن الانتقال للوحدة التالية مع مراجعة سريعة للأخطاء البسيطة.';
      case MasteryLevel.developing:
        return 'بداية جيدة مع بعض الثغرات المحددة — يُنصح بجلسة تثبيت مركّزة قبل الانتقال.';
      case MasteryLevel.needsSupport:
        return 'تم تحديد نقاط الضعف بدقة! اضغط بالأسفل لبدء خطة التقوية العلاجية المخصصة الآن.';
      case MasteryLevel.intensiveSupport:
        return 'لا تقلق يا بطل! جهّزنا لك خطة تأسيسية تدريجية سهلة وممتعة خطوة بخطوة.';
    }
  }

  Color get color {
    switch (this) {
      case MasteryLevel.mastered:
        return const Color(0xFF15803D);
      case MasteryLevel.proficient:
        return const Color(0xFF0284C7);
      case MasteryLevel.developing:
        return const Color(0xFFD97706);
      case MasteryLevel.needsSupport:
        return const Color(0xFFEA580C);
      case MasteryLevel.intensiveSupport:
        return const Color(0xFFDC2626);
    }
  }

  bool get needsRemedial =>
      this == MasteryLevel.developing ||
      this == MasteryLevel.needsSupport ||
      this == MasteryLevel.intensiveSupport;
}

/// خيار واحد داخل سؤال متعدد الاختيارات أو شبكة بطاقات
class QuestionChoice {
  final String id;
  final String label;
  final String? sublabel;
  final String? imagePath;
  final Rect? imageCropRect;
  final String? audioPath;
  final bool isCorrect;
  final Color? accentColor;

  const QuestionChoice({
    required this.id,
    required this.label,
    this.sublabel,
    this.imagePath,
    this.imageCropRect,
    this.audioPath,
    required this.isCorrect,
    this.accentColor,
  });
}

/// سؤال واحد مولّد إجرائياً من محرك الأسئلة اللانهائي
class GeneratedQuestion {
  final String id;
  final String signature;
  final String letter;
  final int unitIndex;
  final SkillDomain domain;
  final ExerciseType type;
  final String instructionAr;
  final String? promptBadgeAr;
  final String? displayPrompt;
  final String? secondaryPrompt;
  final String? scaffoldHintAr;
  final String? audioPath;
  final String? imagePath;
  final Rect? imageCropRect;
  final List<QuestionChoice> choices;
  final List<String> sequenceItems; // لترتيب حروف الكلمة أو كلمات الجملة أو الحروف المقطّعة
  final List<String> correctSequence; // الترتيب الصحيح لـ unscramble / buildSentence
  final String? correctText;
  final String? tracingPosition;
  final bool isScaffolded;
  final Color accentColor;

  const GeneratedQuestion({
    required this.id,
    required this.signature,
    required this.letter,
    required this.unitIndex,
    required this.domain,
    required this.type,
    required this.instructionAr,
    this.promptBadgeAr,
    this.displayPrompt,
    this.secondaryPrompt,
    this.scaffoldHintAr,
    this.audioPath,
    this.imagePath,
    this.imageCropRect,
    this.choices = const [],
    this.sequenceItems = const [],
    this.correctSequence = const [],
    this.correctText,
    this.tracingPosition,
    this.isScaffolded = false,
    this.accentColor = const Color(0xFF0284C7),
  });
}

/// سجل إجابة واحدة لتشخيص نقاط القوة والضعف علمياً
class QuestionAttemptRecord {
  final String letter;
  final SkillDomain domain;
  final ExerciseType exerciseType;
  final bool isCorrectFirstTry;
  final int attempts;

  const QuestionAttemptRecord({
    required this.letter,
    required this.domain,
    required this.exerciseType,
    required this.isCorrectFirstTry,
    required this.attempts,
  });
}

/// نتيجة اختبار وحدة كاملة (كل ٧ حروف)
class UnitAssessmentResult {
  final int unitIndex;
  final int correctCount;
  final int totalQuestions;
  final DateTime completedAt;
  final Map<String, double> skillAccuracy; // domain.name -> 0.0..1.0
  final List<String> weakLetters;
  final List<String> weakDomains;

  const UnitAssessmentResult({
    required this.unitIndex,
    required this.correctCount,
    required this.totalQuestions,
    required this.completedAt,
    required this.skillAccuracy,
    required this.weakLetters,
    required this.weakDomains,
  });

  double get percent =>
      totalQuestions == 0 ? 0.0 : (correctCount / totalQuestions) * 100.0;

  MasteryLevel get masteryLevel => MasteryLevelMeta.fromPercent(percent);

  Map<String, dynamic> toJson() => {
        'unitIndex': unitIndex,
        'correctCount': correctCount,
        'totalQuestions': totalQuestions,
        'completedAt': completedAt.toIso8601String(),
        'skillAccuracy': skillAccuracy,
        'weakLetters': weakLetters,
        'weakDomains': weakDomains,
      };

  factory UnitAssessmentResult.fromJson(Map<String, dynamic> json) {
    final rawSkills = (json['skillAccuracy'] as Map?) ?? const {};
    return UnitAssessmentResult(
      unitIndex: (json['unitIndex'] as num?)?.toInt() ?? 1,
      correctCount: (json['correctCount'] as num?)?.toInt() ?? 0,
      totalQuestions: (json['totalQuestions'] as num?)?.toInt() ?? 10,
      completedAt: DateTime.tryParse(json['completedAt']?.toString() ?? '') ??
          DateTime.now(),
      skillAccuracy: {
        for (final entry in rawSkills.entries)
          entry.key.toString(): (entry.value as num).toDouble(),
      },
      weakLetters: ((json['weakLetters'] as List?) ?? const [])
          .map((e) => e.toString())
          .toList(),
      weakDomains: ((json['weakDomains'] as List?) ?? const [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}

/// إحصائية تراكمية لمهارة أو حرف واحد
class AccuracyStat {
  final int attempts;
  final int correct;

  const AccuracyStat({this.attempts = 0, this.correct = 0});

  double get accuracy => attempts == 0 ? 1.0 : correct / attempts;
  bool get hasData => attempts > 0;
  bool get isWeak => attempts > 0 && accuracy < 0.72;

  AccuracyStat record({required bool isCorrect}) => AccuracyStat(
        attempts: attempts + 1,
        correct: correct + (isCorrect ? 1 : 0),
      );

  Map<String, dynamic> toJson() => {'attempts': attempts, 'correct': correct};

  factory AccuracyStat.fromJson(Map<String, dynamic> json) => AccuracyStat(
        attempts: (json['attempts'] as num?)?.toInt() ?? 0,
        correct: (json['correct'] as num?)?.toInt() ?? 0,
      );
}

/// الوصفة العلاجية العلمية المولّدة آلياً للتلاميذ الضعفاء
class RemedialPrescription {
  final List<String> weakLetters;
  final List<SkillDomain> weakDomains;
  final String headlineAr;
  final String summaryAr;
  final bool hasDiagnosedWeaknesses;

  const RemedialPrescription({
    required this.weakLetters,
    required this.weakDomains,
    required this.headlineAr,
    required this.summaryAr,
    required this.hasDiagnosedWeaknesses,
  });
}

/// نمط جلسة التمرين/التقييم
enum AssessmentSessionMode {
  unitExam, // اختبار قياس مستوى بعد كل ٧ حروف
  remedialClinic, // جلسة علاجية مخصصة لنقاط الضعف مع تلميحات مساعدة
  infinitePractice, // تدريب لا نهائي حر لأي حرف ونوع تمرين
}

/// معاملات التنقل الصارمة لـ GoRouter
class AssessmentSessionArgs {
  final AssessmentSessionMode mode;
  final int? unitIndex;
  final List<String> targetLetters;
  final List<SkillDomain> targetDomains;
  final ExerciseType? specificExerciseType;
  final int questionCount;
  final String titleAr;

  const AssessmentSessionArgs({
    required this.mode,
    this.unitIndex,
    this.targetLetters = const [],
    this.targetDomains = const [],
    this.specificExerciseType,
    this.questionCount = 10,
    this.titleAr = 'اخْتِبَارُ قِيَاسِ الْمُسْتَوَى',
  });
}
