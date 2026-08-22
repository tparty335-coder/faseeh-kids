import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:faseeh_kids/core/router/app_router.dart';
import 'package:faseeh_kids/core/utils/age_group.dart';

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
  final _focusNode = FocusNode();

  // Emoji for the selected avatar
  static const List<String> _avatarEmojis = [
    '🦅','🦁','🐪','🐇','🦊','🐻','🦋','⭐','🌟',
  ];

  void _proceed() {
    if (_formKey.currentState?.validate() ?? false) {
      HapticFeedback.lightImpact();

      context.go(
        AppRouter.homeMap,
        extra: {
          'ageGroup': widget.ageGroup,
          'avatarIndex': widget.avatarIndex,
          'name': _controller.text.trim(),
          'startingUnit': 'unit_01_alif',
          'isNewProfile': true,
        },
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isTablet = size.width > 600;
    final emoji = widget.avatarIndex < _avatarEmojis.length
        ? _avatarEmojis[widget.avatarIndex]
        : '🦅';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 60 : 28),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // ─── Top Bar ───
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _NavButton(
                            icon: Icons.arrow_back_ios_new_rounded,
                            onTap: () {
                              if (context.canPop()) {
                                context.pop();
                              } else {
                                context.go(AppRouter.avatarSelection);
                              }
                            },
                          ),
                          _NavButton(
                            icon: Icons.home_rounded,
                            onTap: () => context.go(AppRouter.homeMap),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: isTablet ? 40 : 24),

                    // ─── Big Avatar ───
                    Container(
                      width: isTablet ? 180 : 140,
                      height: isTablet ? 180 : 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFD54F), Color(0xFFFF8F00)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF8F00).withValues(alpha: 0.5),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          emoji,
                          style: TextStyle(fontSize: isTablet ? 90 : 70),
                        ),
                      ),
                    )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scaleXY(end: 1.06, duration: 2.seconds, curve: Curves.easeInOut),

                    SizedBox(height: isTablet ? 40 : 28),

                    // ─── Title ───
                    Text(
                      'ما اسمك؟',
                      style: TextStyle(
                        fontSize: isTablet ? 48 : 38,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontFamily: 'Cairo',
                        shadows: const [Shadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
                      ),
                    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),

                    const SizedBox(height: 8),
                    Text(
                      'اكتب اسمك هنا 👇',
                      style: TextStyle(
                        fontSize: isTablet ? 22 : 18,
                        color: Colors.white70,
                        fontFamily: 'Cairo',
                      ),
                    ).animate().fadeIn(delay: 200.ms),

                    SizedBox(height: isTablet ? 40 : 28),

                    // ─── Name Field ───
                    TextFormField(
                      controller: _controller,
                      focusNode: _focusNode,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      autofocus: false,
                      style: TextStyle(
                        fontSize: isTablet ? 36 : 28,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A237E),
                        fontFamily: 'Cairo',
                      ),
                      decoration: InputDecoration(
                        hintText: 'أكتب اسمك',
                        hintStyle: TextStyle(
                          fontSize: isTablet ? 32 : 24,
                          color: Colors.grey.shade400,
                          fontFamily: 'Cairo',
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 32 : 24,
                          vertical: isTablet ? 28 : 22,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Color(0xFFFFD54F), width: 3),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return 'الرجاء إدخال اسمك';
                        if (value.trim().length < 2) return 'الاسم قصير جداً';
                        return null;
                      },
                      onFieldSubmitted: (_) => _proceed(),
                    ).animate().fadeIn(delay: 400.ms, duration: 500.ms),

                    SizedBox(height: isTablet ? 48 : 36),

                    // ─── Next Button ───
                    GestureDetector(
                      onTap: _proceed,
                      child: Container(
                        width: double.infinity,
                        height: isTablet ? 76 : 66,
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
                                fontSize: isTablet ? 28 : 24,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 22),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3),

                    SizedBox(height: isTablet ? 40 : 30),
                  ],
                ),
              ),
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
