import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:faseeh_kids/core/utils/age_group.dart';

/// Faseeh Kids App Typography
/// Uses Cairo font for Arabic-optimized UI text
/// Sizes adapt based on child's age group
class AppTypography {
  AppTypography._();

  // ═══════════════════════════════════════════
  // 📏 SIZE CONSTANTS BY AGE GROUP
  // ═══════════════════════════════════════════

  // Preschool (3-5): Larger touch targets, bigger text
  static const double _h1Preschool = 32.0;
  static const double _h2Preschool = 24.0;
  static const double _bodyPreschool = 20.0;
  static const double _buttonPreschool = 18.0;
  static const double _captionPreschool = 14.0;

  // Emerging (6-8) & Independent (9-10): Standard sizes
  static const double _h1Standard = 28.0;
  static const double _h2Standard = 22.0;
  static const double _bodyStandard = 16.0;
  static const double _buttonStandard = 16.0;
  static const double _captionStandard = 12.0;

  // ═══════════════════════════════════════════
  // 🔤 TEXT STYLE BUILDERS
  // ═══════════════════════════════════════════

  /// Heading 1 — main screen titles
  static TextStyle h1({
    AgeGroup ageGroup = AgeGroup.preschool3to5,
    Color? color,
  }) {
    final size = ageGroup == AgeGroup.preschool3to5
        ? _h1Preschool
        : _h1Standard;
    return GoogleFonts.cairo(
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: color,
      height: 1.3,
    );
  }

  /// Heading 2 — section titles, card headings
  static TextStyle h2({
    AgeGroup ageGroup = AgeGroup.preschool3to5,
    Color? color,
  }) {
    final size = ageGroup == AgeGroup.preschool3to5
        ? _h2Preschool
        : _h2Standard;
    return GoogleFonts.cairo(
      fontSize: size,
      fontWeight: FontWeight.w600,
      color: color,
      height: 1.4,
    );
  }

  /// Body — regular content text
  static TextStyle body({
    AgeGroup ageGroup = AgeGroup.preschool3to5,
    Color? color,
  }) {
    final size = ageGroup == AgeGroup.preschool3to5
        ? _bodyPreschool
        : _bodyStandard;
    return GoogleFonts.cairo(
      fontSize: size,
      fontWeight: FontWeight.w400,
      color: color,
      height: 1.5,
    );
  }

  /// Button — button labels
  static TextStyle button({
    AgeGroup ageGroup = AgeGroup.preschool3to5,
    Color? color,
  }) {
    final size = ageGroup == AgeGroup.preschool3to5
        ? _buttonPreschool
        : _buttonStandard;
    return GoogleFonts.cairo(
      fontSize: size,
      fontWeight: FontWeight.w600,
      color: color,
      height: 1.2,
    );
  }

  /// Caption — small labels, hints, metadata
  static TextStyle caption({
    AgeGroup ageGroup = AgeGroup.preschool3to5,
    Color? color,
  }) {
    final size = ageGroup == AgeGroup.preschool3to5
        ? _captionPreschool
        : _captionStandard;
    return GoogleFonts.cairo(
      fontSize: size,
      fontWeight: FontWeight.w400,
      color: color,
      height: 1.4,
    );
  }

  /// Arabic Letter Display — oversized for letter learning screens
  static TextStyle arabicLetterDisplay({Color? color}) {
    return GoogleFonts.cairo(
      fontSize: 96.0,
      fontWeight: FontWeight.w700,
      color: color,
      height: 1.1,
    );
  }

  /// Arabic Word Display — for word learning and reading
  static TextStyle arabicWordDisplay({Color? color}) {
    return GoogleFonts.cairo(
      fontSize: 48.0,
      fontWeight: FontWeight.w600,
      color: color,
      height: 1.3,
    );
  }
}
