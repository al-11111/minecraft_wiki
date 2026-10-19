import 'package:flutter/material.dart';

/// Palet warna bertema Minecraft (rumput, tanah, batu, emas).
class AppColors {
  static const bg = Color(0xFF1E1E1E);
  static const panel = Color(0xFF2F4F2A);
  static const surface = Color(0xFF3A3A3A);
  static const grass = Color(0xFF5D9B3A);
  static const gold = Color(0xFFF9C74F);
  static const dirt = Color(0xFF7B5333);
  static const text = Color(0xFFF2F2F2);
  static const muted = Color(0xFFB8B8B8);

  static Color categoryColor(String c) {
    switch (c) {
      case 'Blok':
        return const Color(0xFF5D9B3A);
      case 'Mob':
        return const Color(0xFFB3412F);
      case 'Item':
        return const Color(0xFF3A7CA5);
      case 'Biome':
        return const Color(0xFF9C7A3C);
      default:
        return const Color(0xFF6B6B6B);
    }
  }

  static IconData categoryIcon(String c) {
    switch (c) {
      case 'Blok':
        return Icons.view_in_ar;
      case 'Mob':
        return Icons.pets;
      case 'Item':
        return Icons.construction;
      case 'Biome':
        return Icons.terrain;
      default:
        return Icons.category;
    }
  }
}

ThemeData buildTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'monospace',
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.grass,
      secondary: AppColors.gold,
      surface: AppColors.surface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.panel,
      foregroundColor: AppColors.text,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'monospace',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.text,
      ),
    ),
  );
}
