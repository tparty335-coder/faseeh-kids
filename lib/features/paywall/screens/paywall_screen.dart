// ====================================================
// features/paywall/screens/paywall_screen.dart
// شاشة الاشتراك المميز — Premium Paywall
// تصميم: Desert Oasis + Glassmorphism + عربي RTL
// ====================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:faseeh_kids/core/providers/purchase_provider.dart';

class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key});

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  int _selectedIndex = 1; // Default: yearly (best value)
  bool _isPurchasing = false;

  @override
  Widget build(BuildContext context) {
    final offeringsAsync = ref.watch(offeringsProvider);
    final size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1B2A),
        body: Stack(
          children: [
            // ─── Background gradient ───
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1A1040),
                    Color(0xFF0D2137),
                    Color(0xFF0A1628),
                  ],
                ),
              ),
            ),

            // ─── Stars background ───
            ..._buildStars(size),

            // ─── Main content ───
            SafeArea(
              child: Column(
                children: [
                  // Close button
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.white70, size: 28),
                      onPressed: () => context.pop(),
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          // ─── Hero: Falcon mascot ───
                          _buildHeroSection(),
                          const SizedBox(height: 24),

                          // ─── Title ───
                          _buildTitle(),
                          const SizedBox(height: 20),

                          // ─── Features list ───
                          _buildFeaturesList(),
                          const SizedBox(height: 28),

                          // ─── Pricing packages ───
                          offeringsAsync.when(
                            data: (offerings) => _buildPricingSection(offerings),
                            loading: () => _buildPricingPlaceholder(),
                            error: (_, __) => _buildPricingPlaceholder(),
                          ),
                          const SizedBox(height: 20),

                          // ─── CTA Button ───
                          offeringsAsync.when(
                            data: (offerings) => _buildCtaButton(offerings),
                            loading: () => const SizedBox.shrink(),
                            error: (_, __) => const SizedBox.shrink(),
                          ),
                          const SizedBox(height: 12),

                          // ─── Restore + Legal ───
                          _buildFooter(),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Stars decoration ───
  List<Widget> _buildStars(Size size) {
    return List.generate(20, (i) {
      return Positioned(
        top: (i * 37.7) % size.height,
        left: (i * 53.3) % size.width,
        child: Container(
          width: i % 3 == 0 ? 3 : 2,
          height: i % 3 == 0 ? 3 : 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.3 + (i % 4) * 0.1),
          ),
        ).animate(onPlay: (c) => c.repeat()).fadeIn(
          duration: Duration(milliseconds: 1200 + i * 150),
        ).then().fadeOut(duration: Duration(milliseconds: 1200 + i * 150)),
      );
    });
  }

  Widget _buildHeroSection() {
    return Column(
      children: [
        const SizedBox(height: 8),
        // Golden crown icon over letter
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFFF8C00)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFD700).withValues(alpha: 0.4),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '★',
                  style: GoogleFonts.cairo(
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
              ),
            ).animate().scale(
              begin: const Offset(0.8, 0.8),
              end: const Offset(1.0, 1.0),
              duration: 600.ms,
              curve: Curves.easeOutBack,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          'فصيح الصغار المميز',
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            height: 1.2,
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 8),
        Text(
          'افتح كامل رحلة الحروف العربية الـ 28',
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: 16,
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
        ).animate().fadeIn(delay: 350.ms),
      ],
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      ('🔤', '28 حرفاً عربياً كاملاً بأصوات بشرية نقية'),
      ('🎵', 'أصوات مستخلصة من أسطوانة تعليمية أصيلة'),
      ('📝', 'تعلّم الحركات والمدود والكلمات والجمل'),
      ('🎮', 'ألعاب تعليمية تفاعلية لكل حرف'),
      ('📊', 'لوحة تقدم الوالدين وتقارير مفصّلة'),
      ('⭐', 'مكافآت وشارات تشجيعية للطفل'),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: features.asMap().entries.map((entry) {
          final idx = entry.key;
          final (emoji, text) = entry.value;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    text,
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(Icons.check_circle_rounded, color: Color(0xFF4CAF50), size: 20),
              ],
            ).animate().fadeIn(delay: Duration(milliseconds: 400 + idx * 80))
              .slideX(begin: 0.2, end: 0),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPricingPlaceholder() {
    return Column(
      children: List.generate(3, (i) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        height: 72,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white.withValues(alpha: 0.06),
        ),
      )),
    );
  }

  Widget _buildPricingSection(Offerings? offerings) {
    // If no RevenueCat offerings yet (test mode), show placeholder prices
    final packages = offerings?.current?.availablePackages ?? [];

    if (packages.isEmpty) {
      return _buildFallbackPricing();
    }

    return Column(
      children: packages.asMap().entries.map((entry) {
        final idx = entry.key;
        final pkg = entry.value;
        final isSelected = _selectedIndex == idx;
        final isBestValue = pkg.packageType == PackageType.annual;

        return GestureDetector(
          onTap: () => setState(() => _selectedIndex = idx),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: isSelected
                  ? const Color(0xFFFFD700).withValues(alpha: 0.15)
                  : Colors.white.withValues(alpha: 0.06),
              border: Border.all(
                color: isSelected ? const Color(0xFFFFD700) : Colors.white24,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? const Color(0xFFFFD700) : Colors.white54,
                      width: 2,
                    ),
                    color: isSelected ? const Color(0xFFFFD700) : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, size: 14, color: Colors.black)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _packageTitle(pkg.packageType),
                            style: GoogleFonts.cairo(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          if (isBestValue) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFD700),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'الأفضل قيمةً',
                                style: GoogleFonts.cairo(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        _packageSubtitle(pkg.packageType),
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  pkg.storeProduct.priceString,
                  style: GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: isSelected ? const Color(0xFFFFD700) : Colors.white,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: Duration(milliseconds: 500 + idx * 100)),
        );
      }).toList(),
    );
  }

  Widget _buildFallbackPricing() {
    // Shown before RevenueCat offerings are configured
    final options = [
      ('شهري',        'وصول لكل الحروف شهرياً',     'ر.س 11',  false),
      ('سنوي',        'وفّر 58% مقارنةً بالشهري',   'ر.س 55',  true),
      ('مدى الحياة',  'ادفع مرة واحدة للأبد',        'ر.س 109', false),
    ];

    return Column(
      children: options.asMap().entries.map((entry) {
        final idx = entry.key;
        final (title, sub, price, best) = entry.value;
        final isSelected = _selectedIndex == idx;

        return GestureDetector(
          onTap: () => setState(() => _selectedIndex = idx),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: isSelected
                  ? const Color(0xFFFFD700).withValues(alpha: 0.15)
                  : Colors.white.withValues(alpha: 0.06),
              border: Border.all(
                color: isSelected ? const Color(0xFFFFD700) : Colors.white24,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24, height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? const Color(0xFFFFD700) : Colors.white54,
                      width: 2,
                    ),
                    color: isSelected ? const Color(0xFFFFD700) : Colors.transparent,
                  ),
                  child: isSelected ? const Icon(Icons.check, size: 14, color: Colors.black) : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(title, style: GoogleFonts.cairo(
                            fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white,
                          )),
                          if (best) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFD700),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('الأفضل قيمةً', style: GoogleFonts.cairo(
                                fontSize: 10, fontWeight: FontWeight.w800, color: Colors.black,
                              )),
                            ),
                          ],
                        ],
                      ),
                      Text(sub, style: GoogleFonts.cairo(fontSize: 12, color: Colors.white60)),
                    ],
                  ),
                ),
                Text(price, style: GoogleFonts.cairo(
                  fontSize: 18, fontWeight: FontWeight.w900,
                  color: isSelected ? const Color(0xFFFFD700) : Colors.white,
                )),
              ],
            ),
          ).animate().fadeIn(delay: Duration(milliseconds: 500 + idx * 100)),
        );
      }).toList(),
    );
  }

  Widget _buildCtaButton(Offerings? offerings) {
    final packages = offerings?.current?.availablePackages ?? [];
    final hasPackages = packages.isNotEmpty;

    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: _isPurchasing
            ? null
            : () async {
                if (!hasPackages) {
                  _showNoOfferings();
                  return;
                }
                if (_selectedIndex >= packages.length) return;

                setState(() => _isPurchasing = true);
                final success = await ref
                    .read(purchaseProvider.notifier)
                    .purchase(packages[_selectedIndex]);
                setState(() => _isPurchasing = false);

                if (success && mounted) {
                  context.pop(true); // Return success to caller
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFD700),
          foregroundColor: Colors.black,
          elevation: 8,
          shadowColor: const Color(0xFFFFD700).withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: _isPurchasing
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.black),
                strokeWidth: 2,
              )
            : Text(
                'ابدأ الرحلة الكاملة ✨',
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
      ),
    ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildFooter() {
    return Column(
      children: [
        TextButton(
          onPressed: () async {
            setState(() => _isPurchasing = true);
            final success = await ref.read(purchaseProvider.notifier).restore();
            setState(() => _isPurchasing = false);
            if (success && mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم استعادة اشتراكك بنجاح! 🎉',
                    style: GoogleFonts.cairo(fontSize: 14)),
                  backgroundColor: const Color(0xFF4CAF50),
                ),
              );
              context.pop(true);
            }
          },
          child: Text(
            'استعادة المشتريات',
            style: GoogleFonts.cairo(color: Colors.white54, fontSize: 13),
          ),
        ),
        Text(
          'يُجدَّد الاشتراك تلقائياً · يمكن الإلغاء في أي وقت\nيخضع للشروط والأحكام وسياسة الخصوصية',
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(color: Colors.white38, fontSize: 10),
        ),
      ],
    );
  }

  String _packageTitle(PackageType type) {
    switch (type) {
      case PackageType.monthly:  return 'شهري';
      case PackageType.annual:   return 'سنوي';
      case PackageType.lifetime: return 'مدى الحياة';
      default:                   return 'مميز';
    }
  }

  String _packageSubtitle(PackageType type) {
    switch (type) {
      case PackageType.monthly:  return 'وصول لكل الحروف شهرياً';
      case PackageType.annual:   return 'وفّر 58% مقارنةً بالشهري';
      case PackageType.lifetime: return 'ادفع مرة واحدة للأبد';
      default:                   return '';
    }
  }

  void _showNoOfferings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('سيتم تفعيل المدفوعات قريباً!',
            style: GoogleFonts.cairo()),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
