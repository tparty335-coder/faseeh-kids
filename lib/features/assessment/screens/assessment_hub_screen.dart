import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/router/app_router.dart';
import 'package:faseeh_kids/core/utils/responsive.dart';
import 'package:faseeh_kids/features/assessment/data/assessment_curriculum_data.dart';
import 'package:faseeh_kids/features/assessment/logic/assessment_provider.dart';
import 'package:faseeh_kids/features/assessment/models/assessment_models.dart';
import 'package:faseeh_kids/features/assessment/widgets/playful_design_kit.dart';

/// مركز القياس والتقوية الذكي — ٣ أقسام متكاملة بتصميم قصصي طفولي عالمي (Duolingo ABC / Montessori)
/// متجاوب بدقة من أقدم الهواتف الصغيرة (320×533) حتى أكبر التابلت (960×1600):
/// 1) اختبارات قياس المستوى بعد كل ٧ حروف (٤ وحدات علمية)
/// 2) عيادة صقر للتقوية المخصوصة للتلاميذ الضعفاء (تشخيص آلي + ٦ مسارات علاجية علمية)
/// 3) مصنع التمارين اللانهائي الحر (٢٨ حرفاً × ١٣ نوع تمرين بلا حدود)
class AssessmentHubScreen extends ConsumerStatefulWidget {
  final int initialTab;
  const AssessmentHubScreen({super.key, this.initialTab = 0});

  @override
  ConsumerState<AssessmentHubScreen> createState() =>
      _AssessmentHubScreenState();
}

class _AssessmentHubScreenState extends ConsumerState<AssessmentHubScreen> {
  late int _selectedTab;
  int? _selectedUnitFilter; // null = جميع الحروف الـ ٢٨
  String? _selectedLetterFilter; // null = كل حروف الوحدة/الأبجدية
  ExerciseType? _selectedExerciseType; // null = مزيج ذكي من جميع الأنواع

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab.clamp(0, 2);
  }

  Color get _activeTabAccent {
    switch (_selectedTab) {
      case 1:
        return const Color(0xFFF97316);
      case 2:
        return PlayfulPalette.grape;
      default:
        return PlayfulPalette.ocean;
    }
  }

  FalconMood get _headerFalconMood {
    switch (_selectedTab) {
      case 1:
        return FalconMood.encouraging;
      case 2:
        return FalconMood.celebrating;
      default:
        return FalconMood.happy;
    }
  }

  void _launchUnitExam(AssessmentUnitSpec unit) {
    HapticFeedback.mediumImpact();
    context.push(
      AppRouter.assessmentSession,
      extra: AssessmentSessionArgs(
        mode: AssessmentSessionMode.unitExam,
        unitIndex: unit.unitIndex,
        targetLetters: unit.letters,
        questionCount: 10,
        titleAr: 'اخْتِبَارُ ${unit.titleAr}',
      ),
    );
  }

  void _launchRemedial({
    required List<String> letters,
    required List<SkillDomain> domains,
    required String titleAr,
  }) {
    HapticFeedback.mediumImpact();
    context.push(
      AppRouter.assessmentSession,
      extra: AssessmentSessionArgs(
        mode: AssessmentSessionMode.remedialClinic,
        targetLetters: letters,
        targetDomains: domains,
        questionCount: 8,
        titleAr: titleAr,
      ),
    );
  }

  void _launchInfinitePractice() {
    HapticFeedback.mediumImpact();
    final letters = _selectedLetterFilter != null
        ? [_selectedLetterFilter!]
        : (_selectedUnitFilter != null
            ? AssessmentCurriculumData.unitByIndex(_selectedUnitFilter!).letters
            : <String>[]);

    final title = _selectedExerciseType != null
        ? _selectedExerciseType!.titleAr
        : (_selectedLetterFilter != null
            ? 'تَدْرِيبٌ لَانِهَائِيٌّ: ${AssessmentCurriculumData.letterSpec(_selectedLetterFilter!).nameAr}'
            : 'التَّمَارِينُ اللَّانِهَائِيَّةُ');

    context.push(
      AppRouter.assessmentSession,
      extra: AssessmentSessionArgs(
        mode: AssessmentSessionMode.infinitePractice,
        unitIndex: _selectedUnitFilter,
        targetLetters: letters,
        specificExerciseType: _selectedExerciseType,
        questionCount: 8,
        titleAr: title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final diag = ref.watch(assessmentDiagnosticsProvider);
    final isCompact = context.isUltraCompact || context.isSmallPhone;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: PlayfulPalette.skyMid,
        body: StorybookOasisBackground(
          tintAccent: _activeTabAccent,
          child: SafeArea(
            child: Column(
              children: [
                // ── الترويسة القصصية المبهجة مع رفيقنا صقر فصيح ──
                _buildHeader(context, diag, isCompact),

                // ── شريط التبويبات الـ ٣ اللمسي ثلاثي الأبعاد ──
                ResponsiveContentFrame(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.pagePaddingH,
                    vertical: isCompact ? 8 : 12,
                  ),
                  child: _buildSegmentedTabs(context, isCompact),
                ),

                // ── محتوى التبويب المختار ──
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: isCompact ? 4 : 8,
                      bottom: 28,
                    ),
                    child: ResponsiveContentFrame(
                      child: _selectedTab == 0
                          ? _buildUnitsTab(context, diag)
                          : (_selectedTab == 1
                              ? _buildRemedialClinicTab(context, diag)
                              : _buildInfiniteGeneratorTab(context)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // الترويسة القصصية المنحنية مع شخصية «صقر فصيح» وشارة الإنجاز الذهبية
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildHeader(
    BuildContext context,
    AssessmentDiagnosticsState diag,
    bool isCompact,
  ) {
    final isTablet = context.isTablet;
    final accent = _activeTabAccent;
    final darkAccent = PlayfulPalette.darken(accent, 0.20);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [darkAccent, accent],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: darkAccent.withValues(alpha: 0.40),
            offset: const Offset(0, 5),
            blurRadius: 0,
          ),
          BoxShadow(
            color: accent.withValues(alpha: 0.22),
            offset: const Offset(0, 12),
            blurRadius: 20,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        vertical: isCompact ? 10 : (isTablet ? 18 : 14),
      ),
      child: ResponsiveContentFrame(
        child: Row(
          children: [
            // زر العودة اللمسي
            Juicy3DButton(
              onPressed: () => context.canPop()
                  ? context.pop()
                  : context.go(AppRouter.homeMap),
              color: Colors.white.withValues(alpha: 0.22),
              lipColor: Colors.black.withValues(alpha: 0.18),
              foregroundColor: Colors.white,
              radius: 16,
              lipDepth: 3,
              padding: EdgeInsets.all(isCompact ? 8 : 11),
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: isCompact ? 20 : 24,
              ),
            ),
            SizedBox(width: isCompact ? 8 : 12),

            // صورة صقر فصيح في دائرة ذهبية مشرقة
            Container(
              width: isCompact ? 46 : (isTablet ? 64 : 54),
              height: isCompact ? 46 : (isTablet ? 64 : 54),
              padding: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD166), Color(0xFFFF9F1C)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipOval(
                child: Container(
                  color: Colors.white,
                  child: Image.asset(
                    _headerFalconMood.assetPath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SizedBox(width: isCompact ? 8 : 12),

            // العنوان الرئيسي والوصف
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Text(
                      'مَرْكَزُ الْقِيَاسِ وَالتَّقْوِيَةِ الذَّكِيُّ',
                      style: TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontSize: context.scaledFont(19, min: 15, max: 26),
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    'قِيَاسٌ بَعْدَ كُلِّ ٧ حُرُوفٍ • عِيَادَةُ تَقْوِيَةٍ • تَوْلِيدٌ لَانِهَائِيٌّ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'NotoNaskhArabic',
                      fontSize: context.scaledFont(12, min: 10, max: 15),
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: 0.92),
                    ),
                  ),
                ],
              ),
            ),

            if (!isCompact) ...[
              const SizedBox(width: 10),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 14 : 11,
                  vertical: isTablet ? 8 : 6,
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
                    const Icon(
                      Icons.emoji_events_rounded,
                      color: Color(0xFFD97706),
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${diag.unitResults.length}/4 وَحَدَاتٍ',
                      style: TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontSize: context.scaledFont(13, min: 11.5, max: 15.5),
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF92400E),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // شريط التبويبات اللمسي ثلاثي الأبعاد
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSegmentedTabs(BuildContext context, bool isCompact) {
    final tabs = const [
      (0, 'الْوَحَدَاتُ', Icons.verified_rounded, PlayfulPalette.ocean),
      (1, 'التَّقْوِيَةُ', Icons.healing_rounded, Color(0xFFF97316)),
      (2, 'لَانِهَائِيٌّ', Icons.all_inclusive_rounded, PlayfulPalette.grape),
    ];

    return Juicy3DCard(
      color: Colors.white,
      borderColor: const Color(0xFFCBD5E1),
      lipColor: const Color(0xFFCBD5E1),
      radius: 22,
      lipDepth: 4,
      padding: const EdgeInsets.all(5),
      child: Row(
        children: tabs.map((t) {
          final selected = _selectedTab == t.$1;
          final color = t.$4;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _selectedTab = t.$1);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: isCompact ? 4 : 10,
                  vertical: isCompact ? 9 : 12,
                ),
                decoration: BoxDecoration(
                  color: selected ? color : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: PlayfulPalette.darken(color, 0.18),
                            offset: const Offset(0, 3),
                            blurRadius: 0,
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      t.$3,
                      size: isCompact ? 16 : 20,
                      color: selected ? Colors.white : color,
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          t.$2,
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'NotoNaskhArabic',
                            fontSize:
                                context.scaledFont(14, min: 11.5, max: 17),
                            fontWeight: FontWeight.w900,
                            color: selected ? Colors.white : PlayfulPalette.ink,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // التبويب ١: اختبارات قياس المستوى بعد كل ٧ حروف (٤ جُزُر مغامرة ملونة)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildUnitsTab(
    BuildContext context,
    AssessmentDiagnosticsState diag,
  ) {
    final isTablet = context.isTablet;
    final units = AssessmentCurriculumData.units;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // فقاعة صقر الترحيبية بالمنهج العلمي
        const FalconCompanionBubble(
          mood: FalconMood.happy,
          badgeAr: 'بَوَّابَاتُ النُّجُومِ وَالْإِتْقَانِ ⭐',
          messageAr:
              'اخْتَبِرْ مَهَارَاتِكَ بَعْدَ كُلِّ ٧ حُرُوفٍ فِي ١٠ أَسْئِلَةٍ مُمْتِعَةٍ مُتَجَدِّدَةٍ، وَسَأَكْشِفُ لَكَ نِقَاطَ قُوَّتِكَ تِلْقَائِيًّا!',
          accent: PlayfulPalette.ocean,
        ),
        SizedBox(height: context.sectionGap + 4),

        // شبكة الوحدات الأربع: عمودان بارتفاع مرن على التابلت، وعمود واحد مريح على الهواتف
        if (isTablet)
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 18.0;
              final cardWidth = (constraints.maxWidth - gap) / 2;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: units
                    .map(
                      (u) => SizedBox(
                        width: cardWidth,
                        child: _buildUnitCard(
                          context,
                          u,
                          diag.unitResults[u.unitIndex],
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          )
        else
          Column(
            children: [
              for (int i = 0; i < units.length; i++) ...[
                if (i > 0) SizedBox(height: context.sectionGap + 2),
                _buildUnitCard(
                  context,
                  units[i],
                  diag.unitResults[units[i].unitIndex],
                ),
              ],
            ],
          ),
      ],
    );
  }

  Widget _buildUnitCard(
    BuildContext context,
    AssessmentUnitSpec unit,
    UnitAssessmentResult? result,
  ) {
    final isCompact = context.isUltraCompact || context.isSmallPhone;
    final mastery = result?.masteryLevel;

    return Juicy3DCard(
      color: Colors.white,
      borderColor: unit.primaryColor.withValues(alpha: 0.45),
      lipColor: PlayfulPalette.darken(unit.primaryColor, 0.08)
          .withValues(alpha: 0.45),
      radius: 26,
      lipDepth: 5.5,
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(23.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // شريط علوي متدرّج زاهٍ لكل وحدة
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isCompact ? 12 : 16,
                vertical: isCompact ? 12 : 15,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [unit.primaryColor, unit.secondaryColor],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: isCompact ? 46 : 54,
                    height: isCompact ? 46 : 54,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.14),
                          offset: const Offset(0, 3),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      unit.badgeEmoji,
                      style: TextStyle(fontSize: isCompact ? 25 : 30),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          unit.titleAr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'NotoNaskhArabic',
                            fontSize:
                                context.scaledFont(17, min: 14.5, max: 21),
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'اخْتِبَارُ قِيَاسٍ بَعْدَ ٧ حُرُوفٍ',
                          style: TextStyle(
                            fontFamily: 'NotoNaskhArabic',
                            fontSize:
                                context.scaledFont(11.5, min: 10.5, max: 14),
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withValues(alpha: 0.92),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (result != null && mastery != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        '${mastery.badgeEmoji} ${result.percent.round()}%',
                        style: TextStyle(
                          fontFamily: 'NotoNaskhArabic',
                          fontSize: context.scaledFont(13, min: 11.5, max: 15.5),
                          fontWeight: FontWeight.w900,
                          color: mastery.color,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // جسم البطاقة: مكعبات الحروف الـ ٧ في صف واحد متناسق + زر الإطلاق ثلاثي الأبعاد
            Padding(
              padding: EdgeInsets.all(isCompact ? 12 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      for (int idx = 0; idx < unit.letters.length; idx++) ...[
                        if (idx > 0) SizedBox(width: isCompact ? 4 : 6),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              final l = unit.letters[idx];
                              final spec =
                                  AssessmentCurriculumData.letterSpec(l);
                              final isWeak =
                                  result?.weakLetters.contains(l) ?? false;
                              final tileColor = isWeak
                                  ? PlayfulPalette.coral
                                  : unit.primaryColor;
                              return AspectRatio(
                                aspectRatio: 1.0,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isWeak
                                        ? const Color(0xFFFFF1F2)
                                        : tileColor.withValues(alpha: 0.11),
                                    borderRadius: BorderRadius.circular(
                                      isCompact ? 10 : 13,
                                    ),
                                    border: Border.all(
                                      color: isWeak
                                          ? PlayfulPalette.coral
                                          : tileColor.withValues(alpha: 0.42),
                                      width: 1.8,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: isWeak
                                            ? const Color(0xFFFCA5A5)
                                            : tileColor.withValues(alpha: 0.26),
                                        offset: const Offset(0, 3),
                                        blurRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        spec.displayChar,
                                        style: TextStyle(
                                          fontFamily: 'NotoNaskhArabic',
                                          fontSize: isCompact ? 16 : 21,
                                          fontWeight: FontWeight.w900,
                                          color: isWeak
                                              ? PlayfulPalette.coralDeep
                                              : PlayfulPalette.darken(
                                                  tileColor,
                                                  0.12,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                  Juicy3DButton(
                    onPressed: () => _launchUnitExam(unit),
                    color: unit.primaryColor,
                    lipColor: PlayfulPalette.darken(unit.primaryColor, 0.18),
                    radius: 18,
                    lipDepth: 4.5,
                    minHeight: isCompact ? 44 : 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.play_arrow_rounded, size: 24),
                        const SizedBox(width: 6),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              result == null
                                  ? 'ابْدَأْ اخْتِبَارَ الْوَحْدَةِ (١٠ أَسْئِلَةٍ)'
                                  : 'أَعِدِ الْقِيَاسَ بِأَسْئِلَةٍ جَدِيدَةٍ',
                              style: TextStyle(
                                fontFamily: 'NotoNaskhArabic',
                                fontSize: context.scaledFont(
                                  14.5,
                                  min: 12,
                                  max: 17,
                                ),
                                fontWeight: FontWeight.w900,
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
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // التبويب ٢: عيادة صقر للتقوية المخصوصة للتلاميذ الضعفاء
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildRemedialClinicTab(
    BuildContext context,
    AssessmentDiagnosticsState diag,
  ) {
    final prescription = diag.buildPrescription();
    final isCompact = context.isUltraCompact || context.isSmallPhone;
    final isTablet = context.isTablet;
    final accent = prescription.hasDiagnosedWeaknesses
        ? const Color(0xFFF97316)
        : PlayfulPalette.emerald;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. بطاقة الوصفة العلاجية التشخيصية مع شخصية صقر فصيح المشجّعة
        Juicy3DCard(
          color: prescription.hasDiagnosedWeaknesses
              ? const Color(0xFFFFF7ED)
              : const Color(0xFFECFDF5),
          borderColor: accent,
          lipColor: PlayfulPalette.darken(accent, 0.16),
          radius: 26,
          lipDepth: 5.5,
          padding: EdgeInsets.all(isCompact ? 14 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: isCompact ? 60 : (isTablet ? 82 : 70),
                    height: isCompact ? 60 : (isTablet ? 82 : 70),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFD166), Color(0xFFFF9F1C)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: accent.withValues(alpha: 0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Container(
                        color: Colors.white,
                        child: Image.asset(
                          prescription.hasDiagnosedWeaknesses
                              ? FalconMood.encouraging.assetPath
                              : FalconMood.celebrating.assetPath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: isCompact ? 10 : 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: accent.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            'عِيَادَةُ صَقْرٍ لِلتَّقْوِيَةِ الذَّكِيَّةِ 🩺',
                            style: TextStyle(
                              fontFamily: 'NotoNaskhArabic',
                              fontSize: context.scaledFont(
                                11.5,
                                min: 10,
                                max: 14,
                              ),
                              fontWeight: FontWeight.w900,
                              color: PlayfulPalette.darken(accent, 0.15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          prescription.headlineAr,
                          style: TextStyle(
                            fontFamily: 'NotoNaskhArabic',
                            fontSize:
                                context.scaledFont(16.5, min: 14, max: 21),
                            fontWeight: FontWeight.w900,
                            color: PlayfulPalette.ink,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                prescription.summaryAr,
                style: TextStyle(
                  fontFamily: 'NotoNaskhArabic',
                  fontSize: context.scaledFont(14, min: 12, max: 16.5),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF334155),
                  height: 1.5,
                ),
              ),
              if (prescription.weakLetters.isNotEmpty) ...[
                const SizedBox(height: 14),
                Juicy3DButton(
                  onPressed: () => _launchRemedial(
                    letters: prescription.weakLetters,
                    domains: prescription.weakDomains,
                    titleAr: 'جَلْسَتُكَ الْعِلَاجِيَّةُ الْمُخَصَّصَةُ',
                  ),
                  color: const Color(0xFFF97316),
                  lipColor: const Color(0xFFC2410C),
                  radius: 18,
                  lipDepth: 5,
                  minHeight: context.minTouchTarget,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.rocket_launch_rounded, size: 22),
                      const SizedBox(width: 8),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            prescription.hasDiagnosedWeaknesses
                                ? 'ابْدَأْ خُطَّتَكَ الْعِلَاجِيَّةَ الْمُخَصَّصَةَ الْآنَ'
                                : 'ابْدَأْ جَلْسَةَ التَّأْسِيسِ وَالتَّقْوِيَةِ',
                            style: TextStyle(
                              fontFamily: 'NotoNaskhArabic',
                              fontSize: context.scaledFont(
                                15,
                                min: 12.5,
                                max: 18,
                              ),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),

        SizedBox(height: context.sectionGap + 6),

        // 2. المسارات العلاجية العلمية الستة (حسب نوع الضعف المرصود)
        Text(
          '🩺 اخْتَرْ مَسَارَ التَّقْوِيَةِ حَسَبَ نَوْعِ الضَّعْفِ:',
          style: TextStyle(
            fontFamily: 'NotoNaskhArabic',
            fontSize: context.scaledFont(16.5, min: 13.5, max: 20),
            fontWeight: FontWeight.w900,
            color: PlayfulPalette.ink,
          ),
        ),
        const SizedBox(height: 12),

        if (isTablet)
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 16.0;
              final cardWidth = (constraints.maxWidth - gap) / 2;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: SkillDomain.values
                    .map(
                      (domain) => SizedBox(
                        width: cardWidth,
                        child: _buildDomainClinicCard(
                          context,
                          domain,
                          diag,
                          isCompact,
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          )
        else
          Column(
            children: SkillDomain.values
                .map(
                  (domain) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildDomainClinicCard(
                      context,
                      domain,
                      diag,
                      isCompact,
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  Widget _buildDomainClinicCard(
    BuildContext context,
    SkillDomain domain,
    AssessmentDiagnosticsState diag,
    bool isCompact,
  ) {
    final stat = diag.skillStats[domain];
    final hasStat = stat != null && stat.hasData;
    final pct = hasStat ? (stat.accuracy * 100).round() : null;
    final isWeak = stat?.isWeak ?? false;

    return Juicy3DCard(
      color: Colors.white,
      borderColor: isWeak
          ? PlayfulPalette.coral
          : domain.color.withValues(alpha: 0.42),
      lipColor: isWeak
          ? PlayfulPalette.coralDeep.withValues(alpha: 0.5)
          : domain.color.withValues(alpha: 0.30),
      radius: 22,
      lipDepth: 4.5,
      padding: EdgeInsets.all(isCompact ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      domain.color,
                      PlayfulPalette.darken(domain.color, 0.14),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: domain.color.withValues(alpha: 0.28),
                      offset: const Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Icon(domain.icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      domain.titleAr,
                      style: TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontSize: context.scaledFont(15.5, min: 13, max: 18.5),
                        fontWeight: FontWeight.w900,
                        color: PlayfulPalette.ink,
                      ),
                    ),
                    Text(
                      domain.subtitleAr,
                      style: TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontSize: context.scaledFont(12, min: 10.5, max: 14.5),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              if (pct != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: (isWeak
                            ? PlayfulPalette.coral
                            : PlayfulPalette.emerald)
                        .withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '$pct%',
                    style: TextStyle(
                      fontFamily: 'NotoNaskhArabic',
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: isWeak
                          ? PlayfulPalette.coralDeep
                          : PlayfulPalette.emeraldDeep,
                    ),
                  ),
                ),
            ],
          ),
          if (hasStat) ...[
            const SizedBox(height: 10),
            CandyProgressBar(
              progress: stat.accuracy,
              color: isWeak ? PlayfulPalette.coral : PlayfulPalette.emerald,
              height: 10,
            ),
          ],
          const SizedBox(height: 8),
          Text(
            domain.remedialAdviceAr,
            style: TextStyle(
              fontFamily: 'NotoNaskhArabic',
              fontSize: context.scaledFont(12.5, min: 11, max: 15),
              fontWeight: FontWeight.w600,
              color: const Color(0xFF475569),
              height: 1.42,
            ),
          ),
          const SizedBox(height: 12),
          Juicy3DButton(
            onPressed: () => _launchRemedial(
              letters: diag.weakLetters.isNotEmpty
                  ? diag.weakLetters
                  : AssessmentCurriculumData.allLetterChars,
              domains: [domain],
              titleAr: 'تَقْوِيَةٌ: ${domain.titleAr}',
            ),
            color: domain.color,
            lipColor: PlayfulPalette.darken(domain.color, 0.18),
            radius: 15,
            lipDepth: 4,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.fitness_center_rounded, size: 19),
                const SizedBox(width: 6),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'ابْدَأْ تَمَارِينَ التَّقْوِيَةِ',
                      style: TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontSize: context.scaledFont(13.5, min: 11.5, max: 15.5),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // التبويب ٣: مصنع التمارين اللانهائي الحر (٢٨ حرفاً × ١٣ نوع تمرين)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildInfiniteGeneratorTab(BuildContext context) {
    final isCompact = context.isUltraCompact || context.isSmallPhone;
    final visibleLetters = _selectedUnitFilter != null
        ? AssessmentCurriculumData.unitByIndex(_selectedUnitFilter!).letters
        : AssessmentCurriculumData.allLetterChars;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. اختيار الوحدة أو كل الحروف
        _buildFilterSection(
          context,
          stepNum: '١',
          accent: PlayfulPalette.ocean,
          title: 'اخْتَرِ الْوَحْدَةَ أَوْ جَمِيعَ الْحُرُوفِ:',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFilterChip(
                context,
                label: 'كُلُّ الْحُرُوفِ (٢٨)',
                selected: _selectedUnitFilter == null,
                color: PlayfulPalette.ocean,
                onTap: () => setState(() {
                  _selectedUnitFilter = null;
                  _selectedLetterFilter = null;
                }),
              ),
              for (final u in AssessmentCurriculumData.units)
                _buildFilterChip(
                  context,
                  label: '${u.badgeEmoji} ${u.titleAr}',
                  selected: _selectedUnitFilter == u.unitIndex,
                  color: u.primaryColor,
                  onTap: () => setState(() {
                    _selectedUnitFilter = u.unitIndex;
                    _selectedLetterFilter = null;
                  }),
                ),
            ],
          ),
        ),

        SizedBox(height: context.sectionGap + 2),

        // 2. اختيار حرف معين (أو كل الحروف)
        _buildFilterSection(
          context,
          stepNum: '٢',
          accent: const Color(0xFFF97316),
          title: 'اخْتَرْ حَرْفًا مُحَدَّدًا (اخْتِيَارِيٌّ):',
          child: Wrap(
            spacing: isCompact ? 6 : 8,
            runSpacing: isCompact ? 6 : 8,
            children: [
              _buildFilterChip(
                context,
                label: 'الْكُلُّ',
                selected: _selectedLetterFilter == null,
                color: PlayfulPalette.ink,
                onTap: () => setState(() => _selectedLetterFilter = null),
              ),
              ...visibleLetters.map((l) {
                final spec = AssessmentCurriculumData.letterSpec(l);
                final selected = _selectedLetterFilter == l;
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _selectedLetterFilter = selected ? null : l);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    width: isCompact ? 40 : 46,
                    height: isCompact ? 40 : 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected
                          ? PlayfulPalette.ocean
                          : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: selected
                            ? PlayfulPalette.oceanDeep
                            : const Color(0xFFCBD5E1),
                        width: selected ? 2.2 : 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: selected
                              ? PlayfulPalette.oceanDeep
                              : const Color(0xFFCBD5E1),
                          offset: const Offset(0, 3),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        spec.displayChar,
                        style: TextStyle(
                          fontFamily: 'NotoNaskhArabic',
                          fontSize: isCompact ? 18 : 22,
                          fontWeight: FontWeight.w900,
                          color: selected ? Colors.white : PlayfulPalette.ink,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: context.sectionGap + 2),

        // 3. اختيار نوع التمرين (١٣ نوعاً أو مزيج ذكي شامل)
        _buildFilterSection(
          context,
          stepNum: '٣',
          accent: PlayfulPalette.grape,
          title: 'اخْتَرْ نَوْعَ التَّمْرِينِ (١٣ نَوْعًا عِلْمِيًّا):',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFilterChip(
                context,
                label: '✨ مَزِيجٌ شَامِلٌ (جَمِيعُ الْأَنْوَاعِ)',
                selected: _selectedExerciseType == null,
                color: PlayfulPalette.grape,
                onTap: () => setState(() => _selectedExerciseType = null),
              ),
              ...ExerciseType.values.map(
                (t) => _buildFilterChip(
                  context,
                  label: t.titleAr,
                  icon: t.icon,
                  selected: _selectedExerciseType == t,
                  color: t.domain.color,
                  onTap: () => setState(() => _selectedExerciseType = t),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: context.sectionGap + 8),

        // زر الانطلاق اللانهائي الكبير ثلاثي الأبعاد
        Juicy3DButton(
          onPressed: _launchInfinitePractice,
          color: PlayfulPalette.emerald,
          lipColor: PlayfulPalette.emeraldDeep,
          radius: 22,
          lipDepth: 5.5,
          minHeight: context.minTouchTarget + 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.auto_awesome_rounded, size: 26),
              const SizedBox(width: 8),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'تَوْلِيدُ جَوْلَةٍ جَدِيدَةٍ الْآنَ (لَانِهَائِيٌّ)',
                    style: TextStyle(
                      fontFamily: 'NotoNaskhArabic',
                      fontSize: context.scaledFont(17, min: 14, max: 21),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterSection(
    BuildContext context, {
    required String stepNum,
    required Color accent,
    required String title,
    required Widget child,
  }) {
    return Juicy3DCard(
      color: Colors.white,
      borderColor: accent.withValues(alpha: 0.35),
      lipColor: accent.withValues(alpha: 0.24),
      radius: 24,
      lipDepth: 4.5,
      padding: EdgeInsets.all(context.isSmallPhone ? 12 : 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: PlayfulPalette.darken(accent, 0.18),
                      offset: const Offset(0, 2.5),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Text(
                  stepNum,
                  style: const TextStyle(
                    fontFamily: 'NotoNaskhArabic',
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'NotoNaskhArabic',
                    fontSize: context.scaledFont(14.5, min: 12.5, max: 18),
                    fontWeight: FontWeight.w900,
                    color: PlayfulPalette.ink,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    IconData? icon,
    required bool selected,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? color : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: selected
                ? PlayfulPalette.darken(color, 0.12)
                : const Color(0xFFCBD5E1),
            width: selected ? 2 : 1.4,
          ),
          boxShadow: [
            BoxShadow(
              color: selected
                  ? PlayfulPalette.darken(color, 0.20)
                  : const Color(0xFFCBD5E1),
              offset: const Offset(0, 3),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 17, color: selected ? Colors.white : color),
              const SizedBox(width: 6),
            ],
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'NotoNaskhArabic',
                  fontSize: context.scaledFont(13, min: 11, max: 15.5),
                  fontWeight: FontWeight.w900,
                  color: selected ? Colors.white : PlayfulPalette.ink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
