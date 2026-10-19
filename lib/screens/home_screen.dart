import 'package:flutter/material.dart';

import '../services/data_service.dart';
import '../theme/app_theme.dart';
import '../theme/icon_map.dart';
import '../widgets/block_icon.dart';
import '../widgets/item_card.dart';
import '../widgets/item_tile.dart';
import '../widgets/pixel_card.dart';
import '../widgets/section_title.dart';

/// Halaman beranda: sapaan, pencarian, kategori, mob populer, tips, item pilihan.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.data, required this.onCategory});

  final AppData data;
  final void Function(String category) onCategory;

  @override
  Widget build(BuildContext context) {
    final mobs = data.items.where((e) => e.category == 'Mob').toList();
    final featured = data.items.where((e) => e.category == 'Item').take(4).toList();

    // Tips berganti setiap hari.
    final now = DateTime.now();
    final day = now.difference(DateTime(now.year)).inDays;
    final tipItem = data.items[day % data.items.length];
    final tip = tipItem.tips[day % tipItem.tips.length];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              decoration: const BoxDecoration(
                color: AppColors.panel,
                border: Border(bottom: BorderSide(color: Colors.black, width: 4)),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Selamat Datang, Steve!',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text('Apa yang mau kamu cari di dunia blok?',
                                  style: TextStyle(fontSize: 12, color: AppColors.muted)),
                            ],
                          ),
                        ),
                        const BlockIcon(color: AppColors.grass, icon: Icons.grass, size: 48),
                      ],
                    ),
                    const SizedBox(height: 16),
                    PixelCard(
                      color: const Color(0xFF1E1E1E),
                      onTap: () => onCategory('Semua'),
                      child: Row(
                        children: const [
                          Icon(Icons.search, color: AppColors.gold),
                          SizedBox(width: 10),
                          Text('Cari blok, mob, item...', style: TextStyle(color: AppColors.muted)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle('Kategori'),
                  Row(
                    children: data.categories.map((c) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: PixelCard(
                            color: AppColors.categoryColor(c),
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
                            onTap: () => onCategory(c),
                            child: Column(
                              children: [
                                Icon(AppColors.categoryIcon(c), size: 28, color: Colors.white),
                                const SizedBox(height: 6),
                                Text(c,
                                    style: const TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SectionTitle('Mob Populer'),
                ],
              ),
            ),
            SizedBox(
              height: 210,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                itemCount: mobs.length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (_, i) => SizedBox(
                  width: 150,
                  child: ItemCard(item: mobs[i], data: data),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle('Tips Hari Ini'),
                  PixelCard(
                    color: AppColors.dirt,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlockIcon(color: tipItem.color, icon: iconFor(tipItem.icon), size: 40),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tipItem.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, color: AppColors.gold)),
                              const SizedBox(height: 4),
                              Text(tip, style: const TextStyle(fontSize: 13)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SectionTitle('Item Pilihan'),
                  ...featured.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: ItemTile(item: e, data: data),
                      )),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
