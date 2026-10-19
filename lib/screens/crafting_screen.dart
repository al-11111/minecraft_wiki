import 'package:flutter/material.dart';

import '../services/data_service.dart';
import '../widgets/recipe_card.dart';
import 'detail_screen.dart';

/// Halaman resep crafting. Ketuk hasil resep untuk membuka detail item-nya.
class CraftingScreen extends StatelessWidget {
  const CraftingScreen({super.key, required this.data});

  final AppData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resep Crafting')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: data.recipes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 18),
            itemBuilder: (context, i) {
              final recipe = data.recipes[i];
              final result = data.itemById(recipe.resultItemId);
              return RecipeCard(
                recipe: recipe,
                result: result,
                onResultTap: result == null ? null : () => openDetail(context, data, result),
              );
            },
          ),
        ),
      ),
    );
  }
}
