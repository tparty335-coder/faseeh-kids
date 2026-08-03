import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Faseeh Kids Theme Configuration
/// Builds Material ThemeData for Day and Night modes
/// RTL-first design for Arabic learning
class AppTheme {
  AppTheme._();

  /// Day Mode Theme
  static ThemeData get dayTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryDay,
      scaffoldBackgroundColor: AppColors.backgroundDay,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryDay,
        secondary: AppColors.secondaryDay,
        tertiary: AppColors.accentDay,
        surface: AppColors.surfaceDay,
        error: AppColors.errorDay,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimaryDay,
        onError: Colors.white,
      ),
      textTheme: GoogleFonts.cairoTextTheme().apply(
        bodyColor: AppColors.textPrimaryDay,
        displayColor: AppColors.textPrimaryDay,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textPrimaryDay),
        titleTextStyle: TextStyle(
          color: AppColors.textPrimaryDay,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDay,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceDay,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.borderDay,
        thickness: 1,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.textPrimaryDay,
      ),
    );
  }

  /// Night Mode Theme
  static ThemeData get nightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryNight,
      scaffoldBackgroundColor: AppColors.backgroundNight,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryNight,
        secondary: AppColors.secondaryNight,
        tertiary: AppColors.accentNight,
        surface: AppColors.surfaceNight,
        error: AppColors.errorNight,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimaryNight,
        onError: Colors.white,
      ),
      textTheme: GoogleFonts.cairoTextTheme(
        ThemeData.dark().textTheme,
      ).apply(
        bodyColor: AppColors.textPrimaryNight,
        displayColor: AppColors.textPrimaryNight,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textPrimaryNight),
        titleTextStyle: TextStyle(
          color: AppColors.textPrimaryNight,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryNight,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceNight,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.borderNight,
        thickness: 1,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.textPrimaryNight,
      ),
    );
  }
}
