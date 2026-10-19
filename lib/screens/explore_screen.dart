import 'package:flutter/material.dart';

import '../services/data_service.dart';
import '../theme/app_theme.dart';
import '../widgets/item_card.dart';

/// Halaman daftar: pencarian + filter kategori + grid responsif.
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key, required this.data, this.initialCategory = 'Semua'});

  final AppData data;
  final String initialCategory;

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late String _category = widget.initialCategory;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final categories = ['Semua', ...widget.data.categories];
    final filtered = widget.data.items.where((i) {
      final okCat = _category == 'Semua' || i.category == _category;
      final okQuery = i.name.toLowerCase().contains(_query.toLowerCase());
      return okCat && okQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Minecraft')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  onChanged: (v) => setState(() => _query = v),
                  decoration: const InputDecoration(
                    hintText: 'Cari nama...',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: Colors.black, width: 3),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: Colors.black, width: 3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: AppColors.gold, width: 3),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: categories.map((c) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(c),
                        selected: _category == c,
                        showCheckmark: false,
                        selectedColor: AppColors.grass,
                        backgroundColor: AppColors.surface,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 2),
                        ),
                        onSelected: (_) => setState(() => _category = c),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: filtered.isEmpty
                    ? const Center(
                        child: Text('Tidak ada hasil.', style: TextStyle(color: AppColors.muted)),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          mainAxisExtent: 200,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                        ),
                        itemCount: filtered.length,
                        itemBuilder: (_, i) => ItemCard(item: filtered[i], data: widget.data),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
