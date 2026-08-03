import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:faseeh_kids/core/router/app_router.dart';

/// Onboarding Screen — 3-page carousel introducing app features
/// P4-T004 & P4-T005
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingPage> _pages = const [
    _OnboardingPage(
      icon: Icons.auto_stories,
      title: 'تعلّم الحروف العربية',
      subtitle: 'اكتشف عالم الحروف مع صقر فصيح\nبطريقة ممتعة وتفاعلية',
      color: AppColors.primaryDay,
    ),
    _OnboardingPage(
      icon: Icons.games,
      title: 'العب واكسب نجوم',
      subtitle: 'أنشطة متنوعة وألعاب مسلية\nاجمع النجوم وارتقِ في المستويات',
      color: AppColors.secondaryDay,
    ),
    _OnboardingPage(
      icon: Icons.emoji_events,
      title: 'كن بطل اللغة العربية',
      subtitle: 'تابع تقدمك واحصل على شهادات\nوشارك إنجازاتك مع أهلك',
      color: AppColors.accentDay,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Last page — go to age selection
      context.go(AppRouter.ageSelection);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _pages.length - 1;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundDay,
        body: SafeArea(
          child: Column(
            children: [
              // Skip button (top left for RTL)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () => context.go(AppRouter.ageSelection),
                  child: const Text(
                    'تخطي',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondaryDay,
                    ),
                  ),
                ),
              ),

              // Page carousel (60% height)
              Expanded(
                flex: 6,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return _buildPage(page, index);
                  },
                ),
              ),

              // Page indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? AppColors.primaryDay
                          : AppColors.disabledDay,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Action button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: SizedBox(
                  width: 200,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDay,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Text(
                      isLastPage ? 'ابدأ المغامرة!' : 'التالي',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .scale(begin: const Offset(0.9, 0.9)),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(_OnboardingPage page, int index) {
    final imagePaths = [
      'assets/images/mascot/falcon_happy.jpg',
      'assets/images/mascot/falcon_encouraging.jpg',
      'assets/images/mascot/falcon_celebrating.jpg',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration area with real falcon mascot image
          Builder(
            builder: (context) {
              final size = (MediaQuery.sizeOf(context).width * 0.45).clamp(140.0, 220.0);
              return Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: page.color.withValues(alpha: 0.15),
                  boxShadow: [
                    BoxShadow(
                      color: page.color.withValues(alpha: 0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    imagePaths[index % imagePaths.length],
                    fit: BoxFit.cover,
                  ),
                ),
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .slideY(begin: 0, end: -0.05, duration: 1500.ms, curve: Curves.easeInOut)
                  .scaleXY(begin: 1.0, end: 1.04, duration: 1500.ms);
            },
          ),

          const SizedBox(height: 40),

          // Title
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimaryDay,
            ),
          )
              .animate()
              .fadeIn(delay: 200.ms, duration: 500.ms)
              .slideY(begin: 0.2, end: 0),

          const SizedBox(height: 16),

          // Subtitle
          Text(
            page.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: AppColors.textSecondaryDay,
            ),
          )
              .animate()
              .fadeIn(delay: 400.ms, duration: 500.ms),
        ],
      ),
    );
  }
}

class _OnboardingPage {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });
}
