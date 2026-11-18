import 'package:flutter/material.dart';

abstract final class AppColors {
  static const navy = Color(0xFF102C46);
  static const green = Color(0xFF136B50);
  static const mint = Color(0xFFDFF3E9);
  static const background = Color(0xFFF5F7FA);
  static const muted = Color(0xFF526577);
}

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.green,
    primary: AppColors.green,
    secondary: AppColors.navy,
    surface: Colors.white,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.navy,
      centerTitle: false,
      scrolledUnderElevation: 0,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w800,
        letterSpacing: -1,
        color: AppColors.navy,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        letterSpacing: -.7,
        color: AppColors.navy,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.navy,
      ),
      titleMedium: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: AppColors.navy,
      ),
      bodyLarge: TextStyle(fontSize: 16, height: 1.5, color: AppColors.navy),
      bodyMedium: TextStyle(fontSize: 14, height: 1.5, color: AppColors.muted),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: const BorderSide(color: Color(0xFFE2E8EE)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.all(18),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(48, 54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(minimumSize: const Size(48, 50)),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: AppColors.mint,
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}
