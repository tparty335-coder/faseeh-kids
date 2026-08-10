import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/core/router/app_router.dart';
import 'package:faseeh_kids/core/utils/age_group.dart';

/// Name Input Screen — child enters their name in Arabic
/// P4-T008
class NameInputScreen extends StatefulWidget {
  final AgeGroup ageGroup;
  final int avatarIndex;
  const NameInputScreen({
    super.key,
    required this.ageGroup,
    required this.avatarIndex,
  });

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _proceed() {
    if (_formKey.currentState?.validate() ?? false) {
      context.go(
        AppRouter.placementTest,
        extra: PlacementTestArgs(
          ageGroup: widget.ageGroup,
          avatarIndex: widget.avatarIndex,
          childName: _controller.text.trim(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundDay,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryDay),
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go(AppRouter.avatarSelection);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'ما اسمك؟',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimaryDay,
                    ),
                  ).animate().fadeIn(duration: 500.ms),

                  const SizedBox(height: 12),

                  const Text(
                    'اكتب اسمك هنا',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondaryDay,
                    ),
                  ).animate().fadeIn(delay: 200.ms),

                  const SizedBox(height: 48),

                  // Name input field
                  TextFormField(
                    controller: _controller,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryDay,
                    ),
                    decoration: InputDecoration(
                      hintText: 'اسمك',
                      hintStyle: TextStyle(
                        fontSize: 28,
                        color: AppColors.textSecondaryDay.withValues(alpha: 0.5),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: AppColors.borderDay),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: AppColors.primaryDay,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: AppColors.errorDay,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'الرجاء إدخال اسمك';
                      }
                      if (value.trim().length < 2) {
                        return 'الاسم قصير جداً';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) => _proceed(),
                  ).animate().fadeIn(delay: 400.ms, duration: 500.ms),

                  const Spacer(),

                  // Next button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _proceed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDay,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'التالي',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
