import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Label kecil berwarna untuk kategori (Blok, Mob, Item, Biome).
class CategoryBadge extends StatelessWidget {
  const CategoryBadge(this.category, {super.key});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.categoryColor(category),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Text(
        category,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
