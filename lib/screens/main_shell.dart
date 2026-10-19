import 'package:flutter/material.dart';

import '../services/data_service.dart';
import '../theme/app_theme.dart';
import 'crafting_screen.dart';
import 'explore_screen.dart';
import 'home_screen.dart';

/// Kerangka utama dengan BottomNavigationBar (Beranda, Jelajah, Crafting).
class MainShell extends StatefulWidget {
  const MainShell({super.key, required this.data});

  final AppData data;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  String _category = 'Semua';
  int _exploreVersion = 0; // dinaikkan agar halaman Jelajah dibangun ulang dengan kategori baru

  void _goExplore(String category) {
    setState(() {
      _category = category;
      _exploreVersion++;
      _index = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          HomeScreen(data: widget.data, onCategory: _goExplore),
          ExploreScreen(
            key: ValueKey(_exploreVersion),
            data: widget.data,
            initialCategory: _category,
          ),
          CraftingScreen(data: widget.data),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black, width: 3))),
        child: BottomNavigationBar(
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          backgroundColor: AppColors.panel,
          selectedItemColor: AppColors.gold,
          unselectedItemColor: AppColors.muted,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
            BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Jelajah'),
            BottomNavigationBarItem(icon: Icon(Icons.handyman), label: 'Crafting'),
          ],
        ),
      ),
    );
  }
}
