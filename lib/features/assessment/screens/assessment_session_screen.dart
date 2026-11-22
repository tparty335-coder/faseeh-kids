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
import 'package:faseeh_kids/features/assessment/widgets/question_renderer_widgets.dart';
import 'package:faseeh_kids/services/audio_manager.dart';
import 'package:faseeh_kids/services/audio_service.dart';

/// شاشة تنفيذ جلسة الاختبار أو العيادة العلاجية أو التمارين اللانهائية
/// + بطاقة التشخيص العلمي الفوري في نهاية الجلسة
class AssessmentSessionScreen extends ConsumerStatefulWidget {
  final AssessmentSessionArgs args;

  const AssessmentSessionScreen({super.key, required this.args});

  @override
  ConsumerState<AssessmentSessionScreen> createState() =>
      _AssessmentSessionScreenState();
}

class _AssessmentSessionScreenState
    extends ConsumerState<AssessmentSessionScreen> {
  static const Color _navy = Color(0xFF1B2A4A);

  late List<GeneratedQuestion> _questions;
  int _currentIndex = 0;
  int _currentAttempts = 0;
  bool _currentHadWrong = false;
  bool _currentSolved = false;
  bool _showScaffoldHint = false;
  int _audioToken = 0;
  int _roundNumber = 1;

  final List<QuestionAttemptRecord> _records = [];
  UnitAssessmentResult? _completedResult;

  @override
  void initState() {
    super.initState();
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
    _records.add(
      QuestionAttemptRecord(
        letter: q.letter,
        domain: q.domain,
        exerciseType: q.type,
        isCorrectFirstTry: !_currentHadWrong,
        attempts: _currentAttempts == 0 ? 1 : _currentAttempts,
      ),
    );
    setState(() {
      _currentSolved = true;
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
      final result = ref.read(assessmentDiagnosticsProvider.notifier).recordSession(
            mode: widget.args.mode,
            records: _records,
            unitIndex: widget.args.unitIndex,
          );
      AudioManager.instance.playFeedback('champion');
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
    final isInfinite = widget.args.mode == AssessmentSessionMode.infinitePractice;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FC),
        body: SafeArea(
          child: _completedResult != null
              ? _buildResultReport(context, _completedResult!)
              : _buildActiveQuestionView(context, isRemedial, isInfinite),
        ),
      ),
    );
  }

  Widget _buildActiveQuestionView(
    BuildContext context,
    bool isRemedial,
    bool isInfinite,
  ) {
    final q = _questions[_currentIndex];
    final progress = (_currentIndex + (_currentSolved ? 1 : 0)) / _questions.length;
    final isCompact = context.isUltraCompact || context.isSmallPhone;

    return Column(
      children: [
        // ── الشريط العلوي المتجاوب (لا يتكدس حتى على 320dp) ──
        ResponsiveContentFrame(
          padding: EdgeInsets.fromLTRB(
            context.pagePaddingH,
            isCompact ? 8 : 12,
            context.pagePaddingH,
            isCompact ? 6 : 8,
          ),
          child: Row(
            children: [
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => context.canPop()
                      ? context.pop()
                      : context.go(AppRouter.assessmentHub),
                  child: SizedBox(
                    width: isCompact ? 40 : 44,
                    height: isCompact ? 40 : 44,
                    child: const Icon(
                      Icons.close_rounded,
                      color: _navy,
                      size: 22,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              fontSize: context.scaledFont(13.5, min: 11.5, max: 17),
                              fontWeight: FontWeight.w800,
                              color: _navy,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            color: q.accentColor.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            '${_currentIndex + 1} / ${_questions.length}',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: context.scaledFont(12.5, min: 11, max: 15),
                              fontWeight: FontWeight.w900,
                              color: q.accentColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: progress.clamp(0.05, 1.0),
                        minHeight: isCompact ? 8 : 10,
                        backgroundColor: const Color(0xFFE2E8F0),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isRemedial ? const Color(0xFF0D9488) : q.accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ── جسم السؤال القابل للتمرير (صفر Overflow على 320×533 حتى 960×1600) ──
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: isCompact ? 6 : 10),
            child: ResponsiveContentFrame(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // شارة المهارة العلمية + زر التلميح المساعِد
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: q.domain.color.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(q.domain.icon, size: 16, color: q.domain.color),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  q.domain.titleAr,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: context.scaledFont(12, min: 10.5, max: 14.5),
                                    fontWeight: FontWeight.w800,
                                    color: q.domain.color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (q.scaffoldHintAr != null) ...[
                        const SizedBox(width: 8),
                        TextButton.icon(
                          onPressed: () {
                            HapticFeedback.selectionClick();
                            setState(() => _showScaffoldHint = !_showScaffoldHint);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFFEF3C7),
                            foregroundColor: const Color(0xFFB45309),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.lightbulb_rounded, size: 17),
                          label: Text(
                            _showScaffoldHint ? 'إِخْفَاءُ التَّلْمِيحِ' : 'تَلْمِيحٌ',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: context.scaledFont(12, min: 10.5, max: 14),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                  // صندوق التلميح التربوي (للضعفاء أو عند الطلب)
                  if (_showScaffoldHint && q.scaffoldHintAr != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFF59E0B).withValues(alpha: 0.45),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.tips_and_updates_rounded,
                            color: Color(0xFFD97706),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              q.scaffoldHintAr!,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: context.scaledFont(13, min: 11.5, max: 16),
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF92400E),
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  SizedBox(height: isCompact ? 10 : 14),

                  // عارض التمرين التفاعلي (١٣ نوعاً)
                  InteractiveQuestionBody(
                    key: ValueKey(q.id),
                    question: q,
                    allowRetry: true, // السماح بالمحاولة حتى يتعلم الطفل بدون إحباط (والتشخيص يسجل المحاولة الأولى بدقة!)
                    onPlayAudio: _playAudio,
                    onAttempt: _onAttempt,
                    onQuestionSolved: _onQuestionSolved,
                  ),
                ],
              ),
            ),
          ),
        ),

        // ── الشريط السفلي للانتقال للسؤال التالي ──
        if (_currentSolved)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: isCompact ? 10 : 14,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: ResponsiveContentFrame(
              child: SizedBox(
                width: double.infinity,
                height: context.minTouchTarget,
                child: ElevatedButton.icon(
                  onPressed: _goToNextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF16A34A),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  icon: Icon(
                    _currentIndex < _questions.length - 1
                        ? Icons.arrow_back_rounded
                        : Icons.emoji_events_rounded,
                  ),
                  label: Text(
                    _currentIndex < _questions.length - 1
                        ? 'السُّؤَالُ التَّالِي'
                        : 'عَرْضُ النَّتِيجَةِ وَالتَّشْخِيصِ',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: context.scaledFont(16, min: 14, max: 20),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // بطاقة النتيجة والتشخيص العلمي بعد إنهاء الجلسة
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildResultReport(BuildContext context, UnitAssessmentResult res) {
    final mastery = res.masteryLevel;
    final percentInt = res.percent.round();
    final isCompact = context.isUltraCompact || context.isSmallPhone;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: isCompact ? 14 : 22),
      child: ResponsiveContentFrame(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // بطاقة النتيجة والتصنيف الخماسي
            Container(
              padding: EdgeInsets.all(isCompact ? 16 : 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: mastery.color.withValues(alpha: 0.35),
                  width: 2.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: mastery.color.withValues(alpha: 0.12),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    mastery.badgeEmoji,
                    style: TextStyle(fontSize: isCompact ? 50 : 64),
                  ),
                  const SizedBox(height: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      mastery.titleAr,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: context.scaledFont(23, min: 18, max: 30),
                        fontWeight: FontWeight.w900,
                        color: mastery.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    decoration: BoxDecoration(
                      color: mastery.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '$percentInt%  (${res.correctCount} مِنْ ${res.totalQuestions} مِنْ أَوَّلِ مُحَاوَلَةٍ)',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: context.scaledFont(15, min: 12.5, max: 18),
                        fontWeight: FontWeight.w900,
                        color: mastery.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    mastery.recommendationAr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: context.scaledFont(14, min: 12, max: 17),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF334155),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.sectionGap),

            // تحليل الأداء حسب المهارات الست
            Container(
              padding: EdgeInsets.all(isCompact ? 14 : 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '📊 التَّحْلِيلُ الْعِلْمِيُّ لِلْمَهَارَاتِ',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: context.scaledFont(16, min: 14, max: 20),
                      fontWeight: FontWeight.w900,
                      color: _navy,
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (final entry in res.skillAccuracy.entries)
                    Builder(
                      builder: (context) {
                        final domain = SkillDomainMeta.fromId(entry.key);
                        if (domain == null) return const SizedBox.shrink();
                        final pct = (entry.value * 100).round();
                        final barColor = pct >= 80
                            ? const Color(0xFF16A34A)
                            : (pct >= 60 ? const Color(0xFFD97706) : const Color(0xFFDC2626));
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(domain.icon, size: 17, color: domain.color),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      domain.titleAr,
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: context.scaledFont(13.5, min: 12, max: 16),
                                        fontWeight: FontWeight.w800,
                                        color: _navy,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '$pct%',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: context.scaledFont(13.5, min: 12, max: 16),
                                      fontWeight: FontWeight.w900,
                                      color: barColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(999),
                                child: LinearProgressIndicator(
                                  value: entry.value.clamp(0.05, 1.0),
                                  minHeight: 8,
                                  backgroundColor: const Color(0xFFF1F5F9),
                                  valueColor: AlwaysStoppedAnimation<Color>(barColor),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  if (res.weakLetters.isNotEmpty) ...[
                    const Divider(height: 22),
                    Text(
                      '🎯 حُرُوفٌ تَحْتَاجُ تَقْوِيَةً إِضَافِيَّةً:',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: context.scaledFont(14, min: 12.5, max: 17),
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFFDC2626),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: res.weakLetters.map((l) {
                        final spec = AssessmentCurriculumData.letterSpec(l);
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEE2E2),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: const Color(0xFFEF4444).withValues(alpha: 0.45),
                            ),
                          ),
                          child: Text(
                            '${spec.displayChar}  (${spec.nameAr})',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: context.scaledFont(14, min: 12, max: 17),
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFFB91C1C),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: context.sectionGap + 4),

            // أزرار الإجراء التالي (زر الخطة العلاجية يظهر تلقائياً عند وجود ضعف!)
            if (res.weakLetters.isNotEmpty || mastery.needsRemedial) ...[
              SizedBox(
                height: context.minTouchTarget + 4,
                child: ElevatedButton.icon(
                  onPressed: () => _launchAutoRemedial(res),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEA580C),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  icon: const Icon(Icons.healing_rounded),
                  label: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'ابْدَأِ التَّمَارِينَ الْعِلَاجِيَّةَ لِنِقَاطِ الضَّعْفِ الْآنَ',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: context.scaledFont(15.5, min: 13, max: 19),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],

            SizedBox(
              height: context.minTouchTarget,
              child: ElevatedButton.icon(
                onPressed: _startAnotherInfiniteRound,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0284C7),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                icon: const Icon(Icons.autorenew_rounded),
                label: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'جَوْلَةٌ جَدِيدَةٌ بِأَسْئِلَةٍ جَدِيدَةٍ (تَوْلِيدٌ لَانِهَائِيٌّ)',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: context.scaledFont(15, min: 13, max: 18),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: context.minTouchTarget,
              child: OutlinedButton.icon(
                onPressed: () => context.canPop()
                    ? context.pop()
                    : context.go(AppRouter.assessmentHub),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _navy,
                  side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                icon: const Icon(Icons.dashboard_rounded),
                label: Text(
                  'الْعَوْدَةُ لِمَرْكَزِ الْقِيَاسِ وَالتَّقْوِيَةِ',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: context.scaledFont(14.5, min: 12.5, max: 18),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
