import 'package:flutter/material.dart';

/// Colors taken from the reference screenshot:
/// soft blue-grey backdrop, warm off-white screens, deep navy actions.
class AppColors {
  static const navy = Color(0xFF1E2A47);
  static const background = Color(0xFFF4F2EE); // warm off-white screen
  static const backdrop = Color(0xFFD9E4EE); // pale blue-grey
  static const card = Colors.white;
  static const accent = Color(0xFFCFE0F1); // light blue chip / tile
  static const muted = Color(0xFF7A8499);
  static const urgent = Color(0xFFD9534F);
}

class AppTheme {
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.navy,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.navy,
      onPrimary: Colors.white,
      secondaryContainer: AppColors.accent,
      onSecondaryContainer: AppColors.navy,
      surface: AppColors.background,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.navy,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.navy,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: const StadiumBorder(),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: AppColors.accent,
      ),
    );
  }
}
