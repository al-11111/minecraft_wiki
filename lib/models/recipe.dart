/// Bahan dalam resep crafting.
class Ingredient {
  final String name;
  final String colorHex;

  const Ingredient({required this.name, required this.colorHex});

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        name: json['name'] as String,
        colorHex: json['color'] as String,
      );
}

/// Resep crafting 3x3. [pattern] berisi 3 string, tiap karakter mewakili
/// satu bahan (lihat [ingredients]); spasi berarti slot kosong.
/// [resultItemId] menghubungkan resep ke data item (halaman detail).
class Recipe {
  final String id;
  final String name;
  final String resultItemId;
  final int resultCount;
  final List<String> pattern;
  final Map<String, Ingredient> ingredients;
  final String description;

  const Recipe({
    required this.id,
    required this.name,
    required this.resultItemId,
    required this.resultCount,
    required this.pattern,
    required this.ingredients,
    required this.description,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json['id'] as String,
        name: json['name'] as String,
        resultItemId: json['resultItemId'] as String,
        resultCount: json['resultCount'] as int,
        pattern: List<String>.from(json['pattern'] as List),
        ingredients: (json['ingredients'] as Map<String, dynamic>).map(
          (k, v) => MapEntry(k, Ingredient.fromJson(v as Map<String, dynamic>)),
        ),
        description: json['description'] as String,
      );
}
