import 'dart:math' as math;
import 'package:flutter/material.dart';

/// التصنيف القياسي لأحجام الشاشات عالمياً (من أقدم الهواتف الصغيرة حتى الأجهزة اللوحية الكبيرة)
enum ScreenTier {
  /// أقدم الهواتف الصغيرة جداً (<= 340dp مثل 320×533، Galaxy Pocket، iPhone SE القديم)
  ultraCompact,

  /// الهواتف الاقتصادية المنتشرة (341–380dp مثل 360×640، Samsung A11، Redmi 9)
  compact,

  /// الهواتف القياسية الحديثة (381–479dp مثل 390×844، 412×915، Pixel / iPhone)
  standard,

  /// الهواتف الكبيرة (480–599dp مثل Galaxy Ultra / الفابلت)
  largePhone,

  /// الأجهزة اللوحية المتوسطة (600–899dp مثل 7–8 بوصة)
  tablet,

  /// الأجهزة اللوحية الكبيرة (>= 900dp مثل 10–12 بوصة / Lenovo TB350XU 960×1600dp)
  largeTablet,
}

/// Faseeh Kids — Universal Responsive Layout Helper
/// يضمن تناسقاً بصرياً مريحاً بلا تكدّس وبلا تجاوز (Overflow) على كل شاشة في العالم:
/// - 320×533dp (أقدم الهواتف الصغيرة)
/// - 360×640dp (Samsung A11, Redmi 9)
/// - 390×844dp (iPhone القياسي)
/// - 412×915dp (Google Pixel / Galaxy S)
/// - 480×960dp (الهواتف الكبيرة)
/// - 600–1200dp (الأجهزة اللوحية مثل Lenovo TB350XU)
class AppResponsive {
  AppResponsive._();

  static ScreenTier tierFromWidth(double width) {
    if (width <= 340) return ScreenTier.ultraCompact;
    if (width <= 380) return ScreenTier.compact;
    if (width < 480) return ScreenTier.standard;
    if (width < 600) return ScreenTier.largePhone;
    if (width < 900) return ScreenTier.tablet;
    return ScreenTier.largeTablet;
  }

  static ScreenTier tier(BuildContext context) =>
      tierFromWidth(MediaQuery.sizeOf(context).width);

  /// نسبة القياس العرضي (متوافقة مع الكود السابق)
  static double scale(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width / 390).clamp(0.76, 1.35);
  }

  static double scaleFromWidth(double width) {
    return (width / 390).clamp(0.76, 1.35);
  }

  /// نسبة القياس الذكية ثنائية البعد (تراعي العرض والارتفاع معاً حتى لا تتكدس الهواتف القصيرة)
  static double adaptiveScale(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final wScale = size.width / 390.0;
    final hScale = size.height / 780.0;
    // على الشاشات القصيرة أو الضيقة نأخذ الأصغر لمنع التكتز، وعلى التابلت نقف عند حد متوازن
    final combined = math.min(wScale, hScale * 1.06);
    return combined.clamp(0.76, 1.28);
  }

  /// عدد أعمدة الشبكة المتدرّج
  static int gridCrossAxisCount(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width < 400 ? 2 : (width < 600 ? 3 : 4);
  }

  /// نسبة أبعاد عناصر الشبكة القياسية
  static double gridAspectRatio(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width < 400 ? 0.88 : (width < 600 ? 0.80 : 0.82);
  }

  /// أقصى عرض لمحتوى الصفحة حتى لا تتمدد البطاقات بشكل مشوّه على التابلت
  static double contentMaxWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 900) return 820.0;
    if (width >= 600) return 680.0;
    return double.infinity;
  }

  /// حشوة الصفحة الأفقية المتناسبة مع حجم الشاشة
  static double horizontalPadding(BuildContext context) {
    switch (tier(context)) {
      case ScreenTier.ultraCompact:
        return 10.0;
      case ScreenTier.compact:
        return 14.0;
      case ScreenTier.standard:
        return 16.0;
      case ScreenTier.largePhone:
        return 20.0;
      case ScreenTier.tablet:
        return 24.0;
      case ScreenTier.largeTablet:
        return 28.0;
    }
  }

  /// المسافة الرأسية الأساسية بين العناصر
  static double sectionGap(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    if (size.height < 600 || size.width <= 340) return 10.0;
    if (size.height < 700) return 12.0;
    if (size.width >= 600) return 18.0;
    return 14.0;
  }

  /// الحد الأدنى لمساحة اللمس المريحة للأطفال (WCAG / Material Kids)
  static double minTouchTarget(BuildContext context) {
    switch (tier(context)) {
      case ScreenTier.ultraCompact:
        return 44.0;
      case ScreenTier.compact:
        return 48.0;
      case ScreenTier.standard:
      case ScreenTier.largePhone:
        return 52.0;
      case ScreenTier.tablet:
      case ScreenTier.largeTablet:
        return 60.0;
    }
  }

  static bool isUltraCompact(BuildContext context) =>
      MediaQuery.sizeOf(context).width <= 340;
  static bool isSmallPhone(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 360;
  static bool isShortScreen(BuildContext context) =>
      MediaQuery.sizeOf(context).height < 660;
  static bool isVeryShortScreen(BuildContext context) =>
      MediaQuery.sizeOf(context).height < 580;
  static bool isPhone(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 600;
  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600;
  static bool isLargeTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 900;

  /// حجم الخط المرن الآمن ضد التكتز والقص
  static double font(
    BuildContext context,
    double baseSize, {
    double min = 11.0,
    double max = 44.0,
  }) {
    return (baseSize * adaptiveScale(context)).clamp(min, max);
  }

  /// المسافات والحشوات المرنة
  static double space(BuildContext context, double baseValue) {
    return baseValue * adaptiveScale(context);
  }
}

/// امتداد مختصر على BuildContext لكتابة واجهات متجاوبة نظيفة
extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  ScreenTier get screenTier => AppResponsive.tier(this);
  double get screenScale => AppResponsive.scale(this);
  double get adaptiveScale => AppResponsive.adaptiveScale(this);
  int get gridColumns => AppResponsive.gridCrossAxisCount(this);
  double get gridAspectRatio => AppResponsive.gridAspectRatio(this);
  double get contentMaxWidth => AppResponsive.contentMaxWidth(this);
  double get pagePaddingH => AppResponsive.horizontalPadding(this);
  double get sectionGap => AppResponsive.sectionGap(this);
  double get minTouchTarget => AppResponsive.minTouchTarget(this);

  bool get isUltraCompact => AppResponsive.isUltraCompact(this);
  bool get isSmallPhone => AppResponsive.isSmallPhone(this);
  bool get isShortScreen => AppResponsive.isShortScreen(this);
  bool get isVeryShortScreen => AppResponsive.isVeryShortScreen(this);
  bool get isPhone => AppResponsive.isPhone(this);
  bool get isTablet => AppResponsive.isTablet(this);
  bool get isLargeTablet => AppResponsive.isLargeTablet(this);

  double scaledFont(double baseSize, {double min = 11.0, double max = 44.0}) =>
      AppResponsive.font(this, baseSize, min: min, max: max);

  double scaledSpace(double baseValue) =>
      AppResponsive.space(this, baseValue);
}

/// إطار محتوى متجاوب يوسّط العناصر تلقائياً على التابلت ويحفظ الهوامش المتوازنة على الهواتف
class ResponsiveContentFrame extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;

  const ResponsiveContentFrame({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveMax = maxWidth ?? context.contentMaxWidth;
    final effectivePadding = padding ??
        EdgeInsets.symmetric(
          horizontal: context.pagePaddingH,
        );
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: effectiveMax),
        child: Padding(
          padding: effectivePadding,
          child: child,
        ),
      ),
    );
  }
}
