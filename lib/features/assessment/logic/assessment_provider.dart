import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:faseeh_kids/core/utils/constants.dart';
import 'package:faseeh_kids/features/assessment/data/assessment_curriculum_data.dart';
import 'package:faseeh_kids/features/assessment/models/assessment_models.dart';

/// حالة التشخيص التراكمي للطالب عبر الوحدات الأربع، الحروف الـ ٢٨، والمهارات الـ ٦
class AssessmentDiagnosticsState {
  final Map<int, UnitAssessmentResult> unitResults; // 1..4
  final Map<String, AccuracyStat> letterStats; // 'أ'..'ي'
  final Map<SkillDomain, AccuracyStat> skillStats; // 6 domains
  final int totalSessionsCompleted;
  final int totalQuestionsAnswered;
  final int remedialSessionsCompleted;

  const AssessmentDiagnosticsState({
    this.unitResults = const {},
    this.letterStats = const {},
    this.skillStats = const {},
    this.totalSessionsCompleted = 0,
    this.totalQuestionsAnswered = 0,
    this.remedialSessionsCompleted = 0,
  });

  /// استخراج الحروف التي يظهر فيها ضعف فعلي مرتّبة من الأضعف للأقوى
  List<String> get weakLetters {
    final list = letterStats.entries
        .where((e) => e.value.isWeak)
        .toList()
      ..sort((a, b) => a.value.accuracy.compareTo(b.value.accuracy));
    return list.map((e) => e.key).toList();
  }

  /// استخراج المجالات المهارية الضعيفة مرتّبة من الأضعف للأقوى
  List<SkillDomain> get weakDomains {
    final list = skillStats.entries
        .where((e) => e.value.isWeak)
        .toList()
      ..sort((a, b) => a.value.accuracy.compareTo(b.value.accuracy));
    return list.map((e) => e.key).toList();
  }

  /// بناء الوصفة العلاجية العلمية المخصصة آلياً بناءً على البيانات الحقيقية للطالب
  RemedialPrescription buildPrescription() {
    final wLetters = weakLetters;
    final wDomains = weakDomains;

    if (wLetters.isEmpty && wDomains.isEmpty) {
      if (totalQuestionsAnswered == 0) {
        return const RemedialPrescription(
          weakLetters: ['ب', 'ت', 'ث', 'ج', 'ح', 'خ'],
          weakDomains: [
            SkillDomain.similarLetters,
            SkillDomain.letterPositions,
            SkillDomain.phonicsHarakat,
          ],
          headlineAr: 'لَمْ نُجْرِ اخْتِبَارًا تَشْخِيصِيًّا بَعْدُ',
          summaryAr:
              'ابْدَأْ بِاخْتِبَارِ الْوَحْدَةِ الْأُولَى لِتَشْخِيصِ نِقَاطِ الضَّعْفِ بِدِقَّةٍ، أَوِ اخْتَرْ أَيَّ مَسَارٍ عِلَاجِيٍّ بِالْأَسْفَلِ لِلتَّقْوِيَةِ الْفَوْرِيَّةِ.',
          hasDiagnosedWeaknesses: false,
        );
      }

      return const RemedialPrescription(
        weakLetters: [],
        weakDomains: [],
        headlineAr: 'مَا شَاءَ اللَّهُ! لَا تُوجَدُ نِقَاطُ ضَعْفٍ حَالِيًّا 🌟',
        summaryAr:
            'أَدَاؤُكَ مُمْتَازٌ فِي جَمِيعِ الْمَهَارَاتِ الْمُخْتَبَرَةِ! يُمْكِنُكَ الِاسْتِمْرَارُ فِي التَّمَارِينِ اللَّانِهَائِيَّةِ لِزِيَادَةِ الطَّلَاقَةِ وَالسُّرْعَةِ.',
        hasDiagnosedWeaknesses: false,
      );
    }

    final topLettersText = wLetters
        .take(5)
        .map((l) => AssessmentCurriculumData.letterSpec(l).displayChar)
        .join(' • ');
    final topDomain = wDomains.isNotEmpty ? wDomains.first : SkillDomain.similarLetters;

    return RemedialPrescription(
      weakLetters: wLetters.take(6).toList(),
      weakDomains: wDomains.isNotEmpty ? wDomains : [SkillDomain.visualRecognition, SkillDomain.phonicsHarakat],
      headlineAr: 'خُطَّةُ تَقْوِيَةٍ عِلْمِيَّةٌ مُخَصَّصَةٌ لَكَ',
      summaryAr:
          'رَصَدْنَا حَاجَةً لِلتَّقْوِيَةِ فِي: (${topDomain.titleAr})${topLettersText.isNotEmpty ? ' وَالْحُرُوفِ: $topLettersText' : ''}. جَهَّزْنَا جَلْسَةً تَدْرِيجِيَّةً بِتَلْمِيحَاتٍ بَصَرِيَّةٍ وَصَوْتِيَّةٍ مُسَاعِدَةٍ!',
      hasDiagnosedWeaknesses: true,
    );
  }

  Map<String, dynamic> toJson() => {
        'unitResults': {
          for (final entry in unitResults.entries)
            entry.key.toString(): entry.value.toJson(),
        },
        'letterStats': {
          for (final entry in letterStats.entries)
            entry.key: entry.value.toJson(),
        },
        'skillStats': {
          for (final entry in skillStats.entries)
            entry.key.name: entry.value.toJson(),
        },
        'totalSessionsCompleted': totalSessionsCompleted,
        'totalQuestionsAnswered': totalQuestionsAnswered,
        'remedialSessionsCompleted': remedialSessionsCompleted,
      };

  factory AssessmentDiagnosticsState.fromJson(Map<String, dynamic> json) {
    final rawUnits = (json['unitResults'] as Map?) ?? const {};
    final rawLetters = (json['letterStats'] as Map?) ?? const {};
    final rawSkills = (json['skillStats'] as Map?) ?? const {};

    final units = <int, UnitAssessmentResult>{};
    for (final entry in rawUnits.entries) {
      final k = int.tryParse(entry.key.toString());
      if (k != null && entry.value is Map) {
        units[k] = UnitAssessmentResult.fromJson(
          Map<String, dynamic>.from(entry.value as Map),
        );
      }
    }

    final letters = <String, AccuracyStat>{};
    for (final entry in rawLetters.entries) {
      if (entry.value is Map) {
        letters[entry.key.toString()] = AccuracyStat.fromJson(
          Map<String, dynamic>.from(entry.value as Map),
        );
      }
    }

    final skills = <SkillDomain, AccuracyStat>{};
    for (final entry in rawSkills.entries) {
      final domain = SkillDomainMeta.fromId(entry.key.toString());
      if (domain != null && entry.value is Map) {
        skills[domain] = AccuracyStat.fromJson(
          Map<String, dynamic>.from(entry.value as Map),
        );
      }
    }

    return AssessmentDiagnosticsState(
      unitResults: units,
      letterStats: letters,
      skillStats: skills,
      totalSessionsCompleted: (json['totalSessionsCompleted'] as num?)?.toInt() ?? 0,
      totalQuestionsAnswered: (json['totalQuestionsAnswered'] as num?)?.toInt() ?? 0,
      remedialSessionsCompleted: (json['remedialSessionsCompleted'] as num?)?.toInt() ?? 0,
    );
  }
}

class AssessmentDiagnosticsNotifier extends Notifier<AssessmentDiagnosticsState> {
  static const String _storageKey = 'assessment_diagnostics_v1';

  @override
  AssessmentDiagnosticsState build() {
    return _loadFromHive();
  }

  AssessmentDiagnosticsState _loadFromHive() {
    try {
      if (Hive.isBoxOpen(AppConstants.masteryRecordBox)) {
        final raw = Hive.box(AppConstants.masteryRecordBox).get(_storageKey);
        if (raw is String && raw.isNotEmpty) {
          final decoded = jsonDecode(raw);
          if (decoded is Map<String, dynamic>) {
            return AssessmentDiagnosticsState.fromJson(decoded);
          }
        }
      }
    } catch (_) {}
    return const AssessmentDiagnosticsState();
  }

  void _saveToHive(AssessmentDiagnosticsState next) {
    try {
      if (Hive.isBoxOpen(AppConstants.masteryRecordBox)) {
        Hive.box(AppConstants.masteryRecordBox)
            .put(_storageKey, jsonEncode(next.toJson()));
      }
    } catch (_) {}
  }

  /// تسجيل نتائج جلسة كاملة (اختبار وحدة / عيادة تقوية / تدريب لا نهائي) وتحديث التشخيص العلمي
  UnitAssessmentResult recordSession({
    required AssessmentSessionMode mode,
    required List<QuestionAttemptRecord> records,
    int? unitIndex,
  }) {
    final nextLetters = Map<String, AccuracyStat>.from(state.letterStats);
    final nextSkills = Map<SkillDomain, AccuracyStat>.from(state.skillStats);

    final sessionSkillCorrect = <SkillDomain, int>{};
    final sessionSkillTotal = <SkillDomain, int>{};
    final sessionWeakLetters = <String>{};

    int correctFirstTryCount = 0;

    for (final rec in records) {
      if (rec.isCorrectFirstTry) {
        correctFirstTryCount++;
      } else {
        sessionWeakLetters.add(rec.letter);
      }

      nextLetters[rec.letter] = (nextLetters[rec.letter] ?? const AccuracyStat())
          .record(isCorrect: rec.isCorrectFirstTry);

      nextSkills[rec.domain] = (nextSkills[rec.domain] ?? const AccuracyStat())
          .record(isCorrect: rec.isCorrectFirstTry);

      sessionSkillTotal[rec.domain] = (sessionSkillTotal[rec.domain] ?? 0) + 1;
      if (rec.isCorrectFirstTry) {
        sessionSkillCorrect[rec.domain] = (sessionSkillCorrect[rec.domain] ?? 0) + 1;
      }
    }

    final sessionSkillAccuracy = <String, double>{};
    final sessionWeakDomains = <String>[];
    for (final entry in sessionSkillTotal.entries) {
      final acc = (sessionSkillCorrect[entry.key] ?? 0) / entry.value;
      sessionSkillAccuracy[entry.key.name] = acc;
      if (acc < 0.75) {
        sessionWeakDomains.add(entry.key.name);
      }
    }

    final result = UnitAssessmentResult(
      unitIndex: unitIndex ?? 1,
      correctCount: correctFirstTryCount,
      totalQuestions: records.length,
      completedAt: DateTime.now(),
      skillAccuracy: sessionSkillAccuracy,
      weakLetters: sessionWeakLetters.toList(),
      weakDomains: sessionWeakDomains,
    );

    final nextUnits = Map<int, UnitAssessmentResult>.from(state.unitResults);
    if (mode == AssessmentSessionMode.unitExam && unitIndex != null) {
      nextUnits[unitIndex] = result;
    }

    final nextState = AssessmentDiagnosticsState(
      unitResults: nextUnits,
      letterStats: nextLetters,
      skillStats: nextSkills,
      totalSessionsCompleted: state.totalSessionsCompleted + 1,
      totalQuestionsAnswered: state.totalQuestionsAnswered + records.length,
      remedialSessionsCompleted: state.remedialSessionsCompleted +
          (mode == AssessmentSessionMode.remedialClinic ? 1 : 0),
    );

    state = nextState;
    _saveToHive(nextState);
    return result;
  }

  /// إعادة ضبط سجل التقييم (لولي الأمر أو المعلم)
  void resetDiagnostics() {
    state = const AssessmentDiagnosticsState();
    _saveToHive(state);
  }
}

final assessmentDiagnosticsProvider = NotifierProvider<
    AssessmentDiagnosticsNotifier, AssessmentDiagnosticsState>(
  AssessmentDiagnosticsNotifier.new,
);
