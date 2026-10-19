import 'package:flutter/material.dart';

import '../models/minecraft_item.dart';
import '../services/data_service.dart';
import '../theme/app_theme.dart';
import '../theme/icon_map.dart';
import '../widgets/block_icon.dart';
import '../widgets/category_badge.dart';
import '../widgets/pixel_card.dart';
import '../widgets/recipe_card.dart';
import '../widgets/section_title.dart';

/// Membuka halaman detail dengan Navigator.push.
void openDetail(BuildContext context, AppData data, MinecraftItem item) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => DetailScreen(item: item, data: data)),
  );
}

/// Halaman detail: deskripsi, statistik, tips, resep (jika ada), dan item terkait.
class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.item, required this.data});

  final MinecraftItem item;
  final AppData data;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _fav = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final data = widget.data;
    final recipe = data.recipeForItem(item.id);
    final related = data.items
        .where((e) => e.category == item.category && e.id != item.id)
        .take(6)
        .toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 230,
            backgroundColor: AppColors.panel,
            actions: [
              IconButton(
                tooltip: 'Favorit',
                icon: Icon(
                  _fav ? Icons.favorite : Icons.favorite_border,
                  color: _fav ? Colors.redAccent : null,
                ),
                onPressed: () => setState(() => _fav = !_fav),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(item.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [item.color, AppColors.bg],
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: BlockIcon(color: item.color, icon: iconFor(item.icon), size: 110),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(alignment: Alignment.centerLeft, child: CategoryBadge(item.category)),
                      const SectionTitle('Deskripsi'),
                      PixelCard(child: Text(item.description, style: const TextStyle(height: 1.4))),
                      const SectionTitle('Statistik'),
                      PixelCard(
                        child: Column(
                          children: item.stats.entries.map((e) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: Text(e.key,
                                        style: const TextStyle(color: AppColors.gold, fontSize: 13)),
                                  ),
                                  Expanded(child: Text(e.value, style: const TextStyle(fontSize: 13))),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SectionTitle('Tips'),
                      PixelCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: item.tips.map((t) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.check_box, size: 18, color: AppColors.grass),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(t, style: const TextStyle(fontSize: 13))),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      if (recipe != null) ...[
                        const SectionTitle('Resep Crafting'),
                        RecipeCard(recipe: recipe, result: item),
                      ],
                      if (related.isNotEmpty) ...[
                        SectionTitle('Lainnya di ${item.category}'),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: related.map((r) {
                            return PixelCard(
                              padding: const EdgeInsets.all(8),
                              onTap: () => openDetail(context, data, r),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  BlockIcon(color: r.color, icon: iconFor(r.icon), size: 30),
                                  const SizedBox(width: 8),
                                  Text(r.name, style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
