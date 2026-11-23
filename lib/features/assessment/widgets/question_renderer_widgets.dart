import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faseeh_kids/core/utils/responsive.dart';
import 'package:faseeh_kids/features/assessment/models/assessment_models.dart';
import 'package:faseeh_kids/features/assessment/widgets/cropped_illustration_box.dart';
import 'package:faseeh_kids/features/assessment/widgets/playful_design_kit.dart';
import 'package:faseeh_kids/features/lessons/widgets/arabic_letter_tracing_canvas.dart';

/// عارض تفاعلي عالمي المستوى لجميع أنواع التمارين الـ ١٣
/// يجمع بين: رفيقنا «صقر فصيح» المتفاعل، وبطاقات ثلاثية الأبعاد ملموسة بأسلوب Duolingo ABC،
/// وتوزيع بصري متوازن من أصغر الهواتف القديمة (320×533) حتى أكبر التابلت (960×1600)
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
  bool _solved = false;
  bool _hadWrongAttempt = false;
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
    _hadWrongAttempt = false;
    _selectedChoiceId = null;
    _wrongChoiceIds.clear();
    _foundTargetIds.clear();
    _assembledIndices.clear();
    _sequenceWrongFlash = false;
  }

  FalconMood get _falconMood {
    if (_solved) return FalconMood.celebrating;
    if (_hadWrongAttempt) return FalconMood.encouraging;
    return FalconMood.thinking;
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
        _hadWrongAttempt = true;
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
    if (_foundTargetIds.contains(choice.id) ||
        _wrongChoiceIds.contains(choice.id)) {
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
        _hadWrongAttempt = true;
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
        setState(() {
          _hadWrongAttempt = true;
          _sequenceWrongFlash = true;
        });
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
            // ── فقاعة صقر فصيح المتفاعلة مع التوجيه الصوتي ──
            FalconCompanionBubble(
              mood: _falconMood,
              badgeAr: _solved
                  ? 'أَحْسَنْتَ يَا بَطَلُ! 🌟'
                  : (_hadWrongAttempt
                      ? 'قَرِيبٌ جِدًّا! جَرِّبْ مَرَّةً أُخْرَى 💪'
                      : q.promptBadgeAr),
              messageAr: q.instructionAr,
              accent: _solved ? PlayfulPalette.emerald : q.accentColor,
              onTapAudio: () => widget.onPlayAudio(q.audioPath),
            ),
            SizedBox(height: isCompact ? 14 : (isWide ? 22 : 18)),

            // ── المسرح التفاعلي لكل تمرين (١٣ نوعاً) ──
            _buildExerciseContent(context, q, maxW, isCompact, isWide),
          ],
        );
      },
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
          isWide,
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
          isWide,
          isSentence: true,
        );
      case ExerciseType.tracingDrill:
        return _buildTracingDrill(context, q, maxW, isCompact, isWide);
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 1. شبكة البحث والتلوين (مكعبات ملونة تتحول لنجوم ذهبية عند الاصطياد!)
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
    final cols = isCompact ? 3 : 4;
    final gap = isCompact ? 10.0 : 14.0;

    return Column(
      children: [
        // شريط الهدف والنجوم
        Juicy3DCard(
          color: Colors.white,
          borderColor: q.accentColor.withValues(alpha: 0.45),
          lipColor: q.accentColor.withValues(alpha: 0.25),
          radius: 24,
          lipDepth: 5,
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? 14 : 22,
            vertical: isCompact ? 10 : 14,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: isCompact ? 54 : (isWide ? 74 : 62),
                height: isCompact ? 54 : (isWide ? 74 : 62),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      q.accentColor,
                      PlayfulPalette.darken(q.accentColor, 0.12),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: q.accentColor.withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      q.displayPrompt ?? q.letter,
                      style: TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontSize: isCompact ? 28 : (isWide ? 40 : 34),
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: isCompact ? 12 : 18),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تَمَّ اصْطِيَادُ $found مِنْ $totalTargets',
                      style: TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontSize: context.scaledFont(17, min: 14, max: 22),
                        fontWeight: FontWeight.w900,
                        color: PlayfulPalette.ink,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      children: List.generate(
                        totalTargets,
                        (i) => Icon(
                          i < found ? Icons.star_rounded : Icons.star_border_rounded,
                          color: i < found
                              ? const Color(0xFFF59E0B)
                              : const Color(0xFFCBD5E1),
                          size: isCompact ? 24 : 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: isCompact ? 14 : 20),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: q.choices.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: gap,
            mainAxisSpacing: gap,
            childAspectRatio: isCompact ? 1.12 : (isWide ? 1.25 : 1.15),
          ),
          itemBuilder: (context, index) {
            final c = q.choices[index];
            final isFound = _foundTargetIds.contains(c.id);
            final isWrong = _wrongChoiceIds.contains(c.id);

            return _ToyBlockChoiceTile(
              label: c.label,
              isSelectedCorrect: isFound,
              isSelectedWrong: isWrong,
              accent: PlayfulPalette.blockColorForIndex(index),
              compact: isCompact,
              isWide: isWide,
              showStarBadge: isFound,
              onTap: () => _handleMultiFindTap(c),
            );
          },
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 2. صل الحرف بالدائرة المركزية (ميدالية ذهبية + بطاقات لمسية ملونة)
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
    final centerSize = isCompact ? 92.0 : (isWide ? 136.0 : 112.0);
    final thumbSize = isCompact ? 76.0 : (isWide ? 124.0 : 94.0);

    return Column(
      children: [
        Juicy3DCard(
          color: Colors.white,
          borderColor: q.accentColor.withValues(alpha: 0.45),
          lipColor: q.accentColor.withValues(alpha: 0.25),
          radius: 28,
          lipDepth: 6,
          padding: EdgeInsets.all(isCompact ? 14 : 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (q.imagePath != null && q.imageCropRect != null) ...[
                CroppedIllustrationBox(
                  imagePath: q.imagePath!,
                  cropRect: q.imageCropRect!,
                  width: thumbSize,
                  height: thumbSize,
                  borderRadius: 20,
                  borderColor: q.accentColor.withValues(alpha: 0.25),
                ),
                SizedBox(width: isCompact ? 12 : 24),
              ],
              Container(
                width: centerSize,
                height: centerSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      q.accentColor.withValues(alpha: 0.18),
                      q.accentColor.withValues(alpha: 0.06),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: q.accentColor, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: q.accentColor.withValues(alpha: 0.2),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      q.displayPrompt ?? q.letter,
                      style: TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontSize: isCompact ? 42 : (isWide ? 64 : 52),
                        fontWeight: FontWeight.w900,
                        color: q.accentColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: isCompact ? 10 : 22),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (q.secondaryPrompt != null)
                      Text(
                        q.secondaryPrompt!,
                        style: TextStyle(
                          fontFamily: 'NotoNaskhArabic',
                          fontSize: context.scaledFont(19, min: 15, max: 25),
                          fontWeight: FontWeight.w900,
                          color: PlayfulPalette.ink,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      children: List.generate(
                        totalTargets,
                        (i) => Container(
                          width: isCompact ? 26 : 32,
                          height: isCompact ? 26 : 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: i < found
                                ? PlayfulPalette.emerald
                                : const Color(0xFFF1F5F9),
                            border: Border.all(
                              color: i < found
                                  ? PlayfulPalette.emeraldDeep
                                  : q.accentColor,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            i < found ? Icons.star_rounded : Icons.circle_outlined,
                            size: isCompact ? 16 : 19,
                            color: i < found
                                ? Colors.white
                                : q.accentColor.withValues(alpha: 0.45),
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
        SizedBox(height: isCompact ? 14 : 20),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: q.choices.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: isCompact ? 8 : 14,
            mainAxisSpacing: isCompact ? 8 : 14,
            childAspectRatio: isCompact ? 1.0 : 1.18,
          ),
          itemBuilder: (context, index) {
            final c = q.choices[index];
            final isFound = _foundTargetIds.contains(c.id);
            final isWrong = _wrongChoiceIds.contains(c.id);
            return _ToyBlockChoiceTile(
              label: c.label,
              isSelectedCorrect: isFound,
              isSelectedWrong: isWrong,
              accent: PlayfulPalette.blockColorForIndex(index),
              compact: isCompact,
              isWide: isWide,
              showStarBadge: isFound,
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
    final imgSize = isCompact ? 82.0 : (isWide ? 148.0 : 108.0);
    return Column(
      children: [
        Juicy3DCard(
          color: const Color(0xFFF5F3FF),
          borderColor: PlayfulPalette.grape.withValues(alpha: 0.55),
          lipColor: PlayfulPalette.grape.withValues(alpha: 0.30),
          radius: 26,
          lipDepth: 6,
          padding: EdgeInsets.all(isCompact ? 14 : 22),
          child: Row(
            children: [
              if (q.imagePath != null && q.imageCropRect != null) ...[
                CroppedIllustrationBox(
                  imagePath: q.imagePath!,
                  cropRect: q.imageCropRect!,
                  width: imgSize,
                  height: imgSize,
                  borderRadius: 20,
                  borderColor: PlayfulPalette.grape.withValues(alpha: 0.3),
                ),
                SizedBox(width: isCompact ? 12 : 20),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: q.imagePath == null
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      q.displayPrompt ?? '',
                      textAlign: q.imagePath == null
                          ? TextAlign.center
                          : TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontSize: context.scaledFont(19, min: 15, max: 26),
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF4C1D95),
                        height: 1.4,
                      ),
                    ),
                    if (q.secondaryPrompt != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          q.secondaryPrompt!,
                          style: TextStyle(
                            fontFamily: 'NotoNaskhArabic',
                            fontSize: context.scaledFont(16, min: 13, max: 20),
                            fontWeight: FontWeight.w800,
                            color: PlayfulPalette.grapeDeep,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: isCompact ? 14 : 22),
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
    final gap = isCompact ? 10.0 : 16.0;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: q.choices.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isWide && !hasImages ? 4 : 2,
        crossAxisSpacing: gap,
        mainAxisSpacing: gap,
        childAspectRatio: hasImages
            ? (isCompact ? 0.94 : (isWide ? 1.15 : 1.02))
            : (isCompact ? 1.25 : 1.35),
      ),
      itemBuilder: (context, index) {
        final c = q.choices[index];
        final isCorrectSelected = _solved && c.isCorrect;
        final isWrong = _wrongChoiceIds.contains(c.id);
        final cardAccent = PlayfulPalette.blockColorForIndex(index);

        if (hasImages && c.imagePath != null && c.imageCropRect != null) {
          return GestureDetector(
            onTap: () => _handleSingleChoiceTap(c),
            child: Juicy3DCard(
              color: isCorrectSelected
                  ? const Color(0xFFDCFCE7)
                  : (isWrong ? const Color(0xFFFEE2E2) : Colors.white),
              borderColor: isCorrectSelected
                  ? PlayfulPalette.emerald
                  : (isWrong ? PlayfulPalette.coral : cardAccent.withValues(alpha: 0.6)),
              lipColor: isCorrectSelected
                  ? PlayfulPalette.emeraldDeep
                  : (isWrong ? PlayfulPalette.coralDeep : cardAccent.withValues(alpha: 0.35)),
              radius: 24,
              lipDepth: 5,
              padding: EdgeInsets.all(isCompact ? 8 : 14),
              child: Column(
                children: [
                  Expanded(
                    child: CroppedIllustrationBox(
                      imagePath: c.imagePath!,
                      cropRect: c.imageCropRect!,
                      width: double.infinity,
                      borderRadius: 16,
                      borderColor: Colors.transparent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      c.label,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontSize: context.scaledFont(17, min: 14, max: 22),
                        fontWeight: FontWeight.w900,
                        color: PlayfulPalette.ink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return _ToyBlockChoiceTile(
          label: c.label,
          isSelectedCorrect: isCorrectSelected,
          isSelectedWrong: isWrong,
          accent: cardAccent,
          compact: isCompact,
          isWide: isWide,
          onTap: () => _handleSingleChoiceTap(c),
        );
      },
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 5. الشكل المتصل والمنفصل
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
        Juicy3DCard(
          color: Colors.white,
          borderColor: q.accentColor.withValues(alpha: 0.45),
          lipColor: q.accentColor.withValues(alpha: 0.25),
          radius: 28,
          lipDepth: 6,
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? 14 : 24,
            vertical: isCompact ? 16 : 28,
          ),
          child: Column(
            children: [
              if (q.imagePath != null && q.imageCropRect != null) ...[
                CroppedIllustrationBox(
                  imagePath: q.imagePath!,
                  cropRect: q.imageCropRect!,
                  width: isCompact ? 90 : (isWide ? 156 : 118),
                  height: isCompact ? 90 : (isWide ? 156 : 118),
                  borderRadius: 20,
                  borderColor: q.accentColor.withValues(alpha: 0.25),
                ),
                const SizedBox(height: 14),
              ],
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  q.displayPrompt ?? '',
                  style: TextStyle(
                    fontFamily: 'NotoNaskhArabic',
                    fontSize: context.scaledFont(38, min: 26, max: 52),
                    fontWeight: FontWeight.w900,
                    color: PlayfulPalette.ink,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              if (_solved && q.secondaryPrompt != null) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: PlayfulPalette.emerald.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'الْكَلِمَةُ الصَّحِيحَةُ: ${q.secondaryPrompt}',
                    style: TextStyle(
                      fontFamily: 'NotoNaskhArabic',
                      fontSize: context.scaledFont(16, min: 13.5, max: 21),
                      fontWeight: FontWeight.w900,
                      color: PlayfulPalette.emeraldDeep,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: isCompact ? 14 : 22),
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
    final isWide = maxW >= 540;
    return Column(
      children: [
        Juicy3DCard(
          color: Colors.white,
          borderColor: q.accentColor.withValues(alpha: 0.45),
          lipColor: q.accentColor.withValues(alpha: 0.25),
          radius: 28,
          lipDepth: 6,
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? 14 : 24,
            vertical: isCompact ? 16 : 28,
          ),
          child: Column(
            children: [
              if (q.imagePath != null && q.imageCropRect != null) ...[
                CroppedIllustrationBox(
                  imagePath: q.imagePath!,
                  cropRect: q.imageCropRect!,
                  width: isCompact ? 92 : (isWide ? 156 : 118),
                  height: isCompact ? 92 : (isWide ? 156 : 118),
                  borderRadius: 20,
                  borderColor: q.accentColor.withValues(alpha: 0.25),
                ),
                const SizedBox(height: 12),
              ],
              if (q.secondaryPrompt != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                  decoration: BoxDecoration(
                    color: q.accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'الْحَرْفُ الْمَطْلُوبُ: (${q.secondaryPrompt})',
                    style: TextStyle(
                      fontFamily: 'NotoNaskhArabic',
                      fontSize: context.scaledFont(16, min: 13.5, max: 20),
                      fontWeight: FontWeight.w900,
                      color: PlayfulPalette.darken(q.accentColor, 0.12),
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  q.displayPrompt ?? '',
                  style: TextStyle(
                    fontFamily: 'NotoNaskhArabic',
                    fontSize: context.scaledFont(52, min: 36, max: 68),
                    fontWeight: FontWeight.w700,
                    color: PlayfulPalette.ink,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: isCompact ? 14 : 22),
        if (maxW >= 460)
          Row(
            children: [
              for (int i = 0; i < q.choices.length; i++) ...[
                if (i > 0) const SizedBox(width: 12),
                Expanded(
                  child: _PositionChoiceTile(
                    label: q.choices[i].label,
                    activeSlotIndex: int.tryParse(q.choices[i].sublabel ?? '') ?? i,
                    isSelectedCorrect: _solved && q.choices[i].isCorrect,
                    isSelectedWrong: _wrongChoiceIds.contains(q.choices[i].id),
                    accent: q.choices[i].accentColor ?? PlayfulPalette.ocean,
                    compact: isCompact,
                    isWide: isWide,
                    minHeight: isWide ? 128 : 104,
                    onTap: () => _handleSingleChoiceTap(q.choices[i]),
                  ),
                ),
              ],
            ],
          )
        else
          Column(
            children: [
              for (int i = 0; i < q.choices.length; i++) ...[
                if (i > 0) const SizedBox(height: 10),
                _PositionChoiceTile(
                  label: q.choices[i].label,
                  activeSlotIndex: int.tryParse(q.choices[i].sublabel ?? '') ?? i,
                  isSelectedCorrect: _solved && q.choices[i].isCorrect,
                  isSelectedWrong: _wrongChoiceIds.contains(q.choices[i].id),
                  accent: q.choices[i].accentColor ?? PlayfulPalette.ocean,
                  compact: isCompact,
                  isWide: false,
                  minHeight: 76,
                  onTap: () => _handleSingleChoiceTap(q.choices[i]),
                ),
              ],
            ],
          ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 7. اختر الحركة المناسبة (مسرح صوتي + صورة مطابقة تماماً + ٣ مكعبات ملونة)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildChooseHaraka(
    BuildContext context,
    GeneratedQuestion q,
    double maxW,
    bool isCompact,
    bool isWide,
  ) {
    final imgSize = isCompact ? 114.0 : (isWide ? 210.0 : 156.0);
    return Column(
      children: [
        GestureDetector(
          onTap: () => widget.onPlayAudio(q.audioPath),
          child: Juicy3DCard(
            color: Colors.white,
            borderColor: q.accentColor.withValues(alpha: 0.45),
            lipColor: q.accentColor.withValues(alpha: 0.25),
            radius: 28,
            lipDepth: 6,
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? 14 : 26,
              vertical: isCompact ? 16 : 26,
            ),
            child: Column(
              children: [
                if (q.imagePath != null && q.imageCropRect != null) ...[
                  CroppedIllustrationBox(
                    imagePath: q.imagePath!,
                    cropRect: q.imageCropRect!,
                    width: imgSize,
                    height: imgSize,
                    borderRadius: 22,
                    borderColor: q.accentColor.withValues(alpha: 0.22),
                  ),
                  const SizedBox(height: 14),
                ] else ...[
                  Container(
                    width: isCompact ? 68 : 88,
                    height: isCompact ? 68 : 88,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          q.accentColor,
                          PlayfulPalette.darken(q.accentColor, 0.14),
                        ],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: q.accentColor.withValues(alpha: 0.35),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.graphic_eq_rounded,
                      color: Colors.white,
                      size: isCompact ? 34 : 44,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                if (q.displayPrompt != null)
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _solved
                          ? (q.secondaryPrompt ?? q.displayPrompt!)
                          : q.displayPrompt!,
                      style: TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontSize: context.scaledFont(40, min: 28, max: 54),
                        fontWeight: FontWeight.w900,
                        color: _solved
                            ? PlayfulPalette.emeraldDeep
                            : PlayfulPalette.ink,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: isCompact ? 14 : 22),
        Row(
          children: [
            for (int i = 0; i < q.choices.length; i++) ...[
              if (i > 0) SizedBox(width: isCompact ? 10 : 14),
              Expanded(
                child: _ToyBlockChoiceTile(
                  label: q.choices[i].label,
                  sublabel: q.choices[i].sublabel,
                  isSelectedCorrect: _solved && q.choices[i].isCorrect,
                  isSelectedWrong: _wrongChoiceIds.contains(q.choices[i].id),
                  accent: q.choices[i].accentColor ?? q.accentColor,
                  compact: isCompact,
                  isWide: isWide,
                  minHeight: isCompact ? 92 : (isWide ? 138 : 112),
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
  // 8. صل الصورة بحرفها الأول (إطار بولارويد مبهج + ٤ مكعبات ملونة)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildMatchPicture(
    BuildContext context,
    GeneratedQuestion q,
    double maxW,
    bool isCompact,
    bool isWide,
  ) {
    final imgSize = isCompact ? 132.0 : (isWide ? 240.0 : 178.0);
    return Column(
      children: [
        GestureDetector(
          onTap: () => widget.onPlayAudio(q.audioPath),
          child: Juicy3DCard(
            color: Colors.white,
            borderColor: q.accentColor.withValues(alpha: 0.45),
            lipColor: q.accentColor.withValues(alpha: 0.25),
            radius: 30,
            lipDepth: 6,
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? 14 : 26,
              vertical: isCompact ? 16 : 26,
            ),
            child: Column(
              children: [
                if (q.imagePath != null && q.imageCropRect != null)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBEB),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFFFDE68A),
                        width: 2,
                      ),
                    ),
                    child: CroppedIllustrationBox(
                      imagePath: q.imagePath!,
                      cropRect: q.imageCropRect!,
                      width: imgSize,
                      height: imgSize,
                      borderRadius: 20,
                      borderColor: Colors.transparent,
                    ),
                  ),
                const SizedBox(height: 12),
                if (q.displayPrompt != null || _solved)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _solved
                          ? const Color(0xFFDCFCE7)
                          : q.accentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      q.secondaryPrompt ?? q.displayPrompt ?? '',
                      style: TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontSize: context.scaledFont(26, min: 20, max: 34),
                        fontWeight: FontWeight.w900,
                        color: _solved
                            ? PlayfulPalette.emeraldDeep
                            : PlayfulPalette.ink,
                      ),
                    ),
                  )
                else
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.touch_app_rounded,
                        size: 18,
                        color: q.accentColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'اضْغَطْ عَلَى الصُّورَةِ لِسَمَاعِ اسْمِهَا',
                        style: TextStyle(
                          fontFamily: 'NotoNaskhArabic',
                          fontSize: context.scaledFont(13.5, min: 11.5, max: 16),
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: isCompact ? 16 : 24),
        _buildSingleChoiceGrid(context, q, isCompact: isCompact, isWide: isWide),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 9 & 12. ترتيب حروف الكلمة / تكوين الجملة (بطاقات أفقية ثلاثية الأبعاد)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSequenceAssembler(
    BuildContext context,
    GeneratedQuestion q,
    double maxW,
    bool isCompact,
    bool isWide, {
    required bool isSentence,
  }) {
    final slotsCount = q.correctSequence.length;
    final imgSize = isCompact ? 96.0 : (isWide ? 164.0 : 126.0);

    return Column(
      children: [
        Juicy3DCard(
          color: Colors.white,
          borderColor: _solved
              ? PlayfulPalette.emerald
              : (_sequenceWrongFlash
                  ? PlayfulPalette.coral
                  : q.accentColor.withValues(alpha: 0.45)),
          lipColor: _solved
              ? PlayfulPalette.emeraldDeep
              : (_sequenceWrongFlash
                  ? PlayfulPalette.coralDeep
                  : q.accentColor.withValues(alpha: 0.25)),
          radius: 28,
          lipDepth: 6,
          padding: EdgeInsets.all(isCompact ? 14 : 22),
          child: Column(
            children: [
              if (q.imagePath != null && q.imageCropRect != null) ...[
                CroppedIllustrationBox(
                  imagePath: q.imagePath!,
                  cropRect: q.imageCropRect!,
                  width: imgSize,
                  height: imgSize,
                  borderRadius: 20,
                  borderColor: const Color(0xFFFDE68A),
                ),
                const SizedBox(height: 16),
              ],
              Wrap(
                alignment: WrapAlignment.center,
                spacing: isCompact ? 8 : 12,
                runSpacing: 10,
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
                        minWidth: isSentence
                            ? (isCompact ? 82 : 112)
                            : (isCompact ? 54 : 70),
                        minHeight: isCompact ? 52 : 66,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: isSentence ? 16 : 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: _solved
                            ? PlayfulPalette.emerald
                            : (_sequenceWrongFlash
                                ? const Color(0xFFFEE2E2)
                                : (filled
                                    ? q.accentColor.withValues(alpha: 0.14)
                                    : const Color(0xFFF8FAFC))),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: _solved
                              ? PlayfulPalette.emeraldDeep
                              : (_sequenceWrongFlash
                                  ? PlayfulPalette.coral
                                  : (filled ? q.accentColor : const Color(0xFFCBD5E1))),
                          width: 2.2,
                        ),
                      ),
                      child: Center(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: Text(
                          text,
                          style: TextStyle(
                            fontFamily: 'NotoNaskhArabic',
                            fontSize: isSentence
                                ? context.scaledFont(19, min: 15, max: 24)
                                : context.scaledFont(30, min: 24, max: 38),
                            fontWeight: FontWeight.w900,
                            color: _solved
                                ? Colors.white
                                : (filled
                                    ? PlayfulPalette.ink
                                    : const Color(0xFF94A3B8)),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              if (_solved && q.correctText != null) ...[
                const SizedBox(height: 14),
                Text(
                  '✨ ${q.correctText!} ✨',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'NotoNaskhArabic',
                    fontSize: context.scaledFont(24, min: 18, max: 32),
                    fontWeight: FontWeight.w900,
                    color: PlayfulPalette.emeraldDeep,
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: isCompact ? 16 : 24),

        // بطاقات مبعثرة ثلاثية الأبعاد
        Wrap(
          alignment: WrapAlignment.center,
          spacing: isCompact ? 10 : 14,
          runSpacing: isCompact ? 10 : 14,
          children: List.generate(q.sequenceItems.length, (idx) {
            final used = _assembledIndices.contains(idx);
            final blockColor = PlayfulPalette.blockColorForIndex(idx);
            return Opacity(
              opacity: used ? 0.30 : 1.0,
              child: GestureDetector(
                onTap: used ? null : () => _handleSequencePoolTap(idx),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  constraints: BoxConstraints(
                    minWidth: isSentence
                        ? (isCompact ? 92 : 124)
                        : (isCompact ? 62 : 78),
                    minHeight: isCompact ? 54 : 68,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: isSentence ? 18 : 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: used ? const Color(0xFFE2E8F0) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: used ? const Color(0xFFCBD5E1) : blockColor,
                      width: 2.4,
                    ),
                    boxShadow: used
                        ? null
                        : [
                            BoxShadow(
                              color: blockColor.withValues(alpha: 0.45),
                              offset: const Offset(0, 5),
                              blurRadius: 0,
                            ),
                          ],
                  ),
                  child: Center(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: Text(
                      q.sequenceItems[idx],
                      style: TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontSize: isSentence
                            ? context.scaledFont(19, min: 15, max: 24)
                            : context.scaledFont(32, min: 24, max: 40),
                        fontWeight: FontWeight.w900,
                        color: PlayfulPalette.ink,
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
  // 10. ركّب الكلمة من الحروف المقطّعة
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
        Juicy3DCard(
          color: Colors.white,
          borderColor: q.accentColor.withValues(alpha: 0.45),
          lipColor: q.accentColor.withValues(alpha: 0.25),
          radius: 28,
          lipDepth: 6,
          padding: EdgeInsets.all(isCompact ? 14 : 24),
          child: Column(
            children: [
              if (q.imagePath != null && q.imageCropRect != null) ...[
                CroppedIllustrationBox(
                  imagePath: q.imagePath!,
                  cropRect: q.imageCropRect!,
                  width: isCompact ? 92 : (isWide ? 156 : 120),
                  height: isCompact ? 92 : (isWide ? 156 : 120),
                  borderRadius: 20,
                  borderColor: const Color(0xFFFDE68A),
                ),
                const SizedBox(height: 14),
              ],
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: isCompact ? 6 : 12,
                runSpacing: 10,
                children: [
                  for (int i = 0; i < q.sequenceItems.length; i++) ...[
                    if (i > 0)
                      Text(
                        '+',
                        style: TextStyle(
                          fontFamily: 'NotoNaskhArabic',
                          fontSize: context.scaledFont(24, min: 18, max: 32),
                          fontWeight: FontWeight.w900,
                          color: q.accentColor,
                        ),
                      ),
                    Container(
                      constraints: BoxConstraints(
                        minWidth: isCompact ? 52 : 68,
                        minHeight: isCompact ? 52 : 68,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: PlayfulPalette.blockColorForIndex(i)
                            .withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: PlayfulPalette.blockColorForIndex(i),
                          width: 2.2,
                        ),
                      ),
                      child: Center(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: Text(
                          q.sequenceItems[i],
                          style: TextStyle(
                            fontFamily: 'NotoNaskhArabic',
                            fontSize: context.scaledFont(30, min: 22, max: 40),
                            fontWeight: FontWeight.w900,
                            color: PlayfulPalette.ink,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: isCompact ? 14 : 22),
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
        Juicy3DCard(
          color: Colors.white,
          borderColor: q.accentColor.withValues(alpha: 0.45),
          lipColor: q.accentColor.withValues(alpha: 0.25),
          radius: 28,
          lipDepth: 6,
          padding: EdgeInsets.all(isCompact ? 14 : 24),
          child: Column(
            children: [
              if (q.imagePath != null && q.imageCropRect != null) ...[
                CroppedIllustrationBox(
                  imagePath: q.imagePath!,
                  cropRect: q.imageCropRect!,
                  width: isCompact ? 96 : (isWide ? 168 : 124),
                  height: isCompact ? 96 : (isWide ? 168 : 124),
                  borderRadius: 20,
                  borderColor: const Color(0xFFFDE68A),
                ),
                const SizedBox(height: 16),
              ],
              Wrap(
                alignment: WrapAlignment.center,
                spacing: isCompact ? 6 : 12,
                runSpacing: 10,
                children: q.sequenceItems.map((tile) {
                  final isBlank = tile.trim() == '؟';
                  return Container(
                    constraints: BoxConstraints(
                      minWidth: isCompact ? 46 : 60,
                      minHeight: isCompact ? 50 : 64,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isBlank
                          ? (_solved
                              ? const Color(0xFFDCFCE7)
                              : const Color(0xFFFEF3C7))
                          : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isBlank
                            ? (_solved
                                ? PlayfulPalette.emerald
                                : PlayfulPalette.sunny)
                            : const Color(0xFFCBD5E1),
                        width: isBlank ? 2.8 : 1.8,
                      ),
                    ),
                    child: Center(
                      widthFactor: 1,
                      heightFactor: 1,
                      child: Text(
                        isBlank && _solved ? (q.correctText ?? tile) : tile,
                        style: TextStyle(
                          fontFamily: 'NotoNaskhArabic',
                          fontSize: context.scaledFont(28, min: 20, max: 36),
                          fontWeight: FontWeight.w900,
                          color: isBlank
                              ? (_solved
                                  ? PlayfulPalette.emeraldDeep
                                  : PlayfulPalette.sunnyDeep)
                              : PlayfulPalette.ink,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        SizedBox(height: isCompact ? 14 : 22),
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
    bool isWide,
  ) {
    final canvasH = isCompact ? 270.0 : (isWide ? 420.0 : 330.0);
    return Juicy3DCard(
      color: Colors.white,
      borderColor: q.accentColor.withValues(alpha: 0.5),
      lipColor: q.accentColor.withValues(alpha: 0.25),
      radius: 28,
      lipDepth: 6,
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        height: canvasH,
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
      ),
    );
  }

  // ── شبكة المكعبات اللمسية ثلاثية الأبعاد (٢×٢ على الهاتف، ٤×١ أو ٢×٢ مبهجة على التابلت) ──
  Widget _buildSingleChoiceGrid(
    BuildContext context,
    GeneratedQuestion q, {
    required bool isCompact,
    required bool isWide,
  }) {
    final cols = 2; // ٢×٢ كبيرة ومريحة وواضحة جداً للطفل على التابلت والهاتف وتمنع الفراغ الفارغ!
    final gap = isCompact ? 10.0 : (isWide ? 18.0 : 14.0);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: q.choices.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        crossAxisSpacing: gap,
        mainAxisSpacing: gap,
        childAspectRatio: isCompact ? 1.5 : (isWide ? 2.05 : 1.65),
      ),
      itemBuilder: (context, index) {
        final c = q.choices[index];
        final isCorrectSelected = _solved && c.isCorrect;
        final isWrong = _wrongChoiceIds.contains(c.id);
        final isChosenWrong = _selectedChoiceId == c.id && !c.isCorrect;

        return _ToyBlockChoiceTile(
          label: c.label,
          sublabel: c.sublabel,
          isSelectedCorrect: isCorrectSelected,
          isSelectedWrong: isWrong || isChosenWrong,
          accent: c.accentColor ?? PlayfulPalette.blockColorForIndex(index),
          compact: isCompact,
          isWide: isWide,
          onTap: () => _handleSingleChoiceTap(c),
        );
      },
    );
  }
}

/// مكعب اختيار لمسي ثلاثي الأبعاد (Duolingo ABC / Montessori Style) بحركة ضغط حقيقية!
class _ToyBlockChoiceTile extends StatefulWidget {
  final String label;
  final String? sublabel;
  final bool isSelectedCorrect;
  final bool isSelectedWrong;
  final Color accent;
  final bool compact;
  final bool isWide;
  final double? minHeight;
  final bool showStarBadge;
  final VoidCallback onTap;

  const _ToyBlockChoiceTile({
    required this.label,
    this.sublabel,
    required this.isSelectedCorrect,
    required this.isSelectedWrong,
    required this.accent,
    required this.compact,
    required this.isWide,
    this.minHeight,
    this.showStarBadge = false,
    required this.onTap,
  });

  @override
  State<_ToyBlockChoiceTile> createState() => _ToyBlockChoiceTileState();
}

class _ToyBlockChoiceTileState extends State<_ToyBlockChoiceTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    Color bg = Color.lerp(Colors.white, widget.accent, 0.06)!;
    Color border = widget.accent.withValues(alpha: 0.78);
    Color lip = widget.accent.withValues(alpha: 0.55);
    Color fg = PlayfulPalette.darken(widget.accent, 0.24);

    if (widget.isSelectedCorrect) {
      bg = PlayfulPalette.emerald;
      border = PlayfulPalette.emeraldDeep;
      lip = PlayfulPalette.emeraldDeep;
      fg = Colors.white;
    } else if (widget.isSelectedWrong) {
      bg = const Color(0xFFFEE2E2);
      border = PlayfulPalette.coral;
      lip = PlayfulPalette.coralDeep;
      fg = const Color(0xFFB91C1C);
    }

    final lipDepth = widget.compact ? 4.0 : 6.0;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 110),
        transform: Matrix4.translationValues(0, _pressed ? lipDepth - 1.5 : 0, 0),
        constraints: widget.minHeight != null
            ? BoxConstraints(minHeight: widget.minHeight!)
            : null,
        padding: EdgeInsets.symmetric(
          horizontal: widget.compact ? 8 : 14,
          vertical: widget.compact ? 8 : 12,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(widget.compact ? 18 : 24),
          border: Border.all(color: border, width: 2.6),
          boxShadow: [
            BoxShadow(
              color: lip,
              offset: Offset(0, _pressed ? 1.5 : lipDepth),
              blurRadius: 0,
            ),
            if (!_pressed)
              BoxShadow(
                color: const Color(0xFF0F172A).withValues(alpha: 0.06),
                offset: Offset(0, lipDepth + 5),
                blurRadius: 12,
              ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // لمعة لطيفة أعلى المكعب
            Positioned(
              top: 0,
              left: 12,
              right: 12,
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: widget.isSelectedCorrect
                      ? Colors.white.withValues(alpha: 0.28)
                      : widget.accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      widget.label,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontSize: widget.isWide
                            ? context.scaledFont(54, min: 34, max: 66)
                            : context.scaledFont(38, min: 24, max: 48),
                        fontWeight: FontWeight.w900,
                        color: fg,
                      ),
                    ),
                  ),
                ),
                if (widget.sublabel != null && widget.sublabel!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      widget.sublabel!,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontSize: context.scaledFont(13.5, min: 11, max: 17),
                        fontWeight: FontWeight.w800,
                        color: widget.isSelectedCorrect
                            ? Colors.white.withValues(alpha: 0.94)
                            : const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (widget.showStarBadge || widget.isSelectedCorrect)
              const Positioned(
                top: 2,
                left: 2,
                child: Icon(
                  Icons.star_rounded,
                  color: Color(0xFFFDE047),
                  size: 22,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// بطاقة اختيار موضع الحرف في الكلمة (أول / وسط / آخر) بمؤشر بصري من ٣ خانات بدون كشف شكل الحرف
class _PositionChoiceTile extends StatefulWidget {
  final String label;
  final int activeSlotIndex; // 0 = أول (يمين)، 1 = وسط، 2 = آخر (يسار)
  final bool isSelectedCorrect;
  final bool isSelectedWrong;
  final Color accent;
  final bool compact;
  final bool isWide;
  final double minHeight;
  final VoidCallback onTap;

  const _PositionChoiceTile({
    required this.label,
    required this.activeSlotIndex,
    required this.isSelectedCorrect,
    required this.isSelectedWrong,
    required this.accent,
    required this.compact,
    required this.isWide,
    required this.minHeight,
    required this.onTap,
  });

  @override
  State<_PositionChoiceTile> createState() => _PositionChoiceTileState();
}

class _PositionChoiceTileState extends State<_PositionChoiceTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    Color bg = Color.lerp(Colors.white, widget.accent, 0.06)!;
    Color border = widget.accent.withValues(alpha: 0.78);
    Color lip = widget.accent.withValues(alpha: 0.55);
    Color fg = PlayfulPalette.darken(widget.accent, 0.24);
    Color activeSlotColor = widget.accent;

    if (widget.isSelectedCorrect) {
      bg = PlayfulPalette.emerald;
      border = PlayfulPalette.emeraldDeep;
      lip = PlayfulPalette.emeraldDeep;
      fg = Colors.white;
      activeSlotColor = Colors.white;
    } else if (widget.isSelectedWrong) {
      bg = const Color(0xFFFEE2E2);
      border = PlayfulPalette.coral;
      lip = PlayfulPalette.coralDeep;
      fg = const Color(0xFFB91C1C);
      activeSlotColor = PlayfulPalette.coral;
    }

    final lipDepth = widget.compact ? 4.0 : 6.0;
    final slotSize = widget.compact ? 18.0 : (widget.isWide ? 26.0 : 22.0);

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 110),
        transform: Matrix4.translationValues(0, _pressed ? lipDepth - 1.5 : 0, 0),
        constraints: BoxConstraints(minHeight: widget.minHeight),
        padding: EdgeInsets.symmetric(
          horizontal: widget.compact ? 10 : 14,
          vertical: widget.compact ? 10 : 14,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(widget.compact ? 18 : 24),
          border: Border.all(color: border, width: 2.6),
          boxShadow: [
            BoxShadow(
              color: lip,
              offset: Offset(0, _pressed ? 1.5 : lipDepth),
              blurRadius: 0,
            ),
            if (!_pressed)
              BoxShadow(
                color: const Color(0xFF0F172A).withValues(alpha: 0.06),
                offset: Offset(0, lipDepth + 5),
                blurRadius: 12,
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // مؤشر بصري مكاني من ٣ خانات باتجاه القراءة العربي (يمين ← وسط ← يسار)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (slot) {
                final isActive = slot == widget.activeSlotIndex;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? slotSize * 1.35 : slotSize,
                  height: slotSize,
                  decoration: BoxDecoration(
                    color: isActive
                        ? activeSlotColor
                        : (widget.isSelectedCorrect
                            ? Colors.white.withValues(alpha: 0.25)
                            : widget.accent.withValues(alpha: 0.14)),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isActive
                          ? activeSlotColor
                          : (widget.isSelectedCorrect
                              ? Colors.white.withValues(alpha: 0.55)
                              : widget.accent.withValues(alpha: 0.40)),
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: isActive
                      ? Icon(
                          Icons.star_rounded,
                          size: slotSize * 0.62,
                          color: widget.isSelectedCorrect
                              ? PlayfulPalette.emeraldDeep
                              : Colors.white,
                        )
                      : null,
                );
              }),
            ),
            SizedBox(height: widget.compact ? 8 : 12),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.label,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'NotoNaskhArabic',
                  fontSize: widget.isWide
                      ? context.scaledFont(23, min: 17, max: 28)
                      : context.scaledFont(19, min: 15, max: 24),
                  fontWeight: FontWeight.w700,
                  color: fg,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
