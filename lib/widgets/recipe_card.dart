import 'package:flutter/material.dart';

import '../models/minecraft_item.dart';
import '../models/recipe.dart';
import '../theme/app_theme.dart';
import '../theme/icon_map.dart';
import 'block_icon.dart';
import 'pixel_card.dart';

/// Kartu resep crafting: grid 3x3, panah, hasil, dan legenda bahan.
class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.recipe, this.result, this.onResultTap});

  final Recipe recipe;
  final MinecraftItem? result;
  final VoidCallback? onResultTap;

  Widget _cell(String ch) {
    final ing = recipe.ingredients[ch];
    final color = ing == null ? const Color(0xFF2A2A2A) : hexToColor(ing.colorHex);
    final fg = color.computeLuminance() > 0.5 ? Colors.black87 : Colors.white;
    return Container(
      width: 44,
      height: 44,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(color: color, border: Border.all(color: Colors.black87, width: 2)),
      child: ing == null
          ? null
          : Center(
              child: Text(ing.name[0],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: fg)),
            ),
    );
  }

  Widget _grid() {
    return Container(
      padding: const EdgeInsets.all(4),
      color: const Color(0xFF555555),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (r) {
          final row = r < recipe.pattern.length ? recipe.pattern[r] : '   ';
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (c) => _cell(c < row.length ? row[c] : ' ')),
          );
        }),
      ),
    );
  }

  Widget _result() {
    final color = result?.color ?? Colors.grey;
    final icon = result == null ? Icons.help_outline : iconFor(result!.icon);
    return GestureDetector(
      onTap: onResultTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          BlockIcon(color: color, icon: icon, size: 64),
          if (recipe.resultCount > 1)
            Positioned(
              right: -6,
              bottom: -6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                color: Colors.black,
                child: Text('x${recipe.resultCount}',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PixelCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(recipe.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.gold)),
          const SizedBox(height: 12),
          Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _grid(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Icon(Icons.arrow_forward, size: 32, color: AppColors.text),
                  ),
                  _result(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 6,
            children: recipe.ingredients.values.map((ing) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: hexToColor(ing.colorHex),
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(ing.name, style: const TextStyle(fontSize: 12)),
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Text(recipe.description, style: const TextStyle(fontSize: 12, color: AppColors.muted)),
        ],
      ),
    );
  }
}
