import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Judul bagian dengan penanda hijau di kiri.
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 12),
      child: Row(
        children: [
          Container(width: 8, height: 22, color: AppColors.grass),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.text),
            ),
          ),
        ],
      ),
    );
  }
}
