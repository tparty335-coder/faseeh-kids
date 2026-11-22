import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/router/app_router.dart';
import 'package:faseeh_kids/core/utils/responsive.dart';
import 'package:faseeh_kids/features/assessment/data/assessment_curriculum_data.dart';
import 'package:faseeh_kids/features/assessment/logic/assessment_provider.dart';
import 'package:faseeh_kids/features/assessment/models/assessment_models.dart';

/// مركز القياس والتقوية الذكي — ٣ أقسام متكاملة بتصميم متجاوب لكل الهواتف والتابلت:
/// 1) اختبارات قياس المستوى بعد كل ٧ حروف (٤ وحدات علمية)
/// 2) عيادة التقوية المخصوصة للتلاميذ الضعفاء (تشخيص آلي + ٥ مسارات علاجية علمية)
/// 3) محرك التوليد اللانهائي الحر (٢٨ حرفاً × ١٣ نوع تمرين بلا حدود)
class AssessmentHubScreen extends ConsumerStatefulWidget {
  final int initialTab;
  const AssessmentHubScreen({super.key, this.initialTab = 0});

  @override
  ConsumerState<AssessmentHubScreen> createState() => _AssessmentHubScreenState();
}

class _AssessmentHubScreenState extends ConsumerState<AssessmentHubScreen> {
  static const Color _navy = Color(0xFF1B2A4A);

  late int _selectedTab;
  int? _selectedUnitFilter; // null = جميع الحروف الـ ٢٨
  String? _selectedLetterFilter; // null = كل حروف الوحدة/الأبجدية
  ExerciseType? _selectedExerciseType; // null = مزيج ذكي من جميع الأنواع

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab.clamp(0, 2);
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
        backgroundColor: const Color(0xFFF6F8FC),
        body: SafeArea(
          child: Column(
            children: [
              // ── الترويسة المتجاوبة ──
              _buildHeader(context, diag, isCompact),

              // ── شريط التبويبات الـ ٣ المرن ──
              ResponsiveContentFrame(
                padding: EdgeInsets.symmetric(
                  horizontal: context.pagePaddingH,
                  vertical: isCompact ? 6 : 8,
                ),
                child: _buildSegmentedTabs(context, isCompact),
              ),

              // ── محتوى التبويب المختار ──
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: isCompact ? 6 : 10,
                    bottom: 24,
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
    );
  }

  Widget _buildHeader(
    BuildContext context,
    AssessmentDiagnosticsState diag,
    bool isCompact,
  ) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF0284C7)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(26)),
      ),
      padding: EdgeInsets.symmetric(vertical: isCompact ? 10 : 14),
      child: ResponsiveContentFrame(
        child: Row(
          children: [
            Material(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => context.canPop()
                    ? context.pop()
                    : context.go(AppRouter.homeMap),
                child: SizedBox(
                  width: isCompact ? 40 : 44,
                  height: isCompact ? 40 : 44,
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
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
                        fontFamily: 'Cairo',
                        fontSize: context.scaledFont(18.5, min: 15, max: 24),
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    'قِيَاسُ الْمُسْتَوَى بَعْدَ كُلِّ ٧ حُرُوفٍ • خُطَّةٌ عِلَاجِيَّةٌ • تَوْلِيدٌ لَانِهَائِيٌّ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: context.scaledFont(11.5, min: 10, max: 14),
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
            if (!isCompact) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  '${diag.unitResults.length}/4 وَحَدَاتٍ',
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentedTabs(BuildContext context, bool isCompact) {
    final tabs = const [
      (0, 'الْوَحَدَاتُ', Icons.verified_rounded),
      (1, 'التَّقْوِيَةُ', Icons.healing_rounded),
      (2, 'لَانِهَائِيٌّ', Icons.all_inclusive_rounded),
    ];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: tabs.map((t) {
          final selected = _selectedTab == t.$1;
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
                  vertical: isCompact ? 9 : 11,
                ),
                decoration: BoxDecoration(
                  color: selected ? const Color(0xFF0284C7) : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      t.$3,
                      size: isCompact ? 16 : 19,
                      color: selected ? Colors.white : const Color(0xFF475569),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          t.$2,
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: context.scaledFont(13.5, min: 11, max: 16),
                            fontWeight: FontWeight.w900,
                            color: selected ? Colors.white : const Color(0xFF334155),
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
  // التبويب ١: اختبارات قياس المستوى بعد كل ٧ حروف (٤ وحدات علمية)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildUnitsTab(BuildContext context, AssessmentDiagnosticsState diag) {
    final isTablet = context.isTablet;
    final units = AssessmentCurriculumData.units;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // بطاقة شرح المنهج العلمي
        Container(
          padding: EdgeInsets.all(context.isSmallPhone ? 12 : 16),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFBFDBFE)),
          ),
          child: Row(
            children: [
              const Icon(Icons.school_rounded, color: Color(0xFF1D4ED8), size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'بَعْدَ كُلِّ ٧ حُرُوفٍ نَقِيسُ ٦ مَهَارَاتٍ عِلْمِيَّةً بِدِقَّةٍ (١٠ أَسْئِلَةٍ مُتَجَدِّدَةٍ)، وَنُحَدِّدُ أَيَّ حَرْفٍ أَوْ مَهَارَةٍ تَحْتَاجُ تَقْوِيَةً تِلْقَائِيًّا.',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: context.scaledFont(13, min: 11.5, max: 15.5),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E3A8A),
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.sectionGap),

        // شبكة الوحدات الأربع: عمودان بارتفاع مرن على التابلت، وعمود واحد مريح على الهواتف
        if (isTablet)
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 16.0;
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
                if (i > 0) SizedBox(height: context.sectionGap),
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

    return Container(
      padding: EdgeInsets.all(isCompact ? 14 : 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: unit.primaryColor.withValues(alpha: 0.28),
          width: 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: isCompact ? 44 : 50,
                height: isCompact ? 44 : 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [unit.primaryColor, unit.secondaryColor],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(
                  unit.badgeEmoji,
                  style: TextStyle(fontSize: isCompact ? 24 : 28),
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
                        fontFamily: 'Cairo',
                        fontSize: context.scaledFont(16.5, min: 14, max: 20),
                        fontWeight: FontWeight.w900,
                        color: _navy,
                      ),
                    ),
                    Text(
                      'اخْتِبَارُ قِيَاسٍ بَعْدَ ٧ حُرُوفٍ',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: context.scaledFont(11.5, min: 10.5, max: 14),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              if (result != null && mastery != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: mastery.color.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${mastery.badgeEmoji} ${result.percent.round()}%',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: context.scaledFont(13, min: 11.5, max: 15.5),
                      fontWeight: FontWeight.w900,
                      color: mastery.color,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // شرائط الحروف الـ ٧ في الوحدة
          Wrap(
            spacing: isCompact ? 5 : 7,
            runSpacing: 6,
            children: unit.letters.map((l) {
              final spec = AssessmentCurriculumData.letterSpec(l);
              final isWeak = result?.weakLetters.contains(l) ?? false;
              return Container(
                width: isCompact ? 32 : 38,
                height: isCompact ? 32 : 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isWeak
                      ? const Color(0xFFFEE2E2)
                      : unit.primaryColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(
                    color: isWeak
                        ? const Color(0xFFEF4444)
                        : unit.primaryColor.withValues(alpha: 0.3),
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    spec.displayChar,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: isCompact ? 16 : 19,
                      fontWeight: FontWeight.w900,
                      color: isWeak ? const Color(0xFFB91C1C) : unit.primaryColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 14),

          SizedBox(
            height: isCompact ? 44 : 48,
            child: ElevatedButton.icon(
              onPressed: () => _launchUnitExam(unit),
              style: ElevatedButton.styleFrom(
                backgroundColor: unit.primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: const Icon(Icons.play_arrow_rounded, size: 22),
              label: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  result == null
                      ? 'ابْدَأْ اخْتِبَارَ الْوَحْدَةِ (١٠ أَسْئِلَةٍ)'
                      : 'أَعِدِ الْقِيَاسَ بِأَسْئِلَةٍ جَدِيدَةٍ',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: context.scaledFont(14, min: 12, max: 16.5),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // التبويب ٢: عيادة التقوية المخصوصة للتلاميذ الضعفاء (علمية غير عشوائية)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildRemedialClinicTab(
    BuildContext context,
    AssessmentDiagnosticsState diag,
  ) {
    final prescription = diag.buildPrescription();
    final isCompact = context.isUltraCompact || context.isSmallPhone;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. بطاقة الوصفة العلاجية التشخيصية الذكية
        Container(
          padding: EdgeInsets.all(isCompact ? 14 : 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: prescription.hasDiagnosedWeaknesses
                  ? const [Color(0xFFFFF7ED), Color(0xFFFFEDD5)]
                  : const [Color(0xFFECFDF5), Color(0xFFD1FAE5)],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: prescription.hasDiagnosedWeaknesses
                  ? const Color(0xFFFB923C)
                  : const Color(0xFF34D399),
              width: 1.8,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(
                    prescription.hasDiagnosedWeaknesses
                        ? Icons.medical_services_rounded
                        : Icons.verified_user_rounded,
                    color: prescription.hasDiagnosedWeaknesses
                        ? const Color(0xFFEA580C)
                        : const Color(0xFF059669),
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      prescription.headlineAr,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: context.scaledFont(16, min: 14, max: 20),
                        fontWeight: FontWeight.w900,
                        color: _navy,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                prescription.summaryAr,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: context.scaledFont(13.5, min: 12, max: 16),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF334155),
                  height: 1.5,
                ),
              ),
              if (prescription.weakLetters.isNotEmpty) ...[
                const SizedBox(height: 12),
                SizedBox(
                  height: context.minTouchTarget,
                  child: ElevatedButton.icon(
                    onPressed: () => _launchRemedial(
                      letters: prescription.weakLetters,
                      domains: prescription.weakDomains,
                      titleAr: 'جَلْسَتُكَ الْعِلَاجِيَّةُ الْمُخَصَّصَةُ',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEA580C),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(Icons.rocket_launch_rounded),
                    label: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        prescription.hasDiagnosedWeaknesses
                            ? 'ابْدَأْ خُطَّتَكَ الْعِلَاجِيَّةَ الْمُخَصَّصَةَ الْآنَ'
                            : 'ابْدَأْ جَلْسَةَ التَّأْسِيسِ وَالتَّقْوِيَةِ',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: context.scaledFont(14.5, min: 12.5, max: 17.5),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),

        SizedBox(height: context.sectionGap + 4),

        // 2. المسارات العلاجية العلمية الستة (حسب نوع الضعف المرصود)
        Text(
          '🩺 اخْتَرْ مَسَارَ التَّقْوِيَةِ حَسَبَ نَوْعِ الضَّعْفِ:',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: context.scaledFont(15.5, min: 13.5, max: 19),
            fontWeight: FontWeight.w900,
            color: _navy,
          ),
        ),
        const SizedBox(height: 10),

        ...SkillDomain.values.map((domain) {
          final stat = diag.skillStats[domain];
          final hasStat = stat != null && stat.hasData;
          final pct = hasStat ? (stat.accuracy * 100).round() : null;
          final isWeak = stat?.isWeak ?? false;

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              padding: EdgeInsets.all(isCompact ? 12 : 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isWeak
                      ? const Color(0xFFEF4444)
                      : domain.color.withValues(alpha: 0.25),
                  width: isWeak ? 2.0 : 1.4,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: domain.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(domain.icon, color: domain.color, size: 22),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              domain.titleAr,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: context.scaledFont(15, min: 13, max: 18),
                                fontWeight: FontWeight.w900,
                                color: _navy,
                              ),
                            ),
                            Text(
                              domain.subtitleAr,
                              style: TextStyle(
                                fontFamily: 'Cairo',
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
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: (isWeak
                                    ? const Color(0xFFEF4444)
                                    : const Color(0xFF16A34A))
                                .withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            '$pct%',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 12.5,
                              fontWeight: FontWeight.w900,
                              color: isWeak
                                  ? const Color(0xFFDC2626)
                                  : const Color(0xFF15803D),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    domain.remedialAdviceAr,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: context.scaledFont(12.5, min: 11, max: 14.5),
                      color: const Color(0xFF475569),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton.icon(
                      onPressed: () => _launchRemedial(
                        letters: diag.weakLetters.isNotEmpty
                            ? diag.weakLetters
                            : AssessmentCurriculumData.allLetterChars,
                        domains: [domain],
                        titleAr: 'تَقْوِيَةٌ: ${domain.titleAr}',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: domain.color,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.fitness_center_rounded, size: 18),
                      label: Text(
                        'ابْدَأْ تَمَارِينَ التَّقْوِيَةِ',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: context.scaledFont(13, min: 11.5, max: 15),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // التبويب ٣: محرك التوليد اللانهائي الحر (٢٨ حرفاً × ١٣ نوع تمرين)
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
          title: '١. اخْتَرِ الْوَحْدَةَ أَوْ جَمِيعَ الْحُرُوفِ:',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFilterChip(
                context,
                label: 'كُلُّ الْحُرُوفِ (٢٨)',
                selected: _selectedUnitFilter == null,
                color: const Color(0xFF0284C7),
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

        SizedBox(height: context.sectionGap),

        // 2. اختيار حرف معين (أو كل الحروف)
        _buildFilterSection(
          context,
          title: '٢. اخْتَرْ حَرْفًا مُحَدَّدًا (اخْتِيَارِيٌّ):',
          child: Wrap(
            spacing: isCompact ? 6 : 8,
            runSpacing: isCompact ? 6 : 8,
            children: [
              _buildFilterChip(
                context,
                label: 'الْكُلُّ',
                selected: _selectedLetterFilter == null,
                color: const Color(0xFF0F172A),
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
                    width: isCompact ? 38 : 44,
                    height: isCompact ? 38 : 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected ? const Color(0xFF0284C7) : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected
                            ? const Color(0xFF0284C7)
                            : const Color(0xFFCBD5E1),
                        width: selected ? 2 : 1.3,
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        spec.displayChar,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: isCompact ? 18 : 21,
                          fontWeight: FontWeight.w900,
                          color: selected ? Colors.white : _navy,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: context.sectionGap),

        // 3. اختيار نوع التمرين (١٣ نوعاً أو مزيج ذكي شامل)
        _buildFilterSection(
          context,
          title: '٣. اخْتَرْ نَوْعَ التَّمْرِينِ (١٣ نَوْعًا عِلْمِيًّا):',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFilterChip(
                context,
                label: '✨ مَزِيجٌ شَامِلٌ (جَمِيعُ الْأَنْوَاعِ)',
                selected: _selectedExerciseType == null,
                color: const Color(0xFF7C3AED),
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

        SizedBox(height: context.sectionGap + 6),

        // زر الانطلاق اللانهائي الكبير
        SizedBox(
          height: context.minTouchTarget + 6,
          child: ElevatedButton.icon(
            onPressed: _launchInfinitePractice,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF16A34A),
              foregroundColor: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            icon: const Icon(Icons.auto_awesome_rounded, size: 24),
            label: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'تَوْلِيدُ جَوْلَةٍ جَدِيدَةٍ الْآنَ (لَانِهَائِيٌّ)',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: context.scaledFont(16.5, min: 14, max: 20),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterSection(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: EdgeInsets.all(context.isSmallPhone ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: context.scaledFont(14, min: 12.5, max: 17),
              fontWeight: FontWeight.w900,
              color: _navy,
            ),
          ),
          const SizedBox(height: 10),
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? color : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? color : const Color(0xFFCBD5E1),
            width: selected ? 1.8 : 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: selected ? Colors.white : color),
              const SizedBox(width: 5),
            ],
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: context.scaledFont(12.5, min: 11, max: 15),
                  fontWeight: FontWeight.w800,
                  color: selected ? Colors.white : _navy,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
