import 'package:flutter/material.dart';
import 'package:hi_bob/core/ui/theme/font_style.dart';

enum AppColors {
  primary(
    Color(0xFF58CC02),
    Color(0xFFFFFFFF),
  ),
  secondary(
    Color(0xFF1899DC),
    Color(0xFFFFFFFF),
  ),
  tertiary(
    Color(0xFFFFC800),
    Color(0xFFFFFFFF),
  );

  const AppColors(
    this.color,
    this.onColor,
  );

  final Color color;
  final Color onColor;
}

ColorScheme lightColorScheme = ColorScheme.fromSeed(
  seedColor: AppColors.primary.color,
  primary: AppColors.primary.color,
  onPrimary: AppColors.primary.onColor,
  tertiary: AppColors.tertiary.color,
  onTertiary: AppColors.tertiary.onColor,
  secondary: AppColors.secondary.color,
  onSecondary: AppColors.secondary.onColor,
);

ColorScheme darkColorScheme = ColorScheme.fromSeed(
  seedColor: AppColors.primary.color,
  primary: AppColors.primary.color,
  onPrimary: AppColors.primary.onColor,
  tertiary: AppColors.tertiary.color,
  onTertiary: AppColors.tertiary.onColor,
  secondary: AppColors.secondary.color,
  onSecondary: AppColors.secondary.onColor,
);

final appLightTheme = ThemeData(
  useMaterial3: true,
  textTheme: appTextTheme,
  colorScheme: lightColorScheme,
  brightness: Brightness.light,
);

final darkTheme = ThemeData(
  useMaterial3: true,
  textTheme: appTextTheme,
  colorScheme: darkColorScheme,
  brightness: Brightness.dark,
);
