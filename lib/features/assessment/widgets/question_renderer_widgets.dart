import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faseeh_kids/core/utils/responsive.dart';
import 'package:faseeh_kids/features/assessment/models/assessment_models.dart';
import 'package:faseeh_kids/features/assessment/widgets/cropped_illustration_box.dart';
import 'package:faseeh_kids/features/lessons/widgets/arabic_letter_tracing_canvas.dart';

/// عارض تفاعلي موحّد ومتجاوب لجميع أنواع التمارين الـ ١٣
/// مُصمَّم ليعمل بأناقة ووضوح تام من أصغر الهواتف القديمة (320×533) حتى أكبر التابلت (960×1600)
class InteractiveQuestionBody extends StatefulWidget {
  final GeneratedQuestion question;
  final bool allowRetry;
  final ValueChanged<String?> onPlayAudio;
  final void Function({required bool isCorrect}) onAttempt;
  final VoidCallback onQuestionSolved;

  const InteractiveQuestionBody({
    super.key,
    required this.question,
    required this.allowRetry,
    required this.onPlayAudio,
    required this.onAttempt,
    required this.onQuestionSolved,
  });

  @override
  State<InteractiveQuestionBody> createState() => _InteractiveQuestionBodyState();
}

class _InteractiveQuestionBodyState extends State<InteractiveQuestionBody> {
  static const Color _navy = Color(0xFF1B2A4A);

  bool _solved = false;
  String? _selectedChoiceId;
  final Set<String> _wrongChoiceIds = {};
  final Set<String> _foundTargetIds = {};
  final List<int> _assembledIndices = [];
  bool _sequenceWrongFlash = false;

  @override
  void didUpdateWidget(covariant InteractiveQuestionBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question.id != widget.question.id) {
      _resetState();
    }
  }

  void _resetState() {
    _solved = false;
    _selectedChoiceId = null;
    _wrongChoiceIds.clear();
    _foundTargetIds.clear();
    _assembledIndices.clear();
    _sequenceWrongFlash = false;
  }

  void _handleSingleChoiceTap(QuestionChoice choice) {
    if (_solved) return;
    HapticFeedback.selectionClick();
    if (choice.audioPath != null && choice.audioPath!.isNotEmpty) {
      widget.onPlayAudio(choice.audioPath);
    }

    if (choice.isCorrect) {
      setState(() {
        _solved = true;
        _selectedChoiceId = choice.id;
      });
      widget.onAttempt(isCorrect: true);
      widget.onQuestionSolved();
    } else {
      setState(() {
        _selectedChoiceId = choice.id;
        _wrongChoiceIds.add(choice.id);
      });
      widget.onAttempt(isCorrect: false);
      if (!widget.allowRetry) {
        setState(() => _solved = true);
        widget.onQuestionSolved();
      }
    }
  }

  void _handleMultiFindTap(QuestionChoice choice) {
    if (_solved) return;
    if (_foundTargetIds.contains(choice.id) || _wrongChoiceIds.contains(choice.id)) {
      return;
    }
    HapticFeedback.selectionClick();

    if (choice.isCorrect) {
      final totalTargets =
          widget.question.choices.where((c) => c.isCorrect).length;
      setState(() {
        _foundTargetIds.add(choice.id);
      });
      if (_foundTargetIds.length >= totalTargets) {
        setState(() => _solved = true);
        widget.onAttempt(isCorrect: true);
        widget.onQuestionSolved();
      }
    } else {
      setState(() {
        _wrongChoiceIds.add(choice.id);
      });
      widget.onAttempt(isCorrect: false);
    }
  }

  void _handleSequencePoolTap(int poolIndex) {
    if (_solved || _assembledIndices.contains(poolIndex)) return;
    HapticFeedback.lightImpact();

    final q = widget.question;
    setState(() {
      _sequenceWrongFlash = false;
      _assembledIndices.add(poolIndex);
    });

    if (_assembledIndices.length == q.correctSequence.length) {
      final built = _assembledIndices.map((i) => q.sequenceItems[i]).toList();
      bool allMatch = true;
      for (int i = 0; i < built.length; i++) {
        if (built[i] != q.correctSequence[i]) {
          allMatch = false;
          break;
        }
      }
      if (allMatch) {
        setState(() => _solved = true);
        widget.onAttempt(isCorrect: true);
        widget.onQuestionSolved();
      } else {
        setState(() => _sequenceWrongFlash = true);
        widget.onAttempt(isCorrect: false);
        Future.delayed(const Duration(milliseconds: 650), () {
          if (mounted && !_solved) {
            setState(() {
              _assembledIndices.clear();
              _sequenceWrongFlash = false;
            });
          }
        });
      }
    }
  }

  void _removeAssembledSlot(int slotPos) {
    if (_solved) return;
    HapticFeedback.selectionClick();
    setState(() {
      _sequenceWrongFlash = false;
      _assembledIndices.removeAt(slotPos);
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.question;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth;
        final isCompact = maxW < 360;
        final isWide = maxW >= 580;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── بطاقة السؤال والتوجيه الصوتي ──
            _buildPromptHeader(context, q, maxW, isCompact),
            SizedBox(height: isCompact ? 10 : 14),

            // ── جسم التمرين حسب النوع (١٣ نوعاً) ──
            _buildExerciseContent(context, q, maxW, isCompact, isWide),
          ],
        );
      },
    );
  }

  Widget _buildPromptHeader(
    BuildContext context,
    GeneratedQuestion q,
    double maxW,
    bool isCompact,
  ) {
    final accent = q.accentColor;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 12 : 16,
        vertical: isCompact ? 10 : 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: accent.withValues(alpha: 0.22), width: 1.6),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // زر استماع كبير مريح للطفل
          Material(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => widget.onPlayAudio(q.audioPath),
              child: SizedBox(
                width: isCompact ? 44 : 52,
                height: isCompact ? 44 : 52,
                child: Icon(
                  Icons.volume_up_rounded,
                  color: accent,
                  size: isCompact ? 24 : 28,
                ),
              ),
            ),
          ),
          SizedBox(width: isCompact ? 10 : 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (q.promptBadgeAr != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      q.promptBadgeAr!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: context.scaledFont(11.5, min: 10.5, max: 14),
                        fontWeight: FontWeight.w800,
                        color: accent,
                      ),
                    ),
                  ),
                Text(
                  q.instructionAr,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: context.scaledFont(15.5, min: 13.0, max: 20.0),
                    fontWeight: FontWeight.w800,
                    color: _navy,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseContent(
    BuildContext context,
    GeneratedQuestion q,
    double maxW,
    bool isCompact,
    bool isWide,
  ) {
    switch (q.type) {
      case ExerciseType.findAndTapGrid:
        return _buildFindGrid(context, q, maxW, isCompact, isWide);
      case ExerciseType.circleMatchLetter:
        return _buildCircleMatch(context, q, maxW, isCompact, isWide);
      case ExerciseType.similarLettersSpot:
        return _buildSimilarSpot(context, q, maxW, isCompact, isWide);
      case ExerciseType.oddOneOut:
        return _buildOddOneOut(context, q, maxW, isCompact, isWide);
      case ExerciseType.chooseLetterForm:
        return _buildChooseForm(context, q, maxW, isCompact, isWide);
      case ExerciseType.identifyLetterPosition:
        return _buildIdentifyPosition(context, q, maxW, isCompact);
      case ExerciseType.chooseHaraka:
        return _buildChooseHaraka(context, q, maxW, isCompact, isWide);
      case ExerciseType.matchPictureToLetter:
        return _buildMatchPicture(context, q, maxW, isCompact, isWide);
      case ExerciseType.unscrambleWord:
        return _buildSequenceAssembler(
          context,
          q,
          maxW,
          isCompact,
          isSentence: false,
        );
      case ExerciseType.joinLettersToWord:
        return _buildJoinLetters(context, q, maxW, isCompact, isWide);
      case ExerciseType.missingLetterInWord:
        return _buildMissingLetter(context, q, maxW, isCompact, isWide);
      case ExerciseType.buildSentence:
        return _buildSequenceAssembler(
          context,
          q,
          maxW,
          isCompact,
          isSentence: true,
        );
      case ExerciseType.tracingDrill:
        return _buildTracingDrill(context, q, maxW, isCompact);
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 1. شبكة البحث والتلوين
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildFindGrid(
    BuildContext context,
    GeneratedQuestion q,
    double maxW,
    bool isCompact,
    bool isWide,
  ) {
    final totalTargets = q.choices.where((c) => c.isCorrect).length;
    final found = _foundTargetIds.length;
    final cols = isCompact ? 3 : (isWide ? 4 : 4);
    final gap = isCompact ? 8.0 : 12.0;

    return Column(
      children: [
        // بطاقة الحرف المطلوب + العداد
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? 14 : 20,
            vertical: isCompact ? 10 : 12,
          ),
          decoration: BoxDecoration(
            color: q.accentColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: q.accentColor.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: isCompact ? 50 : 60,
                height: isCompact ? 50 : 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: q.accentColor, width: 2.5),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    q.displayPrompt ?? q.letter,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: isCompact ? 28 : 34,
                      fontWeight: FontWeight.w900,
                      color: q.accentColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Flexible(
                child: Text(
                  'تَمَّ تَلْوِينُ $found مِنْ $totalTargets ⭐',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: context.scaledFont(16, min: 13.5, max: 20),
                    fontWeight: FontWeight.w900,
                    color: _navy,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: isCompact ? 10 : 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: q.choices.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: gap,
            mainAxisSpacing: gap,
            childAspectRatio: isCompact ? 1.15 : 1.2,
          ),
          itemBuilder: (context, index) {
            final c = q.choices[index];
            final isFound = _foundTargetIds.contains(c.id);
            final isWrong = _wrongChoiceIds.contains(c.id);

            Color bg = Colors.white;
            Color border = const Color(0xFFCBD5E1);
            Color fg = _navy;
            if (isFound) {
              bg = const Color(0xFF16A34A);
              border = const Color(0xFF15803D);
              fg = Colors.white;
            } else if (isWrong) {
              bg = const Color(0xFFFEE2E2);
              border = const Color(0xFFEF4444);
              fg = const Color(0xFFB91C1C);
            }

            return Material(
              color: bg,
              borderRadius: BorderRadius.circular(18),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => _handleMultiFindTap(c),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: border, width: isFound ? 2.5 : 1.6),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(6),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          c.label,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: context.scaledFont(28, min: 22, max: 36),
                            fontWeight: FontWeight.w900,
                            color: fg,
                          ),
                        ),
                      ),
                      if (isFound)
                        const Positioned(
                          top: 2,
                          left: 2,
                          child: Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 2. صل الحرف بالدائرة المركزية (مستلهم من ا.jpg و ث.jpg)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCircleMatch(
    BuildContext context,
    GeneratedQuestion q,
    double maxW,
    bool isCompact,
    bool isWide,
  ) {
    final totalTargets = q.choices.where((c) => c.isCorrect).length;
    final found = _foundTargetIds.length;
    final centerSize = isCompact ? 92.0 : (isWide ? 124.0 : 108.0);
    final thumbSize = isCompact ? 62.0 : 78.0;

    return Column(
      children: [
        // بطاقة الدائرة المركزية + الصورة التوضيحية
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(isCompact ? 12 : 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: q.accentColor.withValues(alpha: 0.25), width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (q.imagePath != null && q.imageCropRect != null) ...[
                CroppedIllustrationBox(
                  imagePath: q.imagePath!,
                  cropRect: q.imageCropRect!,
                  width: thumbSize,
                  height: thumbSize,
                  borderRadius: 16,
                  borderColor: q.accentColor.withValues(alpha: 0.25),
                ),
                SizedBox(width: isCompact ? 12 : 20),
              ],
              Container(
                width: centerSize,
                height: centerSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: q.accentColor.withValues(alpha: 0.10),
                  border: Border.all(color: q.accentColor, width: 3.5),
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      q.displayPrompt ?? q.letter,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: isCompact ? 42 : 54,
                        fontWeight: FontWeight.w900,
                        color: q.accentColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: isCompact ? 10 : 18),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (q.secondaryPrompt != null)
                      Text(
                        q.secondaryPrompt!,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: context.scaledFont(17, min: 14, max: 22),
                          fontWeight: FontWeight.w900,
                          color: _navy,
                        ),
                      ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      children: List.generate(
                        totalTargets,
                        (i) => Container(
                          width: isCompact ? 24 : 28,
                          height: isCompact ? 24 : 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: i < found ? const Color(0xFF16A34A) : const Color(0xFFF1F5F9),
                            border: Border.all(
                              color: i < found ? const Color(0xFF15803D) : q.accentColor,
                              width: 1.8,
                            ),
                          ),
                          child: Icon(
                            i < found ? Icons.check_rounded : Icons.circle_outlined,
                            size: 16,
                            color: i < found ? Colors.white : q.accentColor.withValues(alpha: 0.5),
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
        SizedBox(height: isCompact ? 10 : 14),
        // البطاقات المحيطة (شبكة 4 أعمدة نظيفة)
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: q.choices.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: isCompact ? 8 : 12,
            mainAxisSpacing: isCompact ? 8 : 12,
            childAspectRatio: isCompact ? 1.05 : 1.18,
          ),
          itemBuilder: (context, index) {
            final c = q.choices[index];
            final isFound = _foundTargetIds.contains(c.id);
            final isWrong = _wrongChoiceIds.contains(c.id);
            return _ChoiceCardTile(
              label: c.label,
              isSelectedCorrect: isFound,
              isSelectedWrong: isWrong,
              accent: q.accentColor,
              compact: isCompact,
              onTap: () => _handleMultiFindTap(c),
            );
          },
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 3. تحدّي الحروف المتشابهة والنقاط
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSimilarSpot(
    BuildContext context,
    GeneratedQuestion q,
    double maxW,
    bool isCompact,
    bool isWide,
  ) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(isCompact ? 12 : 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F3FF),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFF7C3AED).withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              if (q.imagePath != null && q.imageCropRect != null) ...[
                CroppedIllustrationBox(
                  imagePath: q.imagePath!,
                  cropRect: q.imageCropRect!,
                  width: isCompact ? 68 : 88,
                  height: isCompact ? 68 : 88,
                  borderRadius: 16,
                ),
                SizedBox(width: isCompact ? 10 : 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      q.displayPrompt ?? '',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: context.scaledFont(17, min: 14, max: 22),
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF4C1D95),
                        height: 1.4,
                      ),
                    ),
                    if (q.secondaryPrompt != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        q.secondaryPrompt!,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: context.scaledFont(14, min: 12, max: 18),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: isCompact ? 12 : 16),
        _buildSingleChoiceGrid(context, q, isCompact: isCompact, isWide: isWide),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 4. اكتشف المختلف (Odd One Out)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildOddOneOut(
    BuildContext context,
    GeneratedQuestion q,
    double maxW,
    bool isCompact,
    bool isWide,
  ) {
    final hasImages = q.choices.any((c) => c.imagePath != null);
    final gap = isCompact ? 10.0 : 14.0;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: q.choices.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isWide && !hasImages ? 4 : 2,
        crossAxisSpacing: gap,
        mainAxisSpacing: gap,
        childAspectRatio: hasImages ? (isCompact ? 0.96 : 1.08) : (isCompact ? 1.3 : 1.45),
      ),
      itemBuilder: (context, index) {
        final c = q.choices[index];
        final isCorrectSelected = _solved && c.isCorrect;
        final isWrong = _wrongChoiceIds.contains(c.id);

        if (hasImages && c.imagePath != null && c.imageCropRect != null) {
          return Material(
            color: isCorrectSelected
                ? const Color(0xFFDCFCE7)
                : (isWrong ? const Color(0xFFFEE2E2) : Colors.white),
            borderRadius: BorderRadius.circular(22),
            child: InkWell(
              borderRadius: BorderRadius.circular(22),
              onTap: () => _handleSingleChoiceTap(c),
              child: Container(
                padding: EdgeInsets.all(isCompact ? 8 : 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: isCorrectSelected
                        ? const Color(0xFF16A34A)
                        : (isWrong ? const Color(0xFFEF4444) : const Color(0xFFCBD5E1)),
                    width: isCorrectSelected || isWrong ? 2.6 : 1.6,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: CroppedIllustrationBox(
                        imagePath: c.imagePath!,
                        cropRect: c.imageCropRect!,
                        width: double.infinity,
                        borderRadius: 14,
                        borderColor: Colors.transparent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        c.label,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: context.scaledFont(16, min: 13, max: 20),
                          fontWeight: FontWeight.w900,
                          color: _navy,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return _ChoiceCardTile(
          label: c.label,
          isSelectedCorrect: isCorrectSelected,
          isSelectedWrong: isWrong,
          accent: q.accentColor,
          compact: isCompact,
          onTap: () => _handleSingleChoiceTap(c),
        );
      },
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 5. الشكل المتصل والمنفصل (Choose Letter Form)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildChooseForm(
    BuildContext context,
    GeneratedQuestion q,
    double maxW,
    bool isCompact,
    bool isWide,
  ) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? 12 : 18,
            vertical: isCompact ? 14 : 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: q.accentColor.withValues(alpha: 0.25), width: 2),
          ),
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  q.displayPrompt ?? '',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: context.scaledFont(32, min: 24, max: 44),
                    fontWeight: FontWeight.w900,
                    color: _navy,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              if (q.secondaryPrompt != null) ...[
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'الْكَلِمَةُ: ${q.secondaryPrompt}',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: context.scaledFont(15, min: 13, max: 19),
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF334155),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: isCompact ? 12 : 16),
        _buildSingleChoiceGrid(context, q, isCompact: isCompact, isWide: isWide),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 6. أين يقع الحرف في الكلمة؟ (أول / وسط / آخر)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildIdentifyPosition(
    BuildContext context,
    GeneratedQuestion q,
    double maxW,
    bool isCompact,
  ) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? 14 : 20,
            vertical: isCompact ? 14 : 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: q.accentColor.withValues(alpha: 0.25), width: 2),
          ),
          child: Column(
            children: [
              if (q.secondaryPrompt != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: q.accentColor.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'الْحَرْفُ الْمَطْلُوبُ: ${q.secondaryPrompt}',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: context.scaledFont(15, min: 13, max: 19),
                      fontWeight: FontWeight.w900,
                      color: q.accentColor,
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  q.displayPrompt ?? '',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: context.scaledFont(40, min: 30, max: 52),
                    fontWeight: FontWeight.w900,
                    color: _navy,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: isCompact ? 12 : 16),
        // ٣ أزرار واضحة متراصة أفقياً على التابلت أو رأسياً مريحاً على الهواتف الصغيرة
        if (maxW >= 460)
          Row(
            children: [
              for (int i = 0; i < q.choices.length; i++) ...[
                if (i > 0) const SizedBox(width: 10),
                Expanded(child: _buildPositionChoiceCard(context, q.choices[i], isCompact)),
              ],
            ],
          )
        else
          Column(
            children: [
              for (int i = 0; i < q.choices.length; i++) ...[
                if (i > 0) const SizedBox(height: 10),
                _buildPositionChoiceCard(context, q.choices[i], isCompact),
              ],
            ],
          ),
      ],
    );
  }

  Widget _buildPositionChoiceCard(
    BuildContext context,
    QuestionChoice c,
    bool isCompact,
  ) {
    final accent = c.accentColor ?? const Color(0xFF0284C7);
    final isCorrectSelected = _solved && c.isCorrect;
    final isWrong = _wrongChoiceIds.contains(c.id);

    return Material(
      color: isCorrectSelected
          ? const Color(0xFF16A34A)
          : (isWrong ? const Color(0xFFFEE2E2) : Colors.white),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _handleSingleChoiceTap(c),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 14,
            vertical: isCompact ? 12 : 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isCorrectSelected
                  ? const Color(0xFF15803D)
                  : (isWrong ? const Color(0xFFEF4444) : accent.withValues(alpha: 0.4)),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (c.sublabel != null)
                Text(
                  c.sublabel!,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: context.scaledFont(26, min: 22, max: 34),
                    fontWeight: FontWeight.w900,
                    color: isCorrectSelected ? Colors.white : accent,
                  ),
                ),
              const SizedBox(height: 4),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  c.label,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: context.scaledFont(15, min: 13, max: 19),
                    fontWeight: FontWeight.w800,
                    color: isCorrectSelected ? Colors.white : _navy,
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
  // 7. اختر الحركة المناسبة (مثل اختار الحركة المناسبة و ك.jpg)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildChooseHaraka(
    BuildContext context,
    GeneratedQuestion q,
    double maxW,
    bool isCompact,
    bool isWide,
  ) {
    final imgSize = isCompact ? 104.0 : (isWide ? 154.0 : 128.0);
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(isCompact ? 12 : 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: q.accentColor.withValues(alpha: 0.25), width: 2),
          ),
          child: Column(
            children: [
              if (q.imagePath != null && q.imageCropRect != null)
                GestureDetector(
                  onTap: () => widget.onPlayAudio(q.audioPath),
                  child: CroppedIllustrationBox(
                    imagePath: q.imagePath!,
                    cropRect: q.imageCropRect!,
                    width: imgSize,
                    height: imgSize,
                    borderRadius: 20,
                    borderColor: q.accentColor.withValues(alpha: 0.2),
                  ),
                ),
              const SizedBox(height: 10),
              if (q.displayPrompt != null)
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    _solved ? (q.secondaryPrompt ?? q.displayPrompt!) : q.displayPrompt!,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: context.scaledFont(32, min: 22, max: 42),
                      fontWeight: FontWeight.w900,
                      color: _solved ? const Color(0xFF15803D) : _navy,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: isCompact ? 12 : 16),
        Row(
          children: [
            for (int i = 0; i < q.choices.length; i++) ...[
              if (i > 0) SizedBox(width: isCompact ? 8 : 12),
              Expanded(
                child: _ChoiceCardTile(
                  label: q.choices[i].label,
                  sublabel: q.choices[i].sublabel,
                  isSelectedCorrect: _solved && q.choices[i].isCorrect,
                  isSelectedWrong: _wrongChoiceIds.contains(q.choices[i].id),
                  accent: q.choices[i].accentColor ?? q.accentColor,
                  compact: isCompact,
                  minHeight: isCompact ? 84 : 104,
                  onTap: () => _handleSingleChoiceTap(q.choices[i]),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 8. صل الصورة بحرفها الأول
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildMatchPicture(
    BuildContext context,
    GeneratedQuestion q,
    double maxW,
    bool isCompact,
    bool isWide,
  ) {
    final imgSize = isCompact ? 116.0 : (isWide ? 170.0 : 142.0);
    return Column(
      children: [
        GestureDetector(
          onTap: () => widget.onPlayAudio(q.audioPath),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(isCompact ? 12 : 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: q.accentColor.withValues(alpha: 0.25), width: 2),
            ),
            child: Column(
              children: [
                if (q.imagePath != null && q.imageCropRect != null)
                  CroppedIllustrationBox(
                    imagePath: q.imagePath!,
                    cropRect: q.imageCropRect!,
                    width: imgSize,
                    height: imgSize,
                    borderRadius: 20,
                    borderColor: q.accentColor.withValues(alpha: 0.2),
                  ),
                if (q.displayPrompt != null || _solved) ...[
                  const SizedBox(height: 8),
                  Text(
                    q.secondaryPrompt ?? q.displayPrompt ?? '',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: context.scaledFont(22, min: 17, max: 28),
                      fontWeight: FontWeight.w900,
                      color: _navy,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        SizedBox(height: isCompact ? 12 : 16),
        _buildSingleChoiceGrid(context, q, isCompact: isCompact, isWide: isWide),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 9 & 12. ترتيب حروف الكلمة / تكوين الجملة (Interactive Tile Assembler)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSequenceAssembler(
    BuildContext context,
    GeneratedQuestion q,
    double maxW,
    bool isCompact, {
    required bool isSentence,
  }) {
    final slotsCount = q.correctSequence.length;
    final imgSize = isCompact ? 82.0 : 108.0;

    return Column(
      children: [
        // الصورة التوضيحية + خانات التركيب
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(isCompact ? 12 : 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _solved
                  ? const Color(0xFF16A34A)
                  : (_sequenceWrongFlash
                      ? const Color(0xFFEF4444)
                      : q.accentColor.withValues(alpha: 0.28)),
              width: 2.2,
            ),
          ),
          child: Column(
            children: [
              if (q.imagePath != null && q.imageCropRect != null) ...[
                CroppedIllustrationBox(
                  imagePath: q.imagePath!,
                  cropRect: q.imageCropRect!,
                  width: imgSize,
                  height: imgSize,
                  borderRadius: 18,
                  borderColor: q.accentColor.withValues(alpha: 0.2),
                ),
                const SizedBox(height: 12),
              ],
              // خانات الإجابة (اضغط على الخانة لإزالة العنصر)
              Wrap(
                alignment: WrapAlignment.center,
                spacing: isCompact ? 6 : 10,
                runSpacing: 8,
                children: List.generate(slotsCount, (slotIdx) {
                  final filled = slotIdx < _assembledIndices.length;
                  final text = filled
                      ? q.sequenceItems[_assembledIndices[slotIdx]]
                      : '${slotIdx + 1}';

                  return GestureDetector(
                    onTap: filled ? () => _removeAssembledSlot(slotIdx) : null,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      constraints: BoxConstraints(
                        minWidth: isSentence ? (isCompact ? 76 : 96) : (isCompact ? 50 : 62),
                        minHeight: isCompact ? 48 : 58,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: isSentence ? 14 : 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _solved
                            ? const Color(0xFF16A34A)
                            : (_sequenceWrongFlash
                                ? const Color(0xFFFEE2E2)
                                : (filled
                                    ? q.accentColor.withValues(alpha: 0.12)
                                    : const Color(0xFFF8FAFC))),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _solved
                              ? const Color(0xFF15803D)
                              : (_sequenceWrongFlash
                                  ? const Color(0xFFEF4444)
                                  : (filled ? q.accentColor : const Color(0xFFCBD5E1))),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: Text(
                          text,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: isSentence
                                ? context.scaledFont(17, min: 14, max: 22)
                                : context.scaledFont(26, min: 22, max: 34),
                            fontWeight: FontWeight.w900,
                            color: _solved
                                ? Colors.white
                                : (filled ? _navy : const Color(0xFF94A3B8)),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              if (_solved && q.correctText != null) ...[
                const SizedBox(height: 10),
                Text(
                  '✨ ${q.correctText!} ✨',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: context.scaledFont(22, min: 17, max: 28),
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF15803D),
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: isCompact ? 12 : 16),

        // بطاقات الحروف أو الكلمات المبعثرة
        Wrap(
          alignment: WrapAlignment.center,
          spacing: isCompact ? 8 : 12,
          runSpacing: isCompact ? 8 : 12,
          children: List.generate(q.sequenceItems.length, (idx) {
            final used = _assembledIndices.contains(idx);
            return Opacity(
              opacity: used ? 0.32 : 1.0,
              child: Material(
                color: used ? const Color(0xFFE2E8F0) : Colors.white,
                borderRadius: BorderRadius.circular(18),
                elevation: used ? 0 : 2,
                shadowColor: Colors.black12,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: used ? null : () => _handleSequencePoolTap(idx),
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: isSentence ? (isCompact ? 86 : 112) : (isCompact ? 56 : 68),
                      minHeight: isCompact ? 50 : 60,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: isSentence ? 16 : 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: used ? const Color(0xFFCBD5E1) : q.accentColor,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      widthFactor: 1,
                      heightFactor: 1,
                      child: Text(
                        q.sequenceItems[idx],
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: isSentence
                              ? context.scaledFont(17, min: 14, max: 22)
                              : context.scaledFont(28, min: 22, max: 36),
                          fontWeight: FontWeight.w900,
                          color: _navy,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 10. ركّب الكلمة من الحروف المقطّعة (مثل تركيب كلمات من ثلاثة حروف.jpg)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildJoinLetters(
    BuildContext context,
    GeneratedQuestion q,
    double maxW,
    bool isCompact,
    bool isWide,
  ) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(isCompact ? 12 : 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: q.accentColor.withValues(alpha: 0.25), width: 2),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: isCompact ? 6 : 10,
            runSpacing: 8,
            children: [
              for (int i = 0; i < q.sequenceItems.length; i++) ...[
                if (i > 0)
                  Text(
                    '+',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: context.scaledFont(22, min: 18, max: 28),
                      fontWeight: FontWeight.w900,
                      color: q.accentColor,
                    ),
                  ),
                Container(
                  constraints: BoxConstraints(
                    minWidth: isCompact ? 48 : 60,
                    minHeight: isCompact ? 48 : 60,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: q.accentColor.withValues(alpha: 0.09),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: q.accentColor.withValues(alpha: 0.45), width: 1.8),
                  ),
                  child: Center(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: Text(
                      q.sequenceItems[i],
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: context.scaledFont(28, min: 22, max: 36),
                        fontWeight: FontWeight.w900,
                        color: _navy,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: isCompact ? 12 : 16),
        _buildSingleChoiceGrid(context, q, isCompact: isCompact, isWide: isWide),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 11. أكمل الحرف الناقص (في الكلمة أو تسلسل حروف الوحدة)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildMissingLetter(
    BuildContext context,
    GeneratedQuestion q,
    double maxW,
    bool isCompact,
    bool isWide,
  ) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(isCompact ? 12 : 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: q.accentColor.withValues(alpha: 0.25), width: 2),
          ),
          child: Column(
            children: [
              if (q.imagePath != null && q.imageCropRect != null) ...[
                CroppedIllustrationBox(
                  imagePath: q.imagePath!,
                  cropRect: q.imageCropRect!,
                  width: isCompact ? 86 : 112,
                  height: isCompact ? 86 : 112,
                  borderRadius: 18,
                  borderColor: q.accentColor.withValues(alpha: 0.2),
                ),
                const SizedBox(height: 12),
              ],
              Wrap(
                alignment: WrapAlignment.center,
                spacing: isCompact ? 6 : 10,
                runSpacing: 8,
                children: q.sequenceItems.map((tile) {
                  final isBlank = tile.trim() == '؟';
                  return Container(
                    constraints: BoxConstraints(
                      minWidth: isCompact ? 42 : 52,
                      minHeight: isCompact ? 46 : 56,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isBlank
                          ? (_solved ? const Color(0xFFDCFCE7) : const Color(0xFFFEF3C7))
                          : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isBlank
                            ? (_solved ? const Color(0xFF16A34A) : const Color(0xFFF59E0B))
                            : const Color(0xFFCBD5E1),
                        width: isBlank ? 2.4 : 1.5,
                      ),
                    ),
                    child: Center(
                      widthFactor: 1,
                      heightFactor: 1,
                      child: Text(
                        isBlank && _solved ? (q.correctText ?? tile) : tile,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: context.scaledFont(24, min: 19, max: 32),
                          fontWeight: FontWeight.w900,
                          color: isBlank
                              ? (_solved ? const Color(0xFF15803D) : const Color(0xFFD97706))
                              : _navy,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        SizedBox(height: isCompact ? 12 : 16),
        _buildSingleChoiceGrid(context, q, isCompact: isCompact, isWide: isWide),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 13. التتبع الحركي بأسلوب Kiwii / Montessori داخل العيادة العلاجية
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildTracingDrill(
    BuildContext context,
    GeneratedQuestion q,
    double maxW,
    bool isCompact,
  ) {
    final canvasH = isCompact ? 260.0 : (maxW >= 600 ? 360.0 : 300.0);
    return Container(
      width: double.infinity,
      height: canvasH,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: q.accentColor.withValues(alpha: 0.3), width: 2),
      ),
      child: ArabicLetterTracingCanvas(
        key: ValueKey('remedial_trace_${q.id}'),
        letterChar: q.letter,
        position: q.tracingPosition ?? 'isolated',
        exampleWord: q.secondaryPrompt ?? q.letter,
        primaryColor: q.accentColor,
        compactChrome: true,
        onComplete: () {
          if (!_solved) {
            setState(() => _solved = true);
            widget.onAttempt(isCorrect: true);
            widget.onQuestionSolved();
          }
        },
      ),
    );
  }

  // ── شبكة الخيارات القياسية المتجاوبة (2×2 على الهواتف، 4×1 أو 2×2 على التابلت) ──
  Widget _buildSingleChoiceGrid(
    BuildContext context,
    GeneratedQuestion q, {
    required bool isCompact,
    required bool isWide,
  }) {
    final cols = (isWide && q.choices.length == 4) ? 4 : 2;
    final gap = isCompact ? 10.0 : 14.0;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: q.choices.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        crossAxisSpacing: gap,
        mainAxisSpacing: gap,
        childAspectRatio: isCompact ? 1.45 : (isWide ? 1.25 : 1.55),
      ),
      itemBuilder: (context, index) {
        final c = q.choices[index];
        final isCorrectSelected = _solved && c.isCorrect;
        final isWrong = _wrongChoiceIds.contains(c.id);
        final isChosenWrong = _selectedChoiceId == c.id && !c.isCorrect;

        return _ChoiceCardTile(
          label: c.label,
          sublabel: c.sublabel,
          isSelectedCorrect: isCorrectSelected,
          isSelectedWrong: isWrong || isChosenWrong,
          accent: c.accentColor ?? q.accentColor,
          compact: isCompact,
          onTap: () => _handleSingleChoiceTap(c),
        );
      },
    );
  }
}

class _ChoiceCardTile extends StatelessWidget {
  final String label;
  final String? sublabel;
  final bool isSelectedCorrect;
  final bool isSelectedWrong;
  final Color accent;
  final bool compact;
  final double? minHeight;
  final VoidCallback onTap;

  const _ChoiceCardTile({
    required this.label,
    this.sublabel,
    required this.isSelectedCorrect,
    required this.isSelectedWrong,
    required this.accent,
    required this.compact,
    this.minHeight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = Colors.white;
    Color border = const Color(0xFFCBD5E1);
    Color fg = const Color(0xFF1B2A4A);

    if (isSelectedCorrect) {
      bg = const Color(0xFF16A34A);
      border = const Color(0xFF15803D);
      fg = Colors.white;
    } else if (isSelectedWrong) {
      bg = const Color(0xFFFEE2E2);
      border = const Color(0xFFEF4444);
      fg = const Color(0xFFB91C1C);
    }

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(20),
      elevation: isSelectedCorrect ? 3 : 1,
      shadowColor: Colors.black12,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          constraints: minHeight != null ? BoxConstraints(minHeight: minHeight!) : null,
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 8 : 12,
            vertical: compact ? 8 : 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelectedCorrect || isSelectedWrong
                  ? border
                  : accent.withValues(alpha: 0.35),
              width: isSelectedCorrect || isSelectedWrong ? 2.5 : 1.8,
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: context.scaledFont(28, min: 20, max: 38),
                      fontWeight: FontWeight.w900,
                      color: fg,
                    ),
                  ),
                ),
              ),
              if (sublabel != null && sublabel!.isNotEmpty) ...[
                const SizedBox(height: 2),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    sublabel!,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: context.scaledFont(12.5, min: 10.5, max: 15),
                      fontWeight: FontWeight.w700,
                      color: isSelectedCorrect
                          ? Colors.white.withValues(alpha: 0.92)
                          : const Color(0xFF64748B),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
