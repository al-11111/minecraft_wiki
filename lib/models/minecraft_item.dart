import 'package:flutter/material.dart';

/// Mengubah string hex seperti "#5D9B3A" menjadi [Color].
Color hexToColor(String hex) {
  final h = hex.replaceAll('#', '');
  return Color(int.parse('FF$h', radix: 16));
}

/// Model data untuk satu entri Minecraft (blok, mob, item, atau biome).
/// Memiliki [fromJson] dan [toJson] agar mudah diganti sumber datanya
/// dari file JSON lokal menjadi respons API server.
class MinecraftItem {
  final String id;
  final String name;
  final String category;
  final String description;
  final String colorHex;
  final String icon;
  final Map<String, String> stats;
  final List<String> tips;

  const MinecraftItem({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.colorHex,
    required this.icon,
    required this.stats,
    required this.tips,
  });

  factory MinecraftItem.fromJson(Map<String, dynamic> json) => MinecraftItem(
        id: json['id'] as String,
        name: json['name'] as String,
        category: json['category'] as String,
        description: json['description'] as String,
        colorHex: json['color'] as String,
        icon: json['icon'] as String,
        stats: Map<String, String>.from(json['stats'] as Map),
        tips: List<String>.from(json['tips'] as List),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'description': description,
        'color': colorHex,
        'icon': icon,
        'stats': stats,
        'tips': tips,
      };

  Color get color => hexToColor(colorHex);
}
