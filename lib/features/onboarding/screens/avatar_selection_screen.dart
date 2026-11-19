import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/router/app_router.dart';
import 'package:faseeh_kids/core/utils/age_group.dart';
import 'package:faseeh_kids/core/utils/responsive.dart';

class AvatarSelectionScreen extends StatefulWidget {
  final AgeGroup? ageGroup;
  const AvatarSelectionScreen({super.key, this.ageGroup});

  @override
  State<AvatarSelectionScreen> createState() => _AvatarSelectionScreenState();
}

class _AvatarOption {
  final String imagePath;
  final String fallbackEmoji;
  final String label;
  final String title;
  final List<Color> gradient;
  final Color auraColor;
  const _AvatarOption({
    required this.imagePath,
    required this.fallbackEmoji,
    required this.label,
    required this.title,
    required this.gradient,
    required this.auraColor,
  });
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  int? _selectedIndex;

  // Child-friendly 3D animal and hero character avatars
  static const List<_AvatarOption> _avatars = [
    _AvatarOption(
      imagePath: 'assets/images/avatars/avatar_lion.webp',
      fallbackEmoji: '🦁',
      label: 'أَسَد',
      title: 'الشجاع',
      gradient: [Color(0xFFFF9966), Color(0xFFFF5E62)],
      auraColor: Color(0xFFFF9966),
    ),
    _AvatarOption(
      imagePath: 'assets/images/avatars/avatar_rabbit.webp',
      fallbackEmoji: '🐇',
      label: 'أَرْنَب',
      title: 'السريع',
      gradient: [Color(0xFFFF512F), Color(0xFFDD2476)],
      auraColor: Color(0xFFDD2476),
    ),
    _AvatarOption(
      imagePath: 'assets/images/avatars/avatar_camel.webp',
      fallbackEmoji: '🐪',
      label: 'جَمَل',
      title: 'الصبور',
      gradient: [Color(0xFFD4A574), Color(0xFF8D6E63)],
      auraColor: Color(0xFFD4A574),
    ),
    _AvatarOption(
      imagePath: 'assets/images/avatars/avatar_king.webp',
      fallbackEmoji: '👑',
      label: 'الْمَلِك',
      title: 'الأمير',
      gradient: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
      auraColor: Color(0xFF8E2DE2),
    ),
    _AvatarOption(
      imagePath: 'assets/images/avatars/avatar_champion.webp',
      fallbackEmoji: '🏆',
      label: 'الْبَطَل',
      title: 'الفائز',
      gradient: [Color(0xFFF7971E), Color(0xFFFFD200)],
      auraColor: Color(0xFFFFD200),
    ),
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
    final cardW = context.screenWidth / context.gridColumns;
    final avatarSize = (cardW * 0.48).clamp(60.0, 115.0);

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
              colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
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
                const SizedBox(height: 4),
                Text(
                  '🌟 اخْتَرْ شَخْصِيَّتَكَ الْمُفَضَّلَةَ 🌟',
                  style: TextStyle(
                    fontSize: isTablet ? 36 : 26,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontFamily: 'Cairo',
                    shadows: const [
                      Shadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 4)),
                    ],
                  ),
                ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),

                const SizedBox(height: 2),
                Text(
                  'اختر البطل الذي سيرافقك في رحلة الحروف الممتعة',
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 14,
                    color: Colors.white70,
                    fontFamily: 'Cairo',
                  ),
                ).animate().fadeIn(delay: 200.ms),

                const SizedBox(height: 16),

                // ─── Avatar Grid ───
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: context.gridColumns,
                        crossAxisSpacing: 12 * context.screenScale,
                        mainAxisSpacing: 12 * context.screenScale,
                        childAspectRatio: context.gridAspectRatio,
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
                              isSelected ? 1.06 : 1.0,
                              isSelected ? 1.06 : 1.0,
                              1.0,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: isSelected
                                    ? avatar.gradient
                                    : [
                                        avatar.gradient.first.withValues(alpha: 0.65),
                                        avatar.gradient.last.withValues(alpha: 0.65),
                                      ],
                              ),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: isSelected ? Colors.amberAccent : Colors.white30,
                                width: isSelected ? 4.0 : 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isSelected
                                      ? avatar.auraColor.withValues(alpha: 0.7)
                                      : avatar.gradient.last.withValues(alpha: 0.25),
                                  blurRadius: isSelected ? 20 : 10,
                                  spreadRadius: isSelected ? 3 : 0,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // 3D Avatar Image
                                    Container(
                                      width: avatarSize,
                                      height: avatarSize,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withValues(alpha: 0.15),
                                        border: Border.all(
                                          color: isSelected ? Colors.amberAccent : Colors.white54,
                                          width: isSelected ? 3.0 : 2.0,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.25),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                          avatar.imagePath,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => Center(
                                            child: Text(
                                              avatar.fallbackEmoji,
                                              style: TextStyle(fontSize: isTablet ? 60 : 42),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Name Label
                                    Text(
                                      avatar.label,
                                      style: TextStyle(
                                        fontSize: context.scaledFont(18),
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        fontFamily: 'Cairo',
                                        shadows: const [
                                          Shadow(color: Colors.black45, blurRadius: 6, offset: Offset(0, 2)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    // Nickname
                                    Text(
                                      avatar.title,
                                      style: TextStyle(
                                        fontSize: context.scaledFont(12),
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withValues(alpha: 0.95),
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                  ],
                                ),
                                // Selection Check Badge
                                if (isSelected)
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color: Colors.amberAccent,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(color: Colors.black38, blurRadius: 6),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.check_rounded,
                                        size: 18,
                                        color: Colors.black87,
                                      ),
                                    ).animate().scale(duration: 200.ms, curve: Curves.elasticOut),
                                  ),
                              ],
                            ),
                          ),
                        )
                        .animate(delay: Duration(milliseconds: index * 50))
                        .fadeIn(duration: 300.ms)
                        .scale(begin: const Offset(0.8, 0.8));
                      },
                    ),
                  ),
                ),

                // ─── Next Button ───
                Padding(
                  padding: EdgeInsets.fromLTRB(24, 12, 24, isTablet ? 28 : 18),
                  child: AnimatedOpacity(
                    opacity: _selectedIndex != null ? 1.0 : 0.4,
                    duration: const Duration(milliseconds: 300),
                    child: GestureDetector(
                      onTap: _proceed,
                      child: Container(
                        width: double.infinity,
                        height: (58 * context.screenScale).clamp(50.0, 72.0),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFD54F), Color(0xFFFF8F00)],
                          ),
                          borderRadius: BorderRadius.circular(22),
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
                                fontSize: context.scaledFont(22),
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 18),
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
