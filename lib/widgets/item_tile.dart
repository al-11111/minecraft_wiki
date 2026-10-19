import 'package:flutter/material.dart';

import '../models/minecraft_item.dart';
import '../services/data_service.dart';
import '../screens/detail_screen.dart';
import '../theme/app_theme.dart';
import '../theme/icon_map.dart';
import 'block_icon.dart';
import 'category_badge.dart';
import 'pixel_card.dart';

/// Baris horizontal untuk daftar vertikal (ikon, nama, kategori, tombol info).
class ItemTile extends StatelessWidget {
  const ItemTile({super.key, required this.item, required this.data});

  final MinecraftItem item;
  final AppData data;

  @override
  Widget build(BuildContext context) {
    return PixelCard(
      onTap: () => openDetail(context, data, item),
      child: Row(
        children: [
          BlockIcon(color: item.color, icon: iconFor(item.icon), size: 56),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.text),
                ),
                const SizedBox(height: 4),
                CategoryBadge(item.category),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, color: AppColors.muted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.gold,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: const Text('Info',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
