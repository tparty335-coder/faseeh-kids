import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/core/utils/constants.dart';
import 'package:faseeh_kids/core/router/app_router.dart';

/// Splash Screen — App launch screen
/// Shows app logo with fade-in animation, falcon mascot
/// Auto-navigates after 2 seconds
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    // Check if any child profiles exist (returning user)
    final profileBox = Hive.box(AppConstants.childProfileBox);
    if (profileBox.isNotEmpty) {
      // Returning user — go to home
      context.go(AppRouter.homeMap);
    } else {
      // New user — go to onboarding
      context.go(AppRouter.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.primaryDay,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Falcon mascot asset (responsive)
              Builder(
                builder: (context) {
                  final size = MediaQuery.sizeOf(context).width * 0.45;
                  final clampedSize = size.clamp(160.0, 260.0);
                  return Container(
                    width: clampedSize,
                    height: clampedSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/mascot/falcon_happy.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0))
                      .then()
                      .shimmer(duration: 1500.ms);
                },
              ),

              const SizedBox(height: 32),

              // App name in Arabic
              Text(
                AppConstants.appName,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              )
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 600.ms)
                  .slideY(begin: 0.3, end: 0),

              const SizedBox(height: 8),

              // Tagline
              Text(
                'تعلّم العربية بمرح!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              )
                  .animate()
                  .fadeIn(delay: 800.ms, duration: 600.ms),

              const SizedBox(height: 48),

              // Loading indicator
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  color: Colors.white.withValues(alpha: 0.7),
                  strokeWidth: 3,
                ),
              )
                  .animate()
                  .fadeIn(delay: 1200.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}
