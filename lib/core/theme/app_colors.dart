import 'package:flutter/material.dart';

/// Faseeh Kids App Color Palette
/// Designed for children's educational app with desert oasis theme
/// Supports Day Mode and Night Mode
class AppColors {
  AppColors._();

  // ═══════════════════════════════════════════
  // ☀️ DAY MODE COLORS
  // ═══════════════════════════════════════════

  /// Warm sand/orange — primary actions, buttons, mascot accent
  static const Color primaryDay = Color(0xFFFFB347);

  /// Sky blue — secondary elements, links, progress indicators
  static const Color secondaryDay = Color(0xFF42A5F5);

  /// Oasis green — success states, nature elements, correct answers
  static const Color accentDay = Color(0xFF81C784);

  /// Warm cream — app background
  static const Color backgroundDay = Color(0xFFFFF9E6);

  /// White — card and surface backgrounds
  static const Color surfaceDay = Color(0xFFFFFFFF);

  /// Near-black — primary text (headings, body)
  static const Color textPrimaryDay = Color(0xFF212121);

  /// Medium gray — secondary text (hints, labels)
  static const Color textSecondaryDay = Color(0xFF757575);

  /// Green — success feedback
  static const Color successDay = Color(0xFF4CAF50);

  /// Red — error feedback (gentle for kids)
  static const Color errorDay = Color(0xFFF44336);

  /// Amber — warning feedback
  static const Color warningDay = Color(0xFFFFC107);

  /// Light gray — disabled state
  static const Color disabledDay = Color(0xFFE0E0E0);

  /// Very light gray — borders and dividers
  static const Color borderDay = Color(0xFFEEEEEE);

  // ═══════════════════════════════════════════
  // 🌙 NIGHT MODE COLORS
  // ═══════════════════════════════════════════

  /// Darker warm sand — primary in night mode
  static const Color primaryNight = Color(0xFFD98C2E);

  /// Deeper blue — secondary in night mode
  static const Color secondaryNight = Color(0xFF1E88E5);

  /// Deeper green — accent in night mode
  static const Color accentNight = Color(0xFF66BB6A);

  /// True dark — app background in night mode
  static const Color backgroundNight = Color(0xFF121212);

  /// Dark surface — card backgrounds in night mode
  static const Color surfaceNight = Color(0xFF1E1E1E);

  /// Near-white — primary text in night mode
  static const Color textPrimaryNight = Color(0xFFF5F5F5);

  /// Light gray — secondary text in night mode
  static const Color textSecondaryNight = Color(0xFFBDBDBD);

  /// Darker green — success in night mode
  static const Color successNight = Color(0xFF388E3C);

  /// Darker red — error in night mode
  static const Color errorNight = Color(0xFFD32F2F);

  /// Darker amber — warning in night mode
  static const Color warningNight = Color(0xFFFFA000);

  /// Dark gray — disabled in night mode
  static const Color disabledNight = Color(0xFF424242);

  /// Very dark gray — borders in night mode
  static const Color borderNight = Color(0xFF333333);

  // ═══════════════════════════════════════════
  // 🎨 SPECIAL / GAMIFICATION COLORS
  // ═══════════════════════════════════════════

  /// Gold — stars, coins, achievements
  static const Color gold = Color(0xFFFFD700);

  /// Bronze — lower-tier achievements
  static const Color bronze = Color(0xFFCD7F32);

  /// Silver — mid-tier achievements
  static const Color silver = Color(0xFFC0C0C0);

  /// Streak flame color
  static const Color streakFlame = Color(0xFFFF6B35);

  /// XP / level-up color
  static const Color xpGreen = Color(0xFF00E676);

  // ═══════════════════════════════════════════
  // 🏷️ SEMANTIC ALIASES (for convenience)
  // ═══════════════════════════════════════════

  /// Desert sand — alias for primaryDay
  static const Color desertSand = primaryDay;

  /// Sky blue — alias for secondaryDay
  static const Color skyBlue = secondaryDay;

  /// Oasis green — alias for accentDay
  static const Color oasisGreen = accentDay;

  /// Cream background — alias for backgroundDay
  static const Color creamBackground = backgroundDay;

  /// Text primary — alias for textPrimaryDay
  static const Color textPrimary = textPrimaryDay;

  /// Text secondary — alias for textSecondaryDay
  static const Color textSecondary = textSecondaryDay;

  /// Success — alias for successDay
  static const Color success = successDay;

  /// Error — alias for errorDay
  static const Color error = errorDay;

  /// Warning — alias for warningDay
  static const Color warning = warningDay;

  /// Surface — alias for surfaceDay
  static const Color surface = surfaceDay;

  /// Disabled — alias for disabledDay
  static const Color disabled = disabledDay;

  /// Border — alias for borderDay
  static const Color border = borderDay;

  /// Primary — short alias for primaryDay
  static const Color primary = primaryDay;

  /// Secondary — short alias for secondaryDay
  static const Color secondary = secondaryDay;

  /// Background — alias for backgroundDay
  static const Color background = backgroundDay;

  /// Background cream — alias for backgroundDay
  static const Color backgroundCream = backgroundDay;

  /// Sand warm — alias for primaryDay
  static const Color sandWarm = primaryDay;

  /// Accent — alias for accentDay
  static const Color accent = accentDay;
}
