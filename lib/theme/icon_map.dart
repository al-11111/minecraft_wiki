import 'package:flutter/material.dart';

/// Memetakan nama ikon di JSON menjadi [IconData] Material.
IconData iconFor(String key) {
  const map = <String, IconData>{
    'grass': Icons.grass,
    'diamond': Icons.diamond,
    'square': Icons.square,
    'fire': Icons.local_fire_department,
    'handyman': Icons.handyman,
    'park': Icons.park,
    'warning': Icons.warning_amber,
    'person': Icons.person,
    'visibility': Icons.visibility,
    'face': Icons.face,
    'flight': Icons.flight,
    'hardware': Icons.hardware,
    'apple': Icons.apple,
    'glide': Icons.flight_takeoff,
    'shield': Icons.shield,
    'circle': Icons.circle,
    'lightbulb': Icons.lightbulb,
    'landscape': Icons.landscape,
    'sun': Icons.wb_sunny,
    'whatshot': Icons.whatshot,
  };
  return map[key] ?? Icons.category;
}
