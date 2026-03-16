import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Theme Palette
  static const Color primary = Color(0xff166534); // g700
  static const Color secondary = Color(0xff22c55e); // g500
  static const Color accent = Color(0xfff97316); // coral
  
  // Backgrounds
  static const Color background = Color(0xfff9fafb); // gray50
  static const Color surface = Colors.white;
  static const Color sidebar = Color(0xff0a2e1a); // g900
  
  // Text
  static const Color textMain = Color(0xff1f2937); // gray800
  static const Color textDim = Color(0xff6b7280); // gray500
  static const Color textInverted = Colors.white;
  
  // Accents & Border
  static const Color border = Color(0xffe5e7eb); // gray200
  static const Color success = Color(0xff22c55e);
  static const Color warning = Color(0xfffacc15);
  static const Color error = Color(0xffef4444);

  // Consolidated from User App for compatibility
  static const Color g900 = Color(0xff0a2e1a);
  static const Color g800 = Color(0xff14532d);
  static const Color g700 = Color(0xff166534);
  static const Color g600 = Color(0xff16a34a);
  static const Color g500 = Color(0xff22c55e);
  static const Color g400 = Color(0xff4ade80);
  static const Color g300 = Color(0xff86efac);
  static const Color g200 = Color(0xffbbf7d0);
  static const Color g100 = Color(0xffdcfce7);
  static const Color g50 = Color(0xfff0fdf4);
  
  static const Color black = Color(0xff0f1a0f);
  static const Color white = Colors.white;
  
  static const Color gray800 = Color(0xff1f2937);
  static const Color gray700 = Color(0xff374151);
  static const Color gray600 = Color(0xff4b5563);
  static const Color gray400 = Color(0xff9ca3af);
  static const Color gray200 = Color(0xffe5e7eb);
  static const Color gray100 = Color(0xfff3f4f6);
  static const Color gray50 = Color(0xfff9fafb);
}

class AppTheme {
  static ThemeData get dashTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.nunitoTextTheme().copyWith(
        displayLarge: GoogleFonts.fraunces(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.textMain,
        ),
        titleLarge: GoogleFonts.fraunces(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.textMain,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
      ),
    );
  }
}
