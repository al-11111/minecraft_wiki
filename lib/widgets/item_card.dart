import 'package:flutter/material.dart';

import '../models/minecraft_item.dart';
import '../services/data_service.dart';
import '../screens/detail_screen.dart';
import '../theme/app_theme.dart';
import '../theme/icon_map.dart';
import 'block_icon.dart';
import 'category_badge.dart';
import 'pixel_card.dart';

/// Kartu vertikal untuk grid/daftar horizontal. Ketuk untuk membuka detail.
class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item, required this.data});

  final MinecraftItem item;
  final AppData data;

  @override
  Widget build(BuildContext context) {
    return PixelCard(
      onTap: () => openDetail(context, data, item),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlockIcon(color: item.color, icon: iconFor(item.icon), size: 72),
          const SizedBox(height: 10),
          Text(
            item.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.text),
          ),
          const SizedBox(height: 8),
          CategoryBadge(item.category),
        ],
      ),
    );
  }
}
