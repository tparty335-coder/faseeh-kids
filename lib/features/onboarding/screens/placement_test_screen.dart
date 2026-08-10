import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/core/router/app_router.dart';
import 'package:faseeh_kids/core/utils/age_group.dart';
import 'package:faseeh_kids/features/onboarding/logic/placement_algorithm.dart';

/// Placement Test Screen — adaptive 10-question test
/// P4-T009
class PlacementTestScreen extends StatefulWidget {
  final AgeGroup ageGroup;
  final int avatarIndex;
  final String childName;

  const PlacementTestScreen({
    super.key,
    required this.ageGroup,
    required this.avatarIndex,
    required this.childName,
  });

  @override
  State<PlacementTestScreen> createState() => _PlacementTestScreenState();
}

class _PlacementTestScreenState extends State<PlacementTestScreen> {
  int _currentQuestion = 0;
  final List<bool> _answers = [];
  bool _showResult = false;
  PlacementResult? _result;

  // Simple placement questions (letter recognition)
  static const List<_PlacementQuestion> _questions = [
    _PlacementQuestion(
      prompt: 'أين حرف الألف؟',
      options: ['أ', 'ب', 'ت', 'ث'],
      correctIndex: 0,
      difficulty: 1,
    ),
    _PlacementQuestion(
      prompt: 'أين حرف الباء؟',
      options: ['ج', 'ب', 'ن', 'ي'],
      correctIndex: 1,
      difficulty: 1,
    ),
    _PlacementQuestion(
      prompt: 'ما هذا الحرف: سـ ؟',
      options: ['شين', 'سين', 'صاد', 'ضاد'],
      correctIndex: 1,
      difficulty: 2,
    ),
    _PlacementQuestion(
      prompt: 'أي كلمة تبدأ بحرف الميم؟',
      options: ['نحلة', 'موز', 'ليمون', 'كلب'],
      correctIndex: 1,
      difficulty: 2,
    ),
    _PlacementQuestion(
      prompt: 'ما هو صوت الحرف بَ ؟',
      options: ['تاء', 'باء بفتحة', 'نون', 'لام'],
      correctIndex: 1,
      difficulty: 3,
    ),
    _PlacementQuestion(
      prompt: 'كم حرفاً في كلمة "بَيْت"؟',
      options: ['٢', '٣', '٤', '٥'],
      correctIndex: 1,
      difficulty: 3,
    ),
    _PlacementQuestion(
      prompt: 'أي حرف فيه نقطة واحدة تحته؟',
      options: ['ت', 'ث', 'ب', 'ن'],
      correctIndex: 2,
      difficulty: 2,
    ),
    _PlacementQuestion(
      prompt: 'ما الحركة في "كُ"؟',
      options: ['فتحة', 'كسرة', 'ضمة', 'سكون'],
      correctIndex: 2,
      difficulty: 4,
    ),
    _PlacementQuestion(
      prompt: 'أي كلمة فيها مد بالألف؟',
      options: ['كتب', 'باب', 'من', 'هل'],
      correctIndex: 1,
      difficulty: 4,
    ),
    _PlacementQuestion(
      prompt: 'ما هو الحرف الأخير في "كتاب"؟',
      options: ['ت', 'ا', 'ك', 'ب'],
      correctIndex: 3,
      difficulty: 3,
    ),
  ];

  void _answer(int selectedIndex) {
    final question = _questions[_currentQuestion];
    final correct = selectedIndex == question.correctIndex;
    _answers.add(correct);

    if (_currentQuestion < _questions.length - 1) {
      setState(() => _currentQuestion++);
    } else {
      // Test complete
      final result = PlacementAlgorithm.calculate(
        answers: _answers,
        ageGroup: widget.ageGroup,
      );
      setState(() {
        _showResult = true;
        _result = result;
      });
    }
  }

  void _finishTest() {
    // Navigate to home with profile data
    context.go(
      AppRouter.homeMap,
      extra: {
        'ageGroup': widget.ageGroup,
        'avatarIndex': widget.avatarIndex,
        'name': widget.childName,
        'startingUnit': _result?.startingUnit ?? 'unit_01_alif',
        'isNewProfile': true,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_showResult && _result != null) {
      return _buildResultScreen();
    }
    return _buildQuestionScreen();
  }

  Widget _buildQuestionScreen() {
    final question = _questions[_currentQuestion];
    final progress = (_currentQuestion + 1) / _questions.length;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundDay,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Top bar with back button and progress
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryDay),
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go(AppRouter.nameInput);
                        }
                      },
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${_currentQuestion + 1}/${_questions.length}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondaryDay,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 10,
                          backgroundColor: AppColors.disabledDay,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primaryDay,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 48),

                // Question
                Text(
                  question.prompt,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimaryDay,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .slideY(begin: -0.1, end: 0),

                const SizedBox(height: 48),

                // Answer options
                ...List.generate(question.options.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () => _answer(index),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.textPrimaryDay,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(color: AppColors.borderDay),
                          ),
                        ),
                        child: Text(
                          question.options[index],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                        .animate(delay: Duration(milliseconds: index * 100))
                        .fadeIn(duration: 300.ms)
                        .slideX(begin: 0.1, end: 0),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultScreen() {
    final result = _result!;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final scoreCircleSize = (screenWidth * 0.4).clamp(120.0, 200.0);
    final scoreFontSize = (scoreCircleSize * 0.3).clamp(32.0, 60.0);
    
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundDay,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Score circle
                  Container(
                    width: scoreCircleSize,
                    height: scoreCircleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryDay.withValues(alpha: 0.15),
                      border: Border.all(color: AppColors.primaryDay, width: 4),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${result.correctCount}',
                            style: TextStyle(
                              fontSize: scoreFontSize,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryDay,
                            ),
                          ),
                          Text(
                            'من ${result.totalQuestions}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.textSecondaryDay,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().scale(
                    begin: const Offset(0.5, 0.5),
                    duration: 600.ms,
                    curve: Curves.elasticOut,
                  ),

                  const SizedBox(height: 32),

                  Text(
                    'مستواك: ${result.levelLabelAr}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimaryDay,
                    ),
                  ).animate().fadeIn(delay: 400.ms),

                  const SizedBox(height: 16),

                  const Text(
                    'رائع! سنبدأ من المكان المناسب لك',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondaryDay,
                    ),
                  ).animate().fadeIn(delay: 600.ms),

                  const SizedBox(height: 48),

                  SizedBox(
                    width: 200,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _finishTest,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDay,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: const Text(
                        'هيا نبدأ!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 800.ms).scale(begin: const Offset(0.9, 0.9)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PlacementQuestion {
  final String prompt;
  final List<String> options;
  final int correctIndex;
  final int difficulty;

  const _PlacementQuestion({
    required this.prompt,
    required this.options,
    required this.correctIndex,
    required this.difficulty,
  });
}
