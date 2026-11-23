import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:faseeh_kids/features/assessment/data/assessment_curriculum_data.dart';
import 'package:faseeh_kids/features/assessment/models/assessment_models.dart';
import 'package:faseeh_kids/features/lessons/data/letter_tracing_words_catalog.dart';

/// محرك توليد الأسئلة اللانهائي (Infinite Procedural Arabic Question Engine)
/// يولّد عدداً غير محدود من الأسئلة المتنوعة لجميع الحروف الـ ٢٨ عبر ١٣ نوع تمرين علمي
class ArabicQuestionEngine {
  final math.Random _rng;
  final List<String> _recentSignatures = [];
  int _counter = 0;

  ArabicQuestionEngine({int? seed}) : _rng = math.Random(seed);

  static final ArabicQuestionEngine shared = ArabicQuestionEngine();

  String _nextId(String prefix) => '${prefix}_${++_counter}_${_rng.nextInt(99999)}';

  void _remember(String signature) {
    _recentSignatures.add(signature);
    if (_recentSignatures.length > 48) {
      _recentSignatures.removeAt(0);
    }
  }

  T _pick<T>(List<T> items) => items[_rng.nextInt(items.length)];

  List<T> _shuffled<T>(Iterable<T> items) {
    final copy = List<T>.from(items);
    copy.shuffle(_rng);
    return copy;
  }

  /// توليد سؤال واحد من أي نوع لأي حرف من الحروف الـ ٢٨ مع تجنّب التكرار المباشر
  GeneratedQuestion generateQuestion({
    required String letter,
    required ExerciseType type,
    bool scaffolded = false,
  }) {
    final normalized = LetterTracingWordsCatalog.normalizeLetter(letter);
    GeneratedQuestion? candidate;
    for (int attempt = 0; attempt < 6; attempt++) {
      candidate = _buildQuestion(
        letter: normalized,
        type: type,
        scaffolded: scaffolded,
      );
      if (!_recentSignatures.contains(candidate.signature)) {
        break;
      }
    }
    _remember(candidate!.signature);
    return candidate;
  }

  /// توليد اختبار قياس مستوى علمي لوحدة كاملة (بعد كل ٧ حروف)
  /// يغطي جميع الحروف الـ ٧ في الوحدة + جميع المجالات المهارية الـ ٦
  /// ويضيف مراجعة حلزونية (Spiral Review) من الوحدات السابقة للوحدات ٢–٤
  List<GeneratedQuestion> generateUnitExam({
    required int unitIndex,
    int questionCount = 10,
  }) {
    final unit = AssessmentCurriculumData.unitByIndex(unitIndex);
    final unitLetters = _shuffled(unit.letters);

    // حروف المراجعة الحلزونية من الوحدات السابقة لتثبيت الذاكرة بعيدة المدى
    final priorLetters = <String>[];
    for (int u = 1; u < unitIndex; u++) {
      priorLetters.addAll(AssessmentCurriculumData.unitByIndex(u).letters);
    }

    // مخطط علمي متوازن يغطي جميع المجالات المهارية الستة
    final examBlueprint = <ExerciseType>[
      ExerciseType.findAndTapGrid, // 1. تعرف بصري
      ExerciseType.matchPictureToLetter, // 2. ربط الصورة بالصوت الأول
      ExerciseType.similarLettersSpot, // 3. تمييز الحروف المتشابهة
      ExerciseType.chooseLetterForm, // 4. الشكل المتصل والمنفصل
      ExerciseType.chooseHaraka, // 5. الحركات القصيرة
      ExerciseType.identifyLetterPosition, // 6. موضع الحرف في الكلمة
      ExerciseType.unscrambleWord, // 7. ترتيب حروف الكلمة
      ExerciseType.joinLettersToWord, // 8. تركيب كلمة من مقاطع
      ExerciseType.missingLetterInWord, // 9. الحرف الناقص / تسلسل الأبجدية
      ExerciseType.buildSentence, // 10. تكوين الجملة
      ExerciseType.circleMatchLetter, // 11. إضافي إذا زاد العدد
      ExerciseType.oddOneOut, // 12. إضافي إذا زاد العدد
    ];

    final questions = <GeneratedQuestion>[];
    for (int i = 0; i < questionCount; i++) {
      final type = examBlueprint[i % examBlueprint.length];
      String letter;
      // سؤالان للمراجعة الحلزونية في الوحدات 2..4 (الفهرسان 8 و 9 إذا كان العدد >= 10)
      if (priorLetters.isNotEmpty && questionCount >= 10 && i == 8) {
        letter = _pick(priorLetters);
      } else {
        letter = unitLetters[i % unitLetters.length];
      }
      questions.add(
        generateQuestion(letter: letter, type: type, scaffolded: false),
      );
    }
    return questions;
  }

  /// توليد جلسة علاجية مخصصة علمياً (ليست عشوائية!) للتلاميذ الضعفاء
  /// تتدرج من التثبيت البصري السهل -> التمرين الموجّه -> التحقق من الإتقان مع تلميحات مساعدة
  List<GeneratedQuestion> generateRemedialSession({
    required List<String> weakLetters,
    required List<SkillDomain> weakDomains,
    int questionCount = 8,
  }) {
    final lettersPool = weakLetters.isNotEmpty
        ? weakLetters
        : AssessmentCurriculumData.unitByIndex(1).letters;
    final domainsPool = weakDomains.isNotEmpty
        ? weakDomains
        : const [
            SkillDomain.visualRecognition,
            SkillDomain.similarLetters,
            SkillDomain.letterPositions,
            SkillDomain.phonicsHarakat,
          ];

    // خريطة التمارين العلاجية المتدرّجة لكل مجال مهاري
    List<ExerciseType> typesForDomain(SkillDomain domain) {
      switch (domain) {
        case SkillDomain.visualRecognition:
          return const [
            ExerciseType.findAndTapGrid,
            ExerciseType.circleMatchLetter,
            ExerciseType.tracingDrill,
          ];
        case SkillDomain.similarLetters:
          return const [
            ExerciseType.similarLettersSpot,
            ExerciseType.oddOneOut,
            ExerciseType.findAndTapGrid,
          ];
        case SkillDomain.letterPositions:
          return const [
            ExerciseType.chooseLetterForm,
            ExerciseType.identifyLetterPosition,
            ExerciseType.tracingDrill,
          ];
        case SkillDomain.phonicsHarakat:
          return const [
            ExerciseType.chooseHaraka,
            ExerciseType.matchPictureToLetter,
          ];
        case SkillDomain.wordBuilding:
          return const [
            ExerciseType.joinLettersToWord,
            ExerciseType.missingLetterInWord,
            ExerciseType.unscrambleWord,
          ];
        case SkillDomain.sentenceAndTracing:
          return const [
            ExerciseType.tracingDrill,
            ExerciseType.buildSentence,
          ];
      }
    }

    final questions = <GeneratedQuestion>[];
    for (int i = 0; i < questionCount; i++) {
      final letter = lettersPool[i % lettersPool.length];
      final domain = domainsPool[i % domainsPool.length];
      final domainTypes = typesForDomain(domain);
      // نتأكد أن تمرين التتبع لا يتكرر أكثر من مرة واحدة في الجلسة حتى تبقى ممتعة ومتنوعة
      var chosenType = domainTypes[(i ~/ domainsPool.length) % domainTypes.length];
      if (chosenType == ExerciseType.tracingDrill &&
          questions.any((q) => q.type == ExerciseType.tracingDrill)) {
        chosenType = domainTypes.firstWhere(
          (t) => t != ExerciseType.tracingDrill,
          orElse: () => ExerciseType.findAndTapGrid,
        );
      }

      questions.add(
        generateQuestion(
          letter: letter,
          type: chosenType,
          scaffolded: true, // تفعيل التلميحات المساعِدة العلمية للضعفاء
        ),
      );
    }
    return questions;
  }

  /// توليد لا نهائي حرّ لأي حرف/وحدة/مهارة/نوع تمرين
  List<GeneratedQuestion> generateInfinitePractice({
    int? unitIndex,
    List<String>? specificLetters,
    SkillDomain? domain,
    ExerciseType? exerciseType,
    int count = 8,
    bool scaffolded = false,
  }) {
    final List<String> pool;
    if (specificLetters != null && specificLetters.isNotEmpty) {
      pool = specificLetters;
    } else if (unitIndex != null) {
      pool = AssessmentCurriculumData.unitByIndex(unitIndex).letters;
    } else {
      pool = AssessmentCurriculumData.allLetterChars;
    }

    final List<ExerciseType> allowedTypes;
    if (exerciseType != null) {
      allowedTypes = [exerciseType];
    } else if (domain != null) {
      allowedTypes = ExerciseType.values.where((t) => t.domain == domain).toList();
    } else {
      // في التوليد الحر المختلط نستبعد التتبع إلا إذا اختاره المستخدم مباشرة أو نضعه بنسبة خفيفة
      allowedTypes = ExerciseType.values
          .where((t) => t != ExerciseType.tracingDrill)
          .toList();
    }

    final shuffledLetters = _shuffled(pool);
    final shuffledTypes = _shuffled(allowedTypes);
    return List.generate(count, (i) {
      final letter = shuffledLetters[i % shuffledLetters.length];
      final type = shuffledTypes[i % shuffledTypes.length];
      return generateQuestion(
        letter: letter,
        type: type,
        scaffolded: scaffolded,
      );
    });
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // المولّدات الإجرائية للـ ١٣ نوع تمرين
  // ═══════════════════════════════════════════════════════════════════════════

  GeneratedQuestion _buildQuestion({
    required String letter,
    required ExerciseType type,
    required bool scaffolded,
  }) {
    final spec = AssessmentCurriculumData.letterSpec(letter);
    final profile = LetterTracingWordsCatalog.getProfile(letter);
    final accent = profile.accentColor;

    switch (type) {
      case ExerciseType.findAndTapGrid:
        return _genFindAndTapGrid(spec, accent, scaffolded);
      case ExerciseType.circleMatchLetter:
        return _genCircleMatchLetter(spec, accent, scaffolded);
      case ExerciseType.similarLettersSpot:
        return _genSimilarLettersSpot(spec, accent, scaffolded);
      case ExerciseType.oddOneOut:
        return _genOddOneOut(spec, accent, scaffolded);
      case ExerciseType.chooseLetterForm:
        return _genChooseLetterForm(spec, accent, scaffolded);
      case ExerciseType.identifyLetterPosition:
        return _genIdentifyLetterPosition(spec, accent, scaffolded);
      case ExerciseType.chooseHaraka:
        return _genChooseHaraka(spec, accent, scaffolded);
      case ExerciseType.matchPictureToLetter:
        return _genMatchPictureToLetter(spec, accent, scaffolded);
      case ExerciseType.unscrambleWord:
        return _genUnscrambleWord(spec, accent, scaffolded);
      case ExerciseType.joinLettersToWord:
        return _genJoinLettersToWord(spec, accent, scaffolded);
      case ExerciseType.missingLetterInWord:
        return _genMissingLetterInWord(spec, accent, scaffolded);
      case ExerciseType.buildSentence:
        return _genBuildSentence(spec, accent, scaffolded);
      case ExerciseType.tracingDrill:
        return _genTracingDrill(spec, accent, scaffolded);
    }
  }

  List<String> _distractorLettersFor(
    LetterKnowledgeSpec spec,
    int count, {
    Set<String> exclude = const {},
  }) {
    final excluded = {
      AssessmentCurriculumData.normalizeChar(spec.letter),
      for (final e in exclude) AssessmentCurriculumData.normalizeChar(e),
    };
    final pool = <String>[];
    // نعطي أولوية علمية للحروف المتشابهة ثم حروف نفس الوحدة ثم باقي الحروف مع استبعاد أي حرف محظور
    for (final s in spec.similarLetters) {
      final normS = AssessmentCurriculumData.normalizeChar(s);
      if (!excluded.contains(normS) &&
          AssessmentCurriculumData.letters.containsKey(normS) &&
          !pool.contains(normS)) {
        pool.add(normS);
      }
    }
    final unitLetters = _shuffled(
      AssessmentCurriculumData.unitByIndex(spec.unitIndex)
          .letters
          .where((l) => !excluded.contains(AssessmentCurriculumData.normalizeChar(l)) && !pool.contains(l)),
    );
    pool.addAll(unitLetters);
    final others = _shuffled(
      AssessmentCurriculumData.allLetterChars
          .where((l) => !excluded.contains(AssessmentCurriculumData.normalizeChar(l)) && !pool.contains(l)),
    );
    pool.addAll(others);
    return pool.take(count).toList();
  }

  /// 1. شبكة البحث والتلوين (مثل اوراق ابحث عن الحرف ولونه)
  GeneratedQuestion _genFindAndTapGrid(
    LetterKnowledgeSpec spec,
    Color accent,
    bool scaffolded,
  ) {
    const totalCells = 12;
    final targetCount = 3 + _rng.nextInt(2); // 3 أو 4 نسخ مستهدفة
    final distractors = _distractorLettersFor(spec, 6);
    final usePositionalVariants = !scaffolded && _rng.nextBool();

    final targetForms = usePositionalVariants
        ? [spec.displayChar, spec.initialForm, spec.finalConnectedForm]
        : [spec.displayChar];

    final items = <QuestionChoice>[];
    for (int i = 0; i < targetCount; i++) {
      items.add(
        QuestionChoice(
          id: 't_$i',
          label: targetForms[i % targetForms.length],
          isCorrect: true,
        ),
      );
    }
    for (int i = 0; i < totalCells - targetCount; i++) {
      final dLetter = distractors[i % distractors.length];
      final dSpec = AssessmentCurriculumData.letterSpec(dLetter);
      items.add(
        QuestionChoice(
          id: 'd_$i',
          label: dSpec.displayChar,
          isCorrect: false,
        ),
      );
    }
    final shuffled = _shuffled(items);
    final sig = 'grid_${spec.letter}_${targetCount}_${usePositionalVariants}_${shuffled.first.label}';

    return GeneratedQuestion(
      id: _nextId('grid'),
      signature: sig,
      letter: spec.letter,
      unitIndex: spec.unitIndex,
      domain: SkillDomain.visualRecognition,
      type: ExerciseType.findAndTapGrid,
      instructionAr: 'ابْحَثْ عَنْ جَمِيعِ بَطَاقَاتِ حَرْفِ ${spec.nameAr} وَلَوِّنْهَا بِاللَّمْسِ',
      promptBadgeAr: 'ابْحَثْ عَنْ $targetCount حُرُوفٍ',
      displayPrompt: spec.displayChar,
      scaffoldHintAr: 'تَذَكَّرْ: حَرْفُ ${spec.nameAr} (${spec.displayChar}) — ${spec.dotDescriptionAr}',
      audioPath: spec.nameAudioPath,
      choices: shuffled,
      isScaffolded: scaffolded,
      accentColor: accent,
    );
  }

  /// 2. صل الحرف بالدائرة (مستلهم مباشرة من ا.jpg و ث.jpg في لعبة توصل حروف)
  GeneratedQuestion _genCircleMatchLetter(
    LetterKnowledgeSpec spec,
    Color accent,
    bool scaffolded,
  ) {
    final illus = AssessmentCurriculumData.primaryIllustrationFor(
      spec.letter,
      index: _rng.nextInt(4),
    );
    final distractors = _distractorLettersFor(spec, 5);
    final targetForms = [
      spec.displayChar,
      spec.initialForm,
      spec.finalConnectedForm,
    ];
    final items = <QuestionChoice>[
      for (int i = 0; i < 3; i++)
        QuestionChoice(
          id: 'cm_t_$i',
          label: targetForms[i % targetForms.length],
          isCorrect: true,
        ),
      for (int i = 0; i < 5; i++)
        QuestionChoice(
          id: 'cm_d_$i',
          label: AssessmentCurriculumData.letterSpec(distractors[i % distractors.length]).displayChar,
          isCorrect: false,
        ),
    ];
    final shuffled = _shuffled(items);
    return GeneratedQuestion(
      id: _nextId('circle'),
      signature: 'circle_${spec.letter}_${illus.word}_${shuffled.first.label}',
      letter: spec.letter,
      unitIndex: spec.unitIndex,
      domain: SkillDomain.visualRecognition,
      type: ExerciseType.circleMatchLetter,
      instructionAr: 'صِلْ كُلَّ أَشْكَالِ حَرْفِ ${spec.nameAr} بِالدَّائِرَةِ فِي الْمُنْتَصَفِ',
      promptBadgeAr: 'أَصِبْ ٣ أَشْكَالٍ صَحِيحَةٍ',
      displayPrompt: spec.displayChar,
      secondaryPrompt: illus.word,
      scaffoldHintAr: 'انْظُرْ إِلَى شَكْلِ الْحَرْفِ فِي الدَّائِرَةِ (${spec.displayChar}): ${spec.dotDescriptionAr}',
      audioPath: spec.nameAudioPath,
      imagePath: illus.imagePath,
      imageCropRect: illus.cropRect,
      choices: shuffled,
      isScaffolded: scaffolded,
      accentColor: accent,
    );
  }

  /// 3. تحدّي الحروف المتشابهة والنقاط (بلا أي التباس أو تداخل في المشتتات)
  GeneratedQuestion _genSimilarLettersSpot(
    LetterKnowledgeSpec spec,
    Color accent,
    bool scaffolded,
  ) {
    final useDotRiddle = _rng.nextBool();
    final starts = AssessmentCurriculumData.startingIllustrationsFor(spec.letter);
    final illus = starts.isNotEmpty
        ? _pick(starts)
        : AssessmentCurriculumData.primaryIllustrationFor(spec.letter);

    // نستبعد أي حرف موجود في الكلمة التوضيحية لمنع أي التباس
    final siblings = _distractorLettersFor(
      spec,
      3,
      exclude: useDotRiddle
          ? const {}
          : AssessmentCurriculumData.wordLetterSet(illus.word),
    );

    final choices = _shuffled([
      QuestionChoice(
        id: 'sim_${spec.letter}',
        label: spec.displayChar,
        sublabel: scaffolded ? spec.nameAr : null,
        isCorrect: true,
      ),
      for (final d in siblings)
        QuestionChoice(
          id: 'sim_$d',
          label: AssessmentCurriculumData.letterSpec(d).displayChar,
          sublabel: scaffolded ? AssessmentCurriculumData.letterSpec(d).nameAr : null,
          isCorrect: false,
        ),
    ]);

    return GeneratedQuestion(
      id: _nextId('sim'),
      signature: 'sim_${spec.letter}_${useDotRiddle}_${siblings.join()}',
      letter: spec.letter,
      unitIndex: spec.unitIndex,
      domain: SkillDomain.similarLetters,
      type: ExerciseType.similarLettersSpot,
      instructionAr: useDotRiddle
          ? 'أَيُّ حَرْفٍ مِنَ الْمُتَشَابِهَاتِ يَنْطَبِقُ عَلَيْهِ هَذَا الْوَصْفُ؟'
          : 'اسْتَمِعْ جَيِّدًا وَاخْتَرْ حَرْفَ ${spec.nameAr} مِنْ بَيْنِ الْحُرُوفِ الْمُتَشَابِهَةِ',
      promptBadgeAr: 'تَمْيِيزُ الْمُتَشَابِهَاتِ',
      displayPrompt: useDotRiddle ? spec.dotDescriptionAr : 'حَرْفُ ${spec.nameAr}',
      secondaryPrompt: useDotRiddle ? null : 'مِثْلُ: ${illus.word}',
      scaffoldHintAr: 'رَكِّزْ عَلَى النُّقَطِ: ${spec.dotDescriptionAr}',
      audioPath: spec.nameAudioPath,
      imagePath: useDotRiddle ? null : illus.imagePath,
      imageCropRect: useDotRiddle ? null : illus.cropRect,
      choices: choices,
      correctText: spec.displayChar,
      isScaffolded: scaffolded,
      accentColor: accent,
    );
  }

  /// 4. اكتشف المختلف (Odd One Out — مضمون ١٠٠٪ بلا تداخل بين الحرف المستهدف والغريب)
  GeneratedQuestion _genOddOneOut(
    LetterKnowledgeSpec spec,
    Color accent,
    bool scaffolded,
  ) {
    final oddCandidates = _distractorLettersFor(spec, 6);
    final sameStarts = _shuffled(
      AssessmentCurriculumData.startingIllustrationsFor(spec.letter),
    );

    String oddLetter = oddCandidates.first;
    TracingWordIllustration? chosenOddIllus;
    List<TracingWordIllustration> chosenSameWords = const [];

    // نبحث عن حرف مختلف له صورة تبدأ به ولا تحتوي حرفنا، وعن ٣ كلمات تبدأ بحرفنا ولا تحتوي الحرف المختلف
    if (sameStarts.length >= 3) {
      for (final cand in oddCandidates) {
        final oddStarts = _shuffled(
          AssessmentCurriculumData.startingIllustrationsFor(cand),
        ).where((w) => !AssessmentCurriculumData.wordContainsLetter(w.word, spec.letter)).toList();
        if (oddStarts.isEmpty) continue;

        final cleanSame = sameStarts
            .where((w) => !AssessmentCurriculumData.wordContainsLetter(w.word, cand))
            .take(3)
            .toList();
        if (cleanSame.length >= 3) {
          oddLetter = cand;
          chosenOddIllus = oddStarts.first;
          chosenSameWords = cleanSame;
          break;
        }
      }
    }

    final oddSpec = AssessmentCurriculumData.letterSpec(oddLetter);
    final useWordsMode =
        chosenSameWords.length >= 3 && chosenOddIllus != null && _rng.nextBool();
    final choices = useWordsMode
        ? _shuffled([
            for (int i = 0; i < 3; i++)
              QuestionChoice(
                id: 'same_$i',
                label: chosenSameWords[i].word,
                imagePath: chosenSameWords[i].imagePath,
                imageCropRect: chosenSameWords[i].cropRect,
                audioPath: chosenSameWords[i].audioPath,
                isCorrect: false,
              ),
            QuestionChoice(
              id: 'odd_${oddSpec.letter}',
              label: chosenOddIllus.word,
              imagePath: chosenOddIllus.imagePath,
              imageCropRect: chosenOddIllus.cropRect,
              audioPath: chosenOddIllus.audioPath,
              isCorrect: true,
            ),
          ])
        : _shuffled([
            QuestionChoice(id: 'same_0', label: spec.displayChar, isCorrect: false),
            QuestionChoice(id: 'same_1', label: spec.initialForm, isCorrect: false),
            QuestionChoice(id: 'same_2', label: spec.finalConnectedForm, isCorrect: false),
            QuestionChoice(id: 'odd_x', label: oddSpec.displayChar, isCorrect: true),
          ]);

    return GeneratedQuestion(
      id: _nextId('odd'),
      signature: 'odd_${spec.letter}_${oddLetter}_$useWordsMode',
      letter: spec.letter,
      unitIndex: spec.unitIndex,
      domain: SkillDomain.similarLetters,
      type: ExerciseType.oddOneOut,
      instructionAr: useWordsMode
          ? 'ثَلَاثُ كَلِمَاتٍ تَبْدَأُ بِحَرْفِ ${spec.nameAr} وَوَاحِدَةٌ تَبْدَأُ بِحَرْفٍ مُخْتَلِفٍ — اضْغَطْ عَلَى الْمُخْتَلِفَةِ!'
          : 'ثَلَاثُ بَطَاقَاتٍ لِحَرْفِ ${spec.nameAr} وَوَاحِدَةٌ مُخْتَلِفَةٌ — اكْتَشِفْهَا!',
      promptBadgeAr: 'اكْتَشِفِ الْغَرِيبَ',
      displayPrompt: spec.displayChar,
      scaffoldHintAr: 'حَرْفُ ${spec.nameAr} يَتَكَرَّرُ ٣ مَرَّاتٍ، أَمَّا الْمُخْتَلِفُ فَهُوَ حَرْفُ ${oddSpec.nameAr}.',
      audioPath: spec.nameAudioPath,
      choices: choices,
      isScaffolded: scaffolded,
      accentColor: accent,
    );
  }

  /// 5. الشكل المتصل والمنفصل في مواضع الكلمة (مثل توصيل بحرف متصل ومنفصل)
  GeneratedQuestion _genChooseLetterForm(
    LetterKnowledgeSpec spec,
    Color accent,
    bool scaffolded,
  ) {
    final word = _pick(spec.words);
    final idx = word.baseLetters.indexOf(spec.letter);
    final safeIdx = idx >= 0 ? idx : 0;
    final correctForm = word.positionalTiles[safeIdx];
    final prevKicking =
        safeIdx > 0 && AssessmentCurriculumData.kickingLetters.contains(word.baseLetters[safeIdx - 1]);

    String posLabel;
    if (safeIdx == 0) {
      posLabel = 'أَوَّلُ الْكَلِمَةِ';
    } else if (safeIdx == word.baseLetters.length - 1) {
      posLabel = prevKicking ? 'آخِرُ الْكَلِمَةِ (مُنْفَصِلٌ بَعْدَ حَرْفٍ رَافِسٍ)' : 'آخِرُ الْكَلِمَةِ (مُتَّصِلٌ)';
    } else {
      posLabel = prevKicking ? 'وَسَطُ الْكَلِمَةِ (بَعْدَ حَرْفٍ رَافِسٍ)' : 'وَسَطُ الْكَلِمَةِ (مُتَّصِلٌ)';
    }

    // نعرض المقاطع مع فراغ في موضع الحرف المستهدف
    final maskedTiles = List<String>.from(word.positionalTiles);
    maskedTiles[safeIdx] = ' ___ ';

    // خيارات الأشكال المختلفة لنفس الحرف + مموّه عند تشابه الأشكال في الحروف الرافسة
    final rawCandidates = <String>{
      correctForm,
      spec.isolatedForm,
      spec.initialForm,
      spec.medialConnectedForm,
      spec.finalConnectedForm,
    }.toList();

    // إذا كان الحرف رافساً (أشكال أقل من 4) نضيف أشكالاً خاطئة إملائياً بوضوح أو من حرف قريب
    if (rawCandidates.length < 4) {
      final bogus = <String>[
        '${spec.letter}ـ',
        'ـ${spec.letter}ـ',
        AssessmentCurriculumData.letterSpec(_distractorLettersFor(spec, 2).first).initialForm,
        AssessmentCurriculumData.letterSpec(_distractorLettersFor(spec, 2).last).finalConnectedForm,
      ];
      for (final b in bogus) {
        if (rawCandidates.length >= 4) break;
        if (!rawCandidates.contains(b)) rawCandidates.add(b);
      }
    }

    final finalOptions = <String>[
      correctForm,
      ..._shuffled(rawCandidates.where((c) => c != correctForm)).take(3),
    ];

    final choices = _shuffled(
      finalOptions.asMap().entries.map(
            (e) => QuestionChoice(
              id: 'form_${e.key}',
              label: e.value,
              isCorrect: e.value == correctForm,
            ),
          ),
    );

    final exactIllus = AssessmentCurriculumData.illustrationForExactWord(word.plainWord);

    return GeneratedQuestion(
      id: _nextId('form'),
      signature: 'form_${spec.letter}_${word.plainWord}_$safeIdx',
      letter: spec.letter,
      unitIndex: spec.unitIndex,
      domain: SkillDomain.letterPositions,
      type: ExerciseType.chooseLetterForm,
      instructionAr: 'اخْتَرِ الشَّكْلَ الصَّحِيحَ لِحَرْفِ ${spec.nameAr} فِي $posLabel',
      promptBadgeAr: posLabel,
      displayPrompt: maskedTiles.join('  '),
      secondaryPrompt: word.voweledWord,
      scaffoldHintAr: spec.isKicking
          ? 'تَذَكَّرْ: حَرْفُ ${spec.nameAr} حَرْفٌ رَافِسٌ لَا يَتَّصِلُ بِمَا بَعْدَهُ أَبَدًا!'
          : prevKicking
              ? 'الْحَرْفُ الَّذِي قَبْلَهُ رَافِسٌ؛ لِذَلِكَ لَا يَمُدُّ يَدَهُ إِلَيْهِ!'
              : 'انْظُرْ هَلْ يَمُدُّ يَدَهُ لِمَا قَبْلَهُ وَمَا بَعْدَهُ؟',
      audioPath: spec.nameAudioPath,
      imagePath: exactIllus?.imagePath,
      imageCropRect: exactIllus?.cropRect,
      choices: choices,
      correctText: correctForm,
      isScaffolded: scaffolded,
      accentColor: accent,
    );
  }

  /// 6. أين يقع الحرف في الكلمة؟ (أول / وسط / آخر — بكلمة تحتوي الحرف مرة واحدة فقط لمنع أي التباس!)
  GeneratedQuestion _genIdentifyLetterPosition(
    LetterKnowledgeSpec spec,
    Color accent,
    bool scaffolded,
  ) {
    final unambiguousWords = spec.words.where((w) {
      final count = w.baseLetters
          .where((c) => AssessmentCurriculumData.normalizeChar(c) == spec.letter)
          .length;
      return count == 1;
    }).toList();
    final word = _pick(unambiguousWords.isNotEmpty ? unambiguousWords : spec.words);
    final pos = word.positionInWord; // 'start' | 'middle' | 'end'
    final exactIllus = AssessmentCurriculumData.illustrationForExactWord(word.plainWord);

    final choices = [
      QuestionChoice(
        id: 'pos_start',
        label: 'أَوَّلُ الْكَلِمَةِ',
        sublabel: spec.initialForm,
        isCorrect: pos == 'start',
        accentColor: const Color(0xFF0284C7),
      ),
      QuestionChoice(
        id: 'pos_middle',
        label: 'وَسَطُ الْكَلِمَةِ',
        sublabel: spec.medialConnectedForm,
        isCorrect: pos == 'middle',
        accentColor: const Color(0xFF7C3AED),
      ),
      QuestionChoice(
        id: 'pos_end',
        label: 'آخِرُ الْكَلِمَةِ',
        sublabel: spec.finalConnectedForm,
        isCorrect: pos == 'end',
        accentColor: const Color(0xFF16A34A),
      ),
    ];

    return GeneratedQuestion(
      id: _nextId('pos'),
      signature: 'pos_${spec.letter}_${word.plainWord}',
      letter: spec.letter,
      unitIndex: spec.unitIndex,
      domain: SkillDomain.letterPositions,
      type: ExerciseType.identifyLetterPosition,
      instructionAr: 'أَيْنَ يَقَعُ حَرْفُ ${spec.nameAr} فِي هَذِهِ الْكَلِمَةِ؟',
      promptBadgeAr: 'حَدِّدِ الْمَوْضِعَ',
      displayPrompt: word.voweledWord,
      secondaryPrompt: spec.displayChar,
      scaffoldHintAr: 'ابْدَأْ بِالْحَرْفِ الْأَوَّلِ مِنَ الْيَمِينِ وَابْحَثْ عَنْ حَرْفِ ${spec.nameAr} (${spec.displayChar}).',
      audioPath: spec.nameAudioPath,
      imagePath: exactIllus?.imagePath,
      imageCropRect: exactIllus?.cropRect,
      choices: choices,
      correctText: pos,
      isScaffolded: scaffolded,
      accentColor: accent,
    );
  }

  /// 7. اختر الحركة المناسبة للصورة والكلمة (بصورة مطابقة تماماً لنفس الكلمة والحركة أو بطاقة صوتية نقية)
  GeneratedQuestion _genChooseHaraka(
    LetterKnowledgeSpec spec,
    Color accent,
    bool scaffolded,
  ) {
    final harakaKinds = ['fatha', 'damma', 'kasra'];
    final chosen = _pick(harakaKinds);

    final String fallbackWord;
    final String audioPath;
    switch (chosen) {
      case 'fatha':
        fallbackWord = spec.fathaWord;
        audioPath = spec.fathaAudioPath;
        break;
      case 'damma':
        fallbackWord = spec.dammaWord;
        audioPath = spec.dammaAudioPath;
        break;
      default:
        fallbackWord = spec.kasraWord;
        audioPath = spec.kasraAudioPath;
        break;
    }

    // نبحث عن صورة كرتونية تبدأ بنفس الحرف وبنفس الحركة تماماً (مثل تُفَّاحَة للضمة، حِصَان للكسرة، بَقَرَة للفتحة)
    final matchingIllus = AssessmentCurriculumData.illustrationForLetterAndHaraka(
      spec.letter,
      chosen,
    );
    final targetWord = matchingIllus?.word ?? fallbackWord;
    // نخفي حركة الحرف الأول قبل الإجابة حتى يعتمد الطفل على السمع والفهم ولا يغش من التشكيل!
    final maskedWord = AssessmentCurriculumData.stripFirstLetterHaraka(targetWord);
    final base = spec.letter == 'أ' ? 'أ' : spec.letter;

    final choices = [
      QuestionChoice(
        id: 'h_fatha',
        label: '$base\u064E',
        sublabel: 'فَتْحَةٌ',
        audioPath: spec.fathaAudioPath,
        isCorrect: chosen == 'fatha',
        accentColor: const Color(0xFFDC2626),
      ),
      QuestionChoice(
        id: 'h_damma',
        label: '$base\u064F',
        sublabel: 'ضَمَّةٌ',
        audioPath: spec.dammaAudioPath,
        isCorrect: chosen == 'damma',
        accentColor: const Color(0xFF2563EB),
      ),
      QuestionChoice(
        id: 'h_kasra',
        label: '${spec.letter == 'أ' ? 'إ' : base}\u0650',
        sublabel: 'كَسْرَةٌ',
        audioPath: spec.kasraAudioPath,
        isCorrect: chosen == 'kasra',
        accentColor: const Color(0xFF059669),
      ),
    ];

    final hint = chosen == 'fatha'
        ? 'نَفْتَحُ فَمَنَا عِنْدَ نُطْقِ الْفَتْحَةِ (فَوْقَ الْحَرْفِ).'
        : chosen == 'damma'
            ? 'نَضُمُّ شَفَتَيْنَا عِنْدَ نُطْقِ الضَّمَّةِ (فَوْقَ الْحَرْفِ).'
            : 'نَبْتَسِمُ لِأَسْفَلَ عِنْدَ نُطْقِ الْكَسْرَةِ (تَحْتَ الْحَرْفِ).';

    return GeneratedQuestion(
      id: _nextId('haraka'),
      signature: 'haraka_${spec.letter}_${chosen}_$targetWord',
      letter: spec.letter,
      unitIndex: spec.unitIndex,
      domain: SkillDomain.phonicsHarakat,
      type: ExerciseType.chooseHaraka,
      instructionAr: 'اسْتَمِعْ لِلصَّوْتِ وَاخْتَرِ الْحَرَكَةَ الْمُنَاسِبَةَ لِحَرْفِ ${spec.nameAr}',
      promptBadgeAr: 'الْحَرَكَاتُ الْقَصِيرَةُ',
      displayPrompt: maskedWord,
      secondaryPrompt: targetWord,
      scaffoldHintAr: hint,
      audioPath: audioPath,
      imagePath: matchingIllus?.imagePath,
      imageCropRect: matchingIllus?.cropRect,
      choices: choices,
      correctText: chosen,
      isScaffolded: scaffolded,
      accentColor: accent,
    );
  }

  /// 8. صل الصورة بحرفها الأول — مضمون ١٠٠٪ أن الكلمة تبدأ بالحرف، وصفر حروف مشتتة موجودة داخل الكلمة!
  GeneratedQuestion _genMatchPictureToLetter(
    LetterKnowledgeSpec spec,
    Color accent,
    bool scaffolded,
  ) {
    final starts = AssessmentCurriculumData.startingIllustrationsFor(spec.letter);
    final illus = starts.isNotEmpty
        ? _pick(starts)
        : AssessmentCurriculumData.primaryIllustrationFor(spec.letter);

    // قانون تربوي صارم: يُمنع منعاً باتاً وضع أي حرف موجود داخل الكلمة كخيار خاطئ!
    final forbiddenLetters = AssessmentCurriculumData.wordLetterSet(illus.word);
    final distractors = _distractorLettersFor(
      spec,
      3,
      exclude: forbiddenLetters,
    );

    final choices = _shuffled([
      QuestionChoice(
        id: 'mpl_${spec.letter}',
        label: spec.displayChar,
        sublabel: scaffolded ? spec.nameAr : null,
        isCorrect: true,
      ),
      for (final d in distractors)
        QuestionChoice(
          id: 'mpl_$d',
          label: AssessmentCurriculumData.letterSpec(d).displayChar,
          sublabel: scaffolded ? AssessmentCurriculumData.letterSpec(d).nameAr : null,
          isCorrect: false,
        ),
    ]);

    return GeneratedQuestion(
      id: _nextId('pic'),
      signature: 'pic_${spec.letter}_${illus.word}_${distractors.first}',
      letter: spec.letter,
      unitIndex: spec.unitIndex,
      domain: SkillDomain.phonicsHarakat,
      type: ExerciseType.matchPictureToLetter,
      instructionAr: 'انْظُرْ إِلَى الصُّورَةِ وَاسْتَمِعْ — بِأَيِّ حَرْفٍ تَبْدَأُ هَذِهِ الْكَلِمَةُ؟',
      promptBadgeAr: 'الْحَرْفُ الْأَوَّلُ لِلصُّورَةِ',
      displayPrompt: scaffolded ? illus.word : null,
      secondaryPrompt: illus.word,
      scaffoldHintAr: 'انْطِقْ أَوَّلَ صَوْتٍ فِي كَلِمَةِ «${illus.word}» — إِنَّهُ حَرْفُ ${spec.nameAr}!',
      audioPath: illus.audioPath,
      imagePath: illus.imagePath,
      imageCropRect: illus.cropRect,
      choices: choices,
      correctText: spec.displayChar,
      isScaffolded: scaffolded,
      accentColor: accent,
    );
  }

  /// 9. رتّب حروف الكلمة (مع صورة مطابقة للكلمة نفسها فقط)
  GeneratedQuestion _genUnscrambleWord(
    LetterKnowledgeSpec spec,
    Color accent,
    bool scaffolded,
  ) {
    final candidates = spec.words.where((w) => w.baseLetters.length >= 2 && w.baseLetters.length <= 4).toList();
    // نُفضّل الكلمات التي لها صورة كرتونية مطابقة تماماً على القرص
    final withExactImg = candidates
        .where((w) => AssessmentCurriculumData.illustrationForExactWord(w.plainWord) != null)
        .toList();
    final word = _pick(
      withExactImg.isNotEmpty
          ? withExactImg
          : (candidates.isNotEmpty ? candidates : spec.words),
    );
    final correctOrder = List<String>.from(word.baseLetters);
    var scrambled = _shuffled(correctOrder);
    if (correctOrder.length >= 2 && _listEquals(scrambled, correctOrder)) {
      scrambled = scrambled.reversed.toList();
    }
    final exactIllus = AssessmentCurriculumData.illustrationForExactWord(word.plainWord);

    return GeneratedQuestion(
      id: _nextId('unsc'),
      signature: 'unsc_${spec.letter}_${word.plainWord}_${scrambled.join()}',
      letter: spec.letter,
      unitIndex: spec.unitIndex,
      domain: SkillDomain.wordBuilding,
      type: ExerciseType.unscrambleWord,
      instructionAr: 'رَتِّبِ الْحُرُوفَ الْمُبَعْثَرَةَ لِتُكَوِّنَ الْكَلِمَةَ الصَّحِيحَةَ',
      promptBadgeAr: 'تَرْتِيبُ ${correctOrder.length} حُرُوفٍ',
      displayPrompt: word.voweledWord,
      scaffoldHintAr: 'الْحَرْفُ الْأَوَّلُ هُوَ (${correctOrder.first}) وَالْكَلِمَةُ هِيَ: ${word.voweledWord}',
      audioPath: exactIllus?.audioPath ?? spec.nameAudioPath,
      imagePath: exactIllus?.imagePath,
      imageCropRect: exactIllus?.cropRect,
      sequenceItems: scrambled,
      correctSequence: correctOrder,
      correctText: word.voweledWord,
      isScaffolded: scaffolded,
      accentColor: accent,
    );
  }

  /// 10. ركّب الكلمة من الحروف المقطّعة
  GeneratedQuestion _genJoinLettersToWord(
    LetterKnowledgeSpec spec,
    Color accent,
    bool scaffolded,
  ) {
    final word = _pick(spec.words);
    final unitLetters = AssessmentCurriculumData.unitByIndex(spec.unitIndex).letters;
    final distractorWords = <String>[];
    for (final l in _shuffled(unitLetters)) {
      if (l == spec.letter) continue;
      for (final w in AssessmentCurriculumData.letterSpec(l).words) {
        if (w.voweledWord != word.voweledWord && !distractorWords.contains(w.voweledWord)) {
          distractorWords.add(w.voweledWord);
          break;
        }
      }
      if (distractorWords.length >= 3) break;
    }

    final choices = _shuffled([
      QuestionChoice(id: 'join_ok', label: word.voweledWord, isCorrect: true),
      for (int i = 0; i < distractorWords.length; i++)
        QuestionChoice(id: 'join_d_$i', label: distractorWords[i], isCorrect: false),
    ]);
    final exactIllus = AssessmentCurriculumData.illustrationForExactWord(word.plainWord);

    return GeneratedQuestion(
      id: _nextId('join'),
      signature: 'join_${spec.letter}_${word.plainWord}',
      letter: spec.letter,
      unitIndex: spec.unitIndex,
      domain: SkillDomain.wordBuilding,
      type: ExerciseType.joinLettersToWord,
      instructionAr: 'ادْمُجِ الْحُرُوفَ الْمُقَطَّعَةَ وَاخْتَرِ الْكَلِمَةَ الصَّحِيحَةَ',
      promptBadgeAr: 'رَكِّبِ الْكَلِمَةَ',
      displayPrompt: word.positionalTiles.join('  +  '),
      scaffoldHintAr: 'اقْرَأِ الْحُرُوفَ مِنْ الْيَمِينِ لِلْيَسَارِ بِالتَّرْتِيبِ: ${word.positionalTiles.join(" ← ")}',
      audioPath: exactIllus?.audioPath ?? spec.nameAudioPath,
      imagePath: exactIllus?.imagePath,
      imageCropRect: exactIllus?.cropRect,
      sequenceItems: word.positionalTiles,
      choices: choices,
      correctText: word.voweledWord,
      isScaffolded: scaffolded,
      accentColor: accent,
    );
  }

  /// 11. أكمل الحرف الناقص (في كلمة حقيقية أو في تسلسل حروف الوحدة)
  GeneratedQuestion _genMissingLetterInWord(
    LetterKnowledgeSpec spec,
    Color accent,
    bool scaffolded,
  ) {
    final isAlphabetSeq = _rng.nextInt(3) == 0;
    if (isAlphabetSeq) {
      final unit = AssessmentCurriculumData.unitByIndex(spec.unitIndex);
      final missingIdx = unit.letters.indexOf(spec.letter).clamp(0, unit.letters.length - 1);
      final rail = <String>[
        for (int i = 0; i < unit.letters.length; i++)
          i == missingIdx ? '؟' : AssessmentCurriculumData.letterSpec(unit.letters[i]).displayChar,
      ];
      final distractors = _distractorLettersFor(spec, 3);
      final choices = _shuffled([
        QuestionChoice(id: 'seq_ok', label: spec.displayChar, isCorrect: true),
        for (final d in distractors)
          QuestionChoice(
            id: 'seq_$d',
            label: AssessmentCurriculumData.letterSpec(d).displayChar,
            isCorrect: false,
          ),
      ]);
      return GeneratedQuestion(
        id: _nextId('seq'),
        signature: 'seq_${spec.unitIndex}_${spec.letter}',
        letter: spec.letter,
        unitIndex: spec.unitIndex,
        domain: SkillDomain.wordBuilding,
        type: ExerciseType.missingLetterInWord,
        instructionAr: 'أَكْمِلِ الْحَرْفَ النَّاقِصَ فِي تَرْتِيبِ حُرُوفِ ${AssessmentCurriculumData.unitByIndex(spec.unitIndex).titleAr}',
        promptBadgeAr: 'تَسَلْسُلُ الْحُرُوفِ',
        sequenceItems: rail,
        scaffoldHintAr: 'اقْرَأْ حُرُوفَ الْوَحْدَةِ بِالتَّرْتِيبِ مِنَ الْيَمِينِ لِتَعْرِفَ الْحَرْفَ النَّاقِصَ!',
        audioPath: spec.nameAudioPath,
        choices: choices,
        correctText: spec.displayChar,
        isScaffolded: scaffolded,
        accentColor: accent,
      );
    }

    final withExact = spec.words
        .where((w) => AssessmentCurriculumData.illustrationForExactWord(w.plainWord) != null)
        .toList();
    final word = _pick(withExact.isNotEmpty ? withExact : spec.words);
    final idx = word.baseLetters.indexOf(spec.letter);
    final safeIdx = idx >= 0 ? idx : 0;
    final masked = List<String>.from(word.positionalTiles);
    masked[safeIdx] = ' ؟ ';

    final distractors = _distractorLettersFor(
      spec,
      3,
      exclude: AssessmentCurriculumData.wordLetterSet(word.plainWord),
    );
    final choices = _shuffled([
      QuestionChoice(id: 'miss_ok', label: spec.displayChar, isCorrect: true),
      for (final d in distractors)
        QuestionChoice(
          id: 'miss_$d',
          label: AssessmentCurriculumData.letterSpec(d).displayChar,
          isCorrect: false,
        ),
    ]);
    final exactIllus = AssessmentCurriculumData.illustrationForExactWord(word.plainWord);

    return GeneratedQuestion(
      id: _nextId('miss'),
      signature: 'miss_${spec.letter}_${word.plainWord}',
      letter: spec.letter,
      unitIndex: spec.unitIndex,
      domain: SkillDomain.wordBuilding,
      type: ExerciseType.missingLetterInWord,
      instructionAr: 'اخْتَرِ الْحَرْفَ النَّاقِصَ لِإِكْمَالِ الْكَلِمَةِ الصَّحِيحَةِ',
      promptBadgeAr: 'الْحَرْفُ النَّاقِصُ',
      displayPrompt: masked.join('  '),
      secondaryPrompt: word.voweledWord,
      sequenceItems: masked,
      scaffoldHintAr: 'الْكَلِمَةُ الْكَامِلَةُ هِيَ: «${word.voweledWord}» — وَيَنْقُصُهَا حَرْفُ ${spec.nameAr}.',
      audioPath: exactIllus?.audioPath ?? spec.nameAudioPath,
      imagePath: exactIllus?.imagePath,
      imageCropRect: exactIllus?.cropRect,
      choices: choices,
      correctText: spec.displayChar,
      isScaffolded: scaffolded,
      accentColor: accent,
    );
  }

  /// 12. كوّن الجملة الصحيحة (بصورة مطابقة لموضوع الجملة تماماً — مثل حِصَان لجملة الْحِصَانُ!)
  GeneratedQuestion _genBuildSentence(
    LetterKnowledgeSpec spec,
    Color accent,
    bool scaffolded,
  ) {
    final unit = AssessmentCurriculumData.unitByIndex(spec.unitIndex);
    final sentence = _pick(unit.sentences);
    final correctOrder = List<String>.from(sentence.words);
    var scrambled = _shuffled(correctOrder);
    if (correctOrder.length >= 2 && _listEquals(scrambled, correctOrder)) {
      scrambled = scrambled.reversed.toList();
    }
    // نطابق صورة موضوع الجملة (أول كلمة مثل الْحِصَانُ -> حِصَان، الْأَسَدُ -> أَسَد) بدقة!
    final exactIllus = AssessmentCurriculumData.illustrationForExactWord(
      sentence.words.first,
    );

    return GeneratedQuestion(
      id: _nextId('sent'),
      signature: 'sent_${spec.unitIndex}_${sentence.fullSentence}_${scrambled.first}',
      letter: spec.letter,
      unitIndex: spec.unitIndex,
      domain: SkillDomain.sentenceAndTracing,
      type: ExerciseType.buildSentence,
      instructionAr: 'رَتِّبِ الْكَلِمَاتِ لِتُكَوِّنَ جُمْلَةً عَرَبِيَّةً مُفِيدَةً',
      promptBadgeAr: 'تَكْوِينُ جُمْلَةٍ',
      displayPrompt: sentence.fullSentence,
      scaffoldHintAr: 'ابْدَأْ بِالْكَلِمَةِ الْأُولَى: «${correctOrder.first}»',
      audioPath: exactIllus?.audioPath ??
          AssessmentCurriculumData.letterSpec(sentence.hintLetter).nameAudioPath,
      imagePath: exactIllus?.imagePath,
      imageCropRect: exactIllus?.cropRect,
      sequenceItems: scrambled,
      correctSequence: correctOrder,
      correctText: sentence.fullSentence,
      isScaffolded: scaffolded,
      accentColor: accent,
    );
  }

  /// 13. تمرين التتبع الحركي بأسلوب Kiwii / Montessori المدمج في العيادة العلاجية
  GeneratedQuestion _genTracingDrill(
    LetterKnowledgeSpec spec,
    Color accent,
    bool scaffolded,
  ) {
    final positions = spec.letter == 'ه'
        ? const ['start', 'middle', 'end']
        : const ['isolated', 'start', 'middle', 'end'];
    final pos = _pick(positions);
    final illus = AssessmentCurriculumData.primaryIllustrationFor(spec.letter);

    String posAr;
    switch (pos) {
      case 'start':
        posAr = 'أَوَّلِ الْكَلِمَةِ';
        break;
      case 'middle':
        posAr = 'وَسَطِ الْكَلِمَةِ';
        break;
      case 'end':
        posAr = 'آخِرِ الْكَلِمَةِ';
        break;
      default:
        posAr = 'شَكْلِهِ الْمُنْفَصِلِ';
        break;
    }

    return GeneratedQuestion(
      id: _nextId('trace'),
      signature: 'trace_${spec.letter}_$pos',
      letter: spec.letter,
      unitIndex: spec.unitIndex,
      domain: SkillDomain.sentenceAndTracing,
      type: ExerciseType.tracingDrill,
      instructionAr: 'تَتَبَّعْ مَسَارَ حَرْفِ ${spec.nameAr} فِي $posAr مِنَ النُّقْطَةِ الذَّهَبِيَّةِ',
      promptBadgeAr: 'التَّتَبُّعُ الْحَرَكِيُّ',
      displayPrompt: spec.displayChar,
      secondaryPrompt: illus.word,
      scaffoldHintAr: 'ابْدَأْ مِنَ النُّقْطَةِ الصَّفْرَاءِ وَاتَّبِعِ الْأَسْهُمَ بِهُدُوءٍ.',
      audioPath: spec.nameAudioPath,
      imagePath: illus.imagePath,
      imageCropRect: illus.cropRect,
      tracingPosition: pos,
      isScaffolded: scaffolded,
      accentColor: accent,
    );
  }

  static bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
