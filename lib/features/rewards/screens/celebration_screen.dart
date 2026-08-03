import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:faseeh_kids/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class CelebrationScreen extends StatefulWidget {
  final int stars;
  final int xpEarned;
  final String? badgeIcon;

  const CelebrationScreen({
    super.key,
    this.stars = 3,
    this.xpEarned = 20,
    this.badgeIcon,
  });

  @override
  State<CelebrationScreen> createState() => _CelebrationScreenState();
}

class _CelebrationScreenState extends State<CelebrationScreen> {
  late ConfettiController _confettiController;
  final List<String> _motivationalTexts = [
    'أحسنت يا بطل!',
    'ممتاز!',
    'رائع جداً!',
    'واصل التألق!'
  ];
  late String _selectedText;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _selectedText = _motivationalTexts[Random().nextInt(_motivationalTexts.length)];
    
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _confettiController.play();
      }
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Widget _buildStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        bool isEarned = index < widget.stars;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(
            isEarned ? Icons.star_rounded : Icons.star_outline_rounded,
            color: isEarned ? Colors.amber : Colors.white.withValues(alpha: 0.5),
            size: index == 1 ? 80 : 60, // Center star is larger
          ).animate(delay: Duration(milliseconds: 600 + (index * 200)))
           .scale(curve: Curves.elasticOut)
           .then()
           .shimmer(duration: const Duration(milliseconds: 1000)),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary.withValues(alpha: 0.8),
                  const Color(0xFF1E88E5), // Darker blue
                ],
                center: Alignment.center,
                radius: 1.0,
              ),
            ),
          ),
          
          // Sparkle Particles (Simulated with icons)
          ...List.generate(10, (index) {
            final random = Random();
            return Positioned(
              left: random.nextDouble() * MediaQuery.of(context).size.width,
              top: random.nextDouble() * MediaQuery.of(context).size.height,
              child: const Icon(Icons.auto_awesome, color: Colors.white, size: 24)
                  .animate(onPlay: (controller) => controller.repeat())
                  .fadeIn(duration: Duration(milliseconds: 500 + random.nextInt(1000)))
                  .then()
                  .fadeOut(duration: Duration(milliseconds: 500 + random.nextInt(1000))),
            );
          }),

          // Content
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _selectedText,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                    textDirection: TextDirection.rtl,
                  ).animate(delay: const Duration(milliseconds: 300)).fadeIn().slideY(begin: 0.5),
                  
                  const SizedBox(height: 40),
                  
                  _buildStars(),
                  
                  const SizedBox(height: 24),

                  // Falcon Mascot Celebrating
                  Builder(
                    builder: (context) {
                      final mascotSize = (MediaQuery.sizeOf(context).width * 0.35).clamp(110.0, 180.0);
                      return Container(
                        width: mascotSize,
                        height: mascotSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.withValues(alpha: 0.4),
                              blurRadius: 16,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/mascot/falcon_celebrating.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                          .animate()
                          .scale(duration: 600.ms, curve: Curves.elasticOut)
                          .then()
                          .shimmer(duration: 1200.ms);
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '+${widget.xpEarned} XP',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.flash_on_rounded, color: Colors.amber, size: 32),
                      ],
                    ),
                  ).animate(delay: const Duration(milliseconds: 1200)).scale(curve: Curves.elasticOut),

                  if (widget.badgeIcon != null) ...[
                    const SizedBox(height: 40),
                    Column(
                      children: [
                        Text(
                          'شارة جديدة!',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                              ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            widget.badgeIcon!,
                            style: const TextStyle(fontSize: 64),
                          ),
                        ).animate(delay: const Duration(milliseconds: 1600)).scale(curve: Curves.elasticOut),
                      ],
                    ),
                  ],

                  const Spacer(),
                  
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 8,
                        ),
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          }
                        },
                        child: const Text(
                          'التالي',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ).animate(delay: const Duration(milliseconds: 2000)).fadeIn(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2, // Straight down
              maxBlastForce: 5,
              minBlastForce: 2,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.2,
              colors: const [Colors.amber, Colors.white, AppColors.secondary, AppColors.primary],
            ),
          ),
        ],
      ),
    );
  }
}
