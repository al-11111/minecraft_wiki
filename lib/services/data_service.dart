import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/minecraft_item.dart';
import '../models/recipe.dart';

/// Kumpulan seluruh data aplikasi.
class AppData {
  final List<MinecraftItem> items;
  final List<Recipe> recipes;

  const AppData({required this.items, required this.recipes});

  /// Daftar kategori unik sesuai urutan kemunculan di data.
  List<String> get categories => items.map((e) => e.category).toSet().toList();

  MinecraftItem? itemById(String id) {
    for (final i in items) {
      if (i.id == id) return i;
    }
    return null;
  }

  Recipe? recipeForItem(String itemId) {
    for (final r in recipes) {
      if (r.resultItemId == itemId) return r;
    }
    return null;
  }
}

/// Sumber data. Saat ini membaca file JSON lokal (data dummy).
///
/// Untuk tahap berikutnya (API), cukup ganti isi [load] dengan
/// `http.get(Uri.parse('https://api.contoh.com/minecraft'))` lalu
/// `jsonDecode(response.body)`. Model dan UI tidak perlu diubah.
class DataService {
  static Future<AppData> load() async {
    final raw = await rootBundle.loadString('assets/data/minecraft.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return AppData(
      items: (json['items'] as List)
          .map((e) => MinecraftItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      recipes: (json['recipes'] as List)
          .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
