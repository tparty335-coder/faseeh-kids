import 'dart:math' as math;
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/router/app_router.dart';
import 'package:faseeh_kids/core/utils/responsive.dart';
import 'package:faseeh_kids/features/assessment/data/assessment_curriculum_data.dart';
import 'package:faseeh_kids/features/assessment/engine/arabic_question_engine.dart';
import 'package:faseeh_kids/features/assessment/logic/assessment_provider.dart';
import 'package:faseeh_kids/features/assessment/models/assessment_models.dart';
import 'package:faseeh_kids/features/assessment/widgets/playful_design_kit.dart';
import 'package:faseeh_kids/features/assessment/widgets/question_renderer_widgets.dart';
import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// شاشة تنفيذ جلسة الاختبار أو العيادة العلاجية أو التمارين اللانهائية
/// بتصميم قصصي حيوي عالمي المستوى (Duolingo ABC / Montessori) متجاوب من 320×533 حتى 960×1600
class AssessmentSessionScreen extends ConsumerStatefulWidget {
  final AssessmentSessionArgs args;

  const AssessmentSessionScreen({super.key, required this.args});

  @override
  ConsumerState<AssessmentSessionScreen> createState() =>
      _AssessmentSessionScreenState();
}

class _AssessmentSessionScreenState
    extends ConsumerState<AssessmentSessionScreen> {
  late List<GeneratedQuestion> _questions;
  late final ConfettiController _confettiController;
  int _currentIndex = 0;
  int _currentAttempts = 0;
  bool _currentHadWrong = false;
  bool _currentSolved = false;
  bool _showScaffoldHint = false;
  int _audioToken = 0;
  int _roundNumber = 1;
  int _starsEarned = 0;

  final List<QuestionAttemptRecord> _records = [];
  UnitAssessmentResult? _completedResult;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 900));
    _generateRound();
  }

  void _generateRound() {
    final engine = ArabicQuestionEngine.shared;
    final a = widget.args;

    switch (a.mode) {
      case AssessmentSessionMode.unitExam:
        _questions = engine.generateUnitExam(
          unitIndex: a.unitIndex ?? 1,
          questionCount: a.questionCount,
        );
        break;
      case AssessmentSessionMode.remedialClinic:
        _questions = engine.generateRemedialSession(
          weakLetters: a.targetLetters,
          weakDomains: a.targetDomains,
          questionCount: a.questionCount,
        );
        break;
      case AssessmentSessionMode.infinitePractice:
        _questions = engine.generateInfinitePractice(
          unitIndex: a.unitIndex,
          specificLetters: a.targetLetters.isEmpty ? null : a.targetLetters,
          domain: a.targetDomains.isEmpty ? null : a.targetDomains.first,
          exerciseType: a.specificExerciseType,
          count: a.questionCount,
          scaffolded: false,
        );
        break;
    }

    _currentIndex = 0;
    _currentAttempts = 0;
    _currentHadWrong = false;
    _currentSolved = false;
    _showScaffoldHint = a.mode == AssessmentSessionMode.remedialClinic;
    _starsEarned = 0;
    _records.clear();
    _completedResult = null;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _questions.isNotEmpty) {
        _playAudio(_questions.first.audioPath);
      }
    });
  }

  @override
  void dispose() {
    _audioToken++;
    _confettiController.dispose();
    AudioService.instance.stop();
    super.dispose();
  }

  Future<void> _playAudio(String? path) async {
    if (path == null || path.isEmpty) return;
    final tk = ++_audioToken;
    try {
      await AudioService.instance.stop();
      if (!mounted || tk != _audioToken) return;
      await AudioService.instance.playAsset(path, channel: AudioChannel.voice);
    } catch (_) {}
  }

  void _onAttempt({required bool isCorrect}) {
    _currentAttempts++;
    if (isCorrect) {
      AudioManager.instance.playFeedback('excellent');
    } else {
      _currentHadWrong = true;
      AudioManager.instance.playFeedback('try_again');
      // في الجلسات العلاجية أو بعد أول خطأ، نُظهر التلميح التربوي تلقائياً لمساعدة الطفل
      if (mounted && !_showScaffoldHint) {
        setState(() => _showScaffoldHint = true);
      }
    }
  }

  void _onQuestionSolved() {
    if (_currentSolved) return;
    final q = _questions[_currentIndex];
    final firstTry = !_currentHadWrong;
    _records.add(
      QuestionAttemptRecord(
        letter: q.letter,
        domain: q.domain,
        exerciseType: q.type,
        isCorrectFirstTry: firstTry,
        attempts: _currentAttempts == 0 ? 1 : _currentAttempts,
      ),
    );
    _confettiController.play();
    setState(() {
      _currentSolved = true;
      _starsEarned += firstTry ? 2 : 1;
    });
  }

  void _goToNextQuestion() {
    HapticFeedback.lightImpact();
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _currentAttempts = 0;
        _currentHadWrong = false;
        _currentSolved = false;
        _showScaffoldHint =
            widget.args.mode == AssessmentSessionMode.remedialClinic;
      });
      _playAudio(_questions[_currentIndex].audioPath);
    } else {
      // إنهاء الجلسة وتسجيل التشخيص العلمي في Hive
      final result =
          ref.read(assessmentDiagnosticsProvider.notifier).recordSession(
                mode: widget.args.mode,
                records: _records,
                unitIndex: widget.args.unitIndex,
              );
      AudioManager.instance.playFeedback('champion');
      _confettiController.play();
      setState(() => _completedResult = result);
    }
  }

  void _startAnotherInfiniteRound() {
    HapticFeedback.mediumImpact();
    setState(() {
      _roundNumber++;
      _generateRound();
    });
  }

  void _launchAutoRemedial(UnitAssessmentResult res) {
    final weakDomains = res.weakDomains
        .map(SkillDomainMeta.fromId)
        .whereType<SkillDomain>()
        .toList();
    final weakLetters = res.weakLetters.isNotEmpty
        ? res.weakLetters
        : AssessmentCurriculumData.unitByIndex(res.unitIndex).letters;

    context.pushReplacement(
      AppRouter.assessmentSession,
      extra: AssessmentSessionArgs(
        mode: AssessmentSessionMode.remedialClinic,
        unitIndex: res.unitIndex,
        targetLetters: weakLetters,
        targetDomains: weakDomains,
        questionCount: 8,
        titleAr: 'خُطَّةُ التَّقْوِيَةِ الْعِلَاجِيَّةِ',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRemedial = widget.args.mode == AssessmentSessionMode.remedialClinic;
    final isInfinite =
        widget.args.mode == AssessmentSessionMode.infinitePractice;
    final tint = _completedResult != null
        ? _completedResult!.masteryLevel.color
        : _questions[_currentIndex].accentColor;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: PlayfulPalette.skyMid,
        body: StorybookOasisBackground(
          tintAccent: tint,
          child: Stack(
            children: [
              SafeArea(
                child: _completedResult != null
                    ? _buildResultReport(context, _completedResult!)
                    : _buildActiveQuestionView(context, isRemedial, isInfinite),
              ),
              // قصاصات الاحتفال العلوية عند الإجابة الصحيحة أو إنهاء الجولة
              Align(
                alignment: Alignment.topCenter,
                child: IgnorePointer(
                  child: ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirection: math.pi / 2,
                    blastDirectionality: BlastDirectionality.explosive,
                    emissionFrequency: 0.08,
                    numberOfParticles: 22,
                    maxBlastForce: 22,
                    minBlastForce: 8,
                    gravity: 0.25,
                    colors: const [
                      PlayfulPalette.sunny,
                      PlayfulPalette.emerald,
                      PlayfulPalette.ocean,
                      PlayfulPalette.grape,
                      PlayfulPalette.coral,
                      PlayfulPalette.berry,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // واجهة السؤال النشط: متوازنة رأسياً بلا فراغ ميت على التابلت + صفر Overflow على 320dp
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildActiveQuestionView(
    BuildContext context,
    bool isRemedial,
    bool isInfinite,
  ) {
    final q = _questions[_currentIndex];
    final progress =
        (_currentIndex + (_currentSolved ? 1 : 0)) / _questions.length;
    final isCompact = context.isUltraCompact || context.isSmallPhone;
    final isTablet = context.isTablet;

    return Column(
      children: [
        // ── الشريط العلوي المبهج (زر إغلاق لمسي + شريط تقدم لامع + عدّاد النجوم) ──
        ResponsiveContentFrame(
          padding: EdgeInsets.fromLTRB(
            context.pagePaddingH,
            isCompact ? 8 : (isTablet ? 16 : 12),
            context.pagePaddingH,
            isCompact ? 6 : 10,
          ),
          child: Row(
            children: [
              // زر الخروج ثلاثي الأبعاد
              Juicy3DButton(
                onPressed: () => context.canPop()
                    ? context.pop()
                    : context.go(AppRouter.assessmentHub),
                color: Colors.white,
                lipColor: const Color(0xFFCBD5E1),
                foregroundColor: PlayfulPalette.ink,
                radius: 16,
                lipDepth: 3.5,
                padding: EdgeInsets.all(isCompact ? 8 : 11),
                child: Icon(
                  Icons.close_rounded,
                  size: isCompact ? 20 : 24,
                  color: PlayfulPalette.ink,
                ),
              ),
              SizedBox(width: isCompact ? 8 : 12),

              // العنوان + شريط التقدم اللامع (Candy Gloss)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            isInfinite
                                ? '${widget.args.titleAr} • جَوْلَةٌ $_roundNumber'
                                : widget.args.titleAr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize:
                                  context.scaledFont(13.5, min: 11, max: 17),
                              fontWeight: FontWeight.w900,
                              color: PlayfulPalette.ink,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.92),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: q.accentColor.withValues(alpha: 0.40),
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            '${_currentIndex + 1} / ${_questions.length}',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize:
                                  context.scaledFont(12, min: 10.5, max: 15),
                              fontWeight: FontWeight.w900,
                              color: PlayfulPalette.darken(q.accentColor, 0.10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    CandyProgressBar(
                      progress: progress,
                      color: isRemedial
                          ? const Color(0xFF14B8A6)
                          : PlayfulPalette.emerald,
                      height: isCompact ? 12 : (isTablet ? 16 : 14),
                    ),
                  ],
                ),
              ),

              SizedBox(width: isCompact ? 8 : 12),

              // عدّاد النجوم الذهبية المتوهج
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isCompact ? 9 : 13,
                  vertical: isCompact ? 6 : 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFF59E0B),
                    width: 2,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFD97706),
                      offset: Offset(0, 3),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: const Color(0xFFF59E0B),
                      size: isCompact ? 18 : 22,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '$_starsEarned',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: context.scaledFont(14, min: 12, max: 18),
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFFB45309),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ── المسرح التفاعلي الموسط رأسياً على التابلت + قابل للتمرير السلس على أصغر هاتف ──
        Expanded(
          child: LayoutBuilder(
            builder: (context, viewportConstraints) {
              final vPad = isCompact ? 8.0 : (isTablet ? 18.0 : 12.0);
              final minStageHeight =
                  (viewportConstraints.maxHeight - vPad * 2)
                      .clamp(0.0, double.infinity);

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: vPad),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: minStageHeight),
                  child: ResponsiveContentFrame(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // شريط المهارة العلمية + زر التلميح المضيء
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isCompact ? 10 : 14,
                                    vertical: isCompact ? 5 : 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.92),
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(
                                      color: q.domain.color.withValues(alpha: 0.35),
                                      width: 1.6,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: q.domain.color.withValues(alpha: 0.10),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        q.domain.icon,
                                        size: isCompact ? 16 : 19,
                                        color: q.domain.color,
                                      ),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          q.domain.titleAr,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: context.scaledFont(
                                              12.5,
                                              min: 10.5,
                                              max: 15,
                                            ),
                                            fontWeight: FontWeight.w900,
                                            color: PlayfulPalette.darken(
                                              q.domain.color,
                                              0.10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (q.scaffoldHintAr != null) ...[
                              const SizedBox(width: 8),
                              Juicy3DButton(
                                onPressed: () {
                                  HapticFeedback.selectionClick();
                                  setState(
                                    () => _showScaffoldHint = !_showScaffoldHint,
                                  );
                                },
                                color: _showScaffoldHint
                                    ? PlayfulPalette.sunny
                                    : const Color(0xFFFFFBEB),
                                lipColor: const Color(0xFFD97706),
                                foregroundColor: _showScaffoldHint
                                    ? Colors.white
                                    : const Color(0xFFB45309),
                                radius: 14,
                                lipDepth: 3,
                                padding: EdgeInsets.symmetric(
                                  horizontal: isCompact ? 10 : 14,
                                  vertical: isCompact ? 6 : 8,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.lightbulb_rounded,
                                      size: isCompact ? 16 : 19,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _showScaffoldHint
                                          ? 'إِخْفَاءُ التَّلْمِيحِ'
                                          : 'تَلْمِيحٌ',
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: context.scaledFont(
                                          12,
                                          min: 10.5,
                                          max: 14.5,
                                        ),
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),

                        // صندوق التلميح التربوي الذهبي (ثلاثي الأبعاد)
                        if (_showScaffoldHint && q.scaffoldHintAr != null) ...[
                          const SizedBox(height: 10),
                          Juicy3DCard(
                            color: const Color(0xFFFFFBEB),
                            borderColor: const Color(0xFFF59E0B),
                            lipColor: const Color(0xFFD97706),
                            radius: 18,
                            lipDepth: 3.5,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.tips_and_updates_rounded,
                                  color: Color(0xFFD97706),
                                  size: 22,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    q.scaffoldHintAr!,
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: context.scaledFont(
                                        13.5,
                                        min: 11.5,
                                        max: 16.5,
                                      ),
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xFF92400E),
                                      height: 1.38,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        SizedBox(height: isCompact ? 12 : (isTablet ? 20 : 16)),

                        // عارض التمرين التفاعلي (١٣ نوعاً مع صقر فصيح والمكعبات ثلاثية الأبعاد)
                        InteractiveQuestionBody(
                          key: ValueKey(q.id),
                          question: q,
                          allowRetry: true,
                          onPlayAudio: _playAudio,
                          onAttempt: _onAttempt,
                          onQuestionSolved: _onQuestionSolved,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // ── شريط الاحتفال والانتقال للسؤال التالي بأسلوب Duolingo ──
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 240),
          transitionBuilder: (child, anim) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.35),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutBack)),
            child: FadeTransition(opacity: anim, child: child),
          ),
          child: _currentSolved
              ? Container(
                  key: const ValueKey('solved-cta-bar'),
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                    0,
                    isCompact ? 10 : 14,
                    0,
                    isCompact ? 12 : 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                    border: const Border(
                      top: BorderSide(color: PlayfulPalette.emerald, width: 2.5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: PlayfulPalette.emerald.withValues(alpha: 0.18),
                        blurRadius: 18,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: ResponsiveContentFrame(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.celebration_rounded,
                              color: PlayfulPalette.emeraldDeep,
                              size: 22,
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                !_currentHadWrong
                                    ? 'أَحْسَنْتَ يَا بَطَلُ! إِجَابَةٌ صَحِيحَةٌ مِنْ أَوَّلِ مُحَاوَلَةٍ (+٢ ⭐)'
                                    : 'عَمَلٌ رَائِعٌ! تَعَلَّمْتَهَا بِبَرَاعَةٍ (+١ ⭐)',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: context.scaledFont(
                                    14.5,
                                    min: 12,
                                    max: 18,
                                  ),
                                  fontWeight: FontWeight.w900,
                                  color: PlayfulPalette.emeraldDeep,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isCompact ? 8 : 10),
                        Juicy3DButton(
                          onPressed: _goToNextQuestion,
                          color: PlayfulPalette.emerald,
                          lipColor: PlayfulPalette.emeraldDeep,
                          radius: 20,
                          lipDepth: 5,
                          minHeight: context.minTouchTarget,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _currentIndex < _questions.length - 1
                                    ? 'السُّؤَالُ التَّالِي'
                                    : 'عَرْضُ النَّتِيجَةِ وَالتَّشْخِيصِ',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: context.scaledFont(
                                    17,
                                    min: 14,
                                    max: 21,
                                  ),
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                _currentIndex < _questions.length - 1
                                    ? Icons.arrow_back_rounded
                                    : Icons.emoji_events_rounded,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // بطاقة النتيجة والاحتفال والتشخيص العلمي بعد إنهاء الجلسة
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildResultReport(BuildContext context, UnitAssessmentResult res) {
    final mastery = res.masteryLevel;
    final percentInt = res.percent.round();
    final isCompact = context.isUltraCompact || context.isSmallPhone;
    final isTablet = context.isTablet;
    final falconMood = mastery.needsRemedial
        ? FalconMood.encouraging
        : FalconMood.celebrating;

    return LayoutBuilder(
      builder: (context, viewportConstraints) {
        final vPad = isCompact ? 14.0 : 24.0;
        final minH = (viewportConstraints.maxHeight - vPad * 2)
            .clamp(0.0, double.infinity);

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: vPad),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: minH),
            child: ResponsiveContentFrame(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── بطاقة صقر فصيح الاحتفالية + التصنيف الخماسي ──
                  Juicy3DCard(
                    color: Colors.white,
                    borderColor: mastery.color.withValues(alpha: 0.55),
                    lipColor: PlayfulPalette.darken(mastery.color, 0.10),
                    radius: 30,
                    lipDepth: 6,
                    padding: EdgeInsets.all(isCompact ? 16 : (isTablet ? 28 : 22)),
                    child: Column(
                      children: [
                        // ميدالية صقر فصيح الذهبية
                        Container(
                          width: isCompact ? 96 : (isTablet ? 132 : 112),
                          height: isCompact ? 96 : (isTablet ? 132 : 112),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFD166), Color(0xFFFF9F1C)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFF59E0B)
                                    .withValues(alpha: 0.35),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Container(
                              color: Colors.white,
                              child: Image.asset(
                                falconMood.assetPath,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${mastery.badgeEmoji} ${mastery.titleAr}',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: context.scaledFont(24, min: 19, max: 32),
                              fontWeight: FontWeight.w900,
                              color: mastery.color,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // شارات النتيجة والنجوم
                        Wrap(
                          spacing: 10,
                          runSpacing: 8,
                          alignment: WrapAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: mastery.color.withValues(alpha: 0.13),
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: mastery.color.withValues(alpha: 0.35),
                                ),
                              ),
                              child: Text(
                                '$percentInt%  (${res.correctCount} مِنْ ${res.totalQuestions} مِنْ أَوَّلِ مُحَاوَلَةٍ)',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: context.scaledFont(
                                    14.5,
                                    min: 12,
                                    max: 18,
                                  ),
                                  fontWeight: FontWeight.w900,
                                  color: mastery.color,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFBEB),
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: const Color(0xFFF59E0B),
                                ),
                              ),
                              child: Text(
                                '⭐ $_starsEarned نَجْمَةً',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: context.scaledFont(
                                    14.5,
                                    min: 12,
                                    max: 18,
                                  ),
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFFB45309),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        Text(
                          mastery.recommendationAr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: context.scaledFont(14.5, min: 12, max: 18),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF334155),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: context.sectionGap + 2),

                  // ── تحليل الأداء حسب المهارات الست بأشرطة Candy اللامعة ──
                  Juicy3DCard(
                    color: Colors.white,
                    borderColor: const Color(0xFFCBD5E1),
                    lipColor: const Color(0xFFCBD5E1),
                    radius: 26,
                    lipDepth: 5,
                    padding: EdgeInsets.all(isCompact ? 14 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: PlayfulPalette.ocean
                                    .withValues(alpha: 0.14),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.insights_rounded,
                                color: PlayfulPalette.oceanDeep,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'التَّحْلِيلُ الْعِلْمِيُّ لِلْمَهَارَاتِ',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: context.scaledFont(
                                    16.5,
                                    min: 14,
                                    max: 21,
                                  ),
                                  fontWeight: FontWeight.w900,
                                  color: PlayfulPalette.ink,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        for (final entry in res.skillAccuracy.entries)
                          Builder(
                            builder: (context) {
                              final domain = SkillDomainMeta.fromId(entry.key);
                              if (domain == null) {
                                return const SizedBox.shrink();
                              }
                              final pct = (entry.value * 100).round();
                              final barColor = pct >= 80
                                  ? PlayfulPalette.emerald
                                  : (pct >= 60
                                      ? PlayfulPalette.sunny
                                      : PlayfulPalette.coral);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          domain.icon,
                                          size: 18,
                                          color: domain.color,
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            domain.titleAr,
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: context.scaledFont(
                                                14,
                                                min: 12,
                                                max: 16.5,
                                              ),
                                              fontWeight: FontWeight.w800,
                                              color: PlayfulPalette.ink,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '$pct%',
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: context.scaledFont(
                                              14,
                                              min: 12,
                                              max: 16.5,
                                            ),
                                            fontWeight: FontWeight.w900,
                                            color: PlayfulPalette.darken(
                                              barColor,
                                              0.12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    CandyProgressBar(
                                      progress: entry.value,
                                      color: barColor,
                                      height: 12,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        if (res.weakLetters.isNotEmpty) ...[
                          const Divider(height: 24),
                          Text(
                            '🎯 حُرُوفٌ تَحْتَاجُ تَقْوِيَةً إِضَافِيَّةً:',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: context.scaledFont(
                                14.5,
                                min: 12.5,
                                max: 17.5,
                              ),
                              fontWeight: FontWeight.w900,
                              color: PlayfulPalette.coralDeep,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: res.weakLetters.map((l) {
                              final spec =
                                  AssessmentCurriculumData.letterSpec(l);
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF1F2),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: PlayfulPalette.coral,
                                    width: 1.8,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0xFFFCA5A5),
                                      offset: Offset(0, 3),
                                      blurRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '${spec.displayChar}  (${spec.nameAr})',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: context.scaledFont(
                                      14,
                                      min: 12,
                                      max: 17,
                                    ),
                                    fontWeight: FontWeight.w900,
                                    color: PlayfulPalette.coralDeep,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),

                  SizedBox(height: context.sectionGap + 6),

                  // ── أزرار الإجراء التالي ثلاثية الأبعاد ──
                  if (res.weakLetters.isNotEmpty || mastery.needsRemedial) ...[
                    Juicy3DButton(
                      onPressed: () => _launchAutoRemedial(res),
                      color: const Color(0xFFF97316),
                      lipColor: const Color(0xFFC2410C),
                      radius: 20,
                      lipDepth: 5,
                      minHeight: context.minTouchTarget + 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.healing_rounded, size: 24),
                          const SizedBox(width: 8),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'ابْدَأِ التَّمَارِينَ الْعِلَاجِيَّةَ لِنِقَاطِ الضَّعْفِ الْآنَ',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: context.scaledFont(
                                    15.5,
                                    min: 13,
                                    max: 19,
                                  ),
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],

                  Juicy3DButton(
                    onPressed: _startAnotherInfiniteRound,
                    color: PlayfulPalette.ocean,
                    lipColor: PlayfulPalette.oceanDeep,
                    radius: 20,
                    lipDepth: 5,
                    minHeight: context.minTouchTarget,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.autorenew_rounded, size: 24),
                        const SizedBox(width: 8),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'جَوْلَةٌ جَدِيدَةٌ بِأَسْئِلَةٍ جَدِيدَةٍ (تَوْلِيدٌ لَانِهَائِيٌّ)',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: context.scaledFont(
                                  15,
                                  min: 13,
                                  max: 18.5,
                                ),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  Juicy3DButton(
                    onPressed: () => context.canPop()
                        ? context.pop()
                        : context.go(AppRouter.assessmentHub),
                    color: Colors.white,
                    lipColor: const Color(0xFFCBD5E1),
                    foregroundColor: PlayfulPalette.ink,
                    radius: 20,
                    lipDepth: 4,
                    minHeight: context.minTouchTarget,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.dashboard_rounded,
                          size: 22,
                          color: PlayfulPalette.ink,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'الْعَوْدَةُ لِمَرْكَزِ الْقِيَاسِ وَالتَّقْوِيَةِ',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: context.scaledFont(
                                  14.5,
                                  min: 12.5,
                                  max: 18,
                                ),
                                fontWeight: FontWeight.w900,
                                color: PlayfulPalette.ink,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
