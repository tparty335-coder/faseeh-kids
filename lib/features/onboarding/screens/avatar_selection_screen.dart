import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/router/app_router.dart';
import 'package:faseeh_kids/core/utils/age_group.dart';

class AvatarSelectionScreen extends StatefulWidget {
  final AgeGroup? ageGroup;
  const AvatarSelectionScreen({super.key, this.ageGroup});

  @override
  State<AvatarSelectionScreen> createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  int? _selectedIndex;

  // Avatars using EMOJI — large, colorful, child-friendly. No missing images.
  static const List<_AvatarOption> _avatars = [
    _AvatarOption(emoji: '🦅', label: 'صقر',    gradient: [Color(0xFFFF9800), Color(0xFFFF5722)]),
    _AvatarOption(emoji: '🦁', label: 'أسد',    gradient: [Color(0xFFFFC107), Color(0xFFFF9800)]),
    _AvatarOption(emoji: '🐪', label: 'جمل',    gradient: [Color(0xFFD4A574), Color(0xFF8D6E63)]),
    _AvatarOption(emoji: '🐇', label: 'أرنب',   gradient: [Color(0xFFE91E63), Color(0xFF9C27B0)]),
    _AvatarOption(emoji: '🦊', label: 'ثعلب',   gradient: [Color(0xFFFF5722), Color(0xFFFF9800)]),
    _AvatarOption(emoji: '🐻', label: 'دب',     gradient: [Color(0xFF795548), Color(0xFF5D4037)]),
    _AvatarOption(emoji: '🦋', label: 'فراشة',  gradient: [Color(0xFF9C27B0), Color(0xFF3F51B5)]),
    _AvatarOption(emoji: '⭐', label: 'نجمة',   gradient: [Color(0xFFFFEB3B), Color(0xFFFFC107)]),
    _AvatarOption(emoji: '🌟', label: 'بطل',    gradient: [Color(0xFF00BCD4), Color(0xFF2196F3)]),
  ];

  void _proceed() {
    if (_selectedIndex == null) return;
    HapticFeedback.lightImpact();
    context.go(
      AppRouter.nameInput,
      extra: NameInputArgs(
        ageGroup: widget.ageGroup ?? AgeGroup.preschool3to5,
        avatarIndex: _selectedIndex!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1A237E), Color(0xFF283593), Color(0xFF1565C0)],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // ─── Top Bar ───
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back button
                      _NavButton(
                        icon: Icons.arrow_back_ios_new_rounded,
                        onTap: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go(AppRouter.ageSelection);
                          }
                        },
                      ),
                      // Home button
                      _NavButton(
                        icon: Icons.home_rounded,
                        onTap: () => context.go(AppRouter.homeMap),
                      ),
                    ],
                  ),
                ),

                // ─── Title ───
                const SizedBox(height: 8),
                Text(
                  '🦅 اختر شخصيتك',
                  style: TextStyle(
                    fontSize: isTablet ? 40 : 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontFamily: 'Cairo',
                    shadows: [Shadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
                  ),
                ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),

                const SizedBox(height: 4),
                Text(
                  'اختر الصورة التي تعجبك',
                  style: TextStyle(
                    fontSize: isTablet ? 20 : 16,
                    color: Colors.white70,
                    fontFamily: 'Cairo',
                  ),
                ).animate().fadeIn(delay: 200.ms),

                const SizedBox(height: 24),

                // ─── Avatar Grid ───
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: isTablet ? 20 : 14,
                        mainAxisSpacing: isTablet ? 20 : 14,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: _avatars.length,
                      itemBuilder: (context, index) {
                        final avatar = _avatars[index];
                        final isSelected = _selectedIndex == index;

                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            setState(() => _selectedIndex = index);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutBack,
                            transform: Matrix4.diagonal3Values(
                              isSelected ? 1.08 : 1.0,
                              isSelected ? 1.08 : 1.0,
                              1.0,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: avatar.gradient,
                              ),
                              borderRadius: BorderRadius.circular(24),
                              border: isSelected
                                  ? Border.all(color: Colors.white, width: 4)
                                  : Border.all(color: Colors.white24, width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: avatar.gradient.last.withValues(alpha: isSelected ? 0.7 : 0.3),
                                  blurRadius: isSelected ? 20 : 8,
                                  spreadRadius: isSelected ? 2 : 0,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  avatar.emoji,
                                  style: TextStyle(fontSize: isTablet ? 68 : 56),
                                ),
                                if (isSelected)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check_rounded,
                                        size: 18,
                                        color: avatar.gradient.first,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        )
                        .animate(delay: Duration(milliseconds: index * 60))
                        .fadeIn(duration: 300.ms)
                        .scale(begin: const Offset(0.7, 0.7));
                      },
                    ),
                  ),
                ),

                // ─── Next Button ───
                Padding(
                  padding: EdgeInsets.fromLTRB(24, 16, 24, isTablet ? 32 : 24),
                  child: AnimatedOpacity(
                    opacity: _selectedIndex != null ? 1.0 : 0.4,
                    duration: const Duration(milliseconds: 300),
                    child: GestureDetector(
                      onTap: _proceed,
                      child: Container(
                        width: double.infinity,
                        height: isTablet ? 72 : 62,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFD54F), Color(0xFFFF8F00)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF8F00).withValues(alpha: 0.5),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'التالي',
                              style: TextStyle(
                                fontSize: isTablet ? 26 : 22,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 20),
                          ],
                        ),
                      ),
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
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _NavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white30),
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}

class _AvatarOption {
  final String emoji;
  final String label;
  final List<Color> gradient;
  const _AvatarOption({required this.emoji, required this.label, required this.gradient});
}
