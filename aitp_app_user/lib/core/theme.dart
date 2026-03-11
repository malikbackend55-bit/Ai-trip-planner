import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
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
  
  static const Color sand = Color(0xfffefce8);
  static const Color earth = Color(0xff92400e);
  static const Color sky = Color(0xff0ea5e9);
  static const Color coral = Color(0xfff97316);
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
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.g600,
        primary: AppColors.g600,
        secondary: AppColors.g700,
        surface: AppColors.white,
      ),
      textTheme: GoogleFonts.nunitoTextTheme().copyWith(
        displayLarge: GoogleFonts.fraunces(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.g900,
        ),
        displayMedium: GoogleFonts.fraunces(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.g900,
        ),
        titleLarge: GoogleFonts.nunito(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: AppColors.gray800,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.g600,
          foregroundColor: AppColors.white,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
        ),
      ),
    );
  }
}
