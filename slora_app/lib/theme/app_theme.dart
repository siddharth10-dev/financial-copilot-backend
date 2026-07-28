import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.darkSlate,
      primaryColor: AppColors.vibrantYellow,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.vibrantYellow,
        secondary: AppColors.purple,
        surface: AppColors.darkSlate,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData.dark().textTheme,
      ),
      useMaterial3: true,
    );
  }
}
