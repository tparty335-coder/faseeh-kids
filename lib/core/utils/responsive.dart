import 'package:flutter/material.dart';

/// Faseeh Kids — Responsive Layout Helper
/// Implements standard screen scaling across all mobile & tablet form factors:
/// - 320dp (ultra-compact)
/// - 360dp (Samsung A11, Redmi 9)
/// - 390dp (iPhone standard reference)
/// - 412dp (Google Pixel)
/// - 480dp (Samsung S22/S23 Ultra)
/// - 600dp+ (Tablets)
class AppResponsive {
  AppResponsive._();

  /// Rule 1: Global scale ratio based on reference 390dp
  static double scale(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width / 390).clamp(0.78, 1.4);
  }

  static double scaleFromWidth(double width) {
    return (width / 390).clamp(0.78, 1.4);
  }

  /// Rule 2: Gradated GridView column count
  /// < 400dp   -> 2 columns
  /// 400-599dp -> 3 columns
  /// 600dp+    -> 4 columns
  static int gridCrossAxisCount(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width < 400 ? 2 : (width < 600 ? 3 : 4);
  }

  /// Rule 3: Dynamic childAspectRatio for standard grids
  static double gridAspectRatio(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width < 400 ? 0.88 : (width < 600 ? 0.80 : 0.82);
  }

  static bool isSmallPhone(BuildContext context) => MediaQuery.sizeOf(context).width < 360;
  static bool isPhone(BuildContext context) => MediaQuery.sizeOf(context).width < 600;
  static bool isTablet(BuildContext context) => MediaQuery.sizeOf(context).width >= 600;

  /// Rule 4: Flexible font sizing clamped safely
  static double font(BuildContext context, double baseSize, {double min = 11.0, double max = 42.0}) {
    return (baseSize * scale(context)).clamp(min, max);
  }

  /// Rule 5: Flexible spacing and padding
  static double space(BuildContext context, double baseValue) {
    return baseValue * scale(context);
  }
}

/// Convenience BuildContext extension for concise UI code
extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get screenScale => (screenWidth / 390).clamp(0.78, 1.4);
  int get gridColumns => screenWidth < 400 ? 2 : (screenWidth < 600 ? 3 : 4);
  double get gridAspectRatio => screenWidth < 400 ? 0.88 : (screenWidth < 600 ? 0.80 : 0.82);
  bool get isSmallPhone => screenWidth < 360;
  bool get isPhone => screenWidth < 600;
  bool get isTablet => screenWidth >= 600;

  double scaledFont(double baseSize, {double min = 11.0, double max = 42.0}) =>
      (baseSize * screenScale).clamp(min, max);
  double scaledSpace(double baseValue) => baseValue * screenScale;
}
