import 'package:flutter/material.dart';

/// Kotak berwarna dengan efek bevel (sisi terang & gelap) seperti blok Minecraft.
class BlockIcon extends StatelessWidget {
  const BlockIcon({
    super.key,
    required this.color,
    required this.icon,
    this.size = 56,
  });

  final Color color;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    final hsl = HSLColor.fromColor(color);
    final light =
        hsl.withLightness((hsl.lightness + 0.18).clamp(0.0, 1.0).toDouble()).toColor();
    final dark =
        hsl.withLightness((hsl.lightness - 0.18).clamp(0.0, 1.0).toDouble()).toColor();
    final bevel = size * 0.09;
    final fg = color.computeLuminance() > 0.5 ? Colors.black87 : Colors.white;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        border: Border(
          top: BorderSide(color: light, width: bevel),
          left: BorderSide(color: light, width: bevel),
          right: BorderSide(color: dark, width: bevel),
          bottom: BorderSide(color: dark, width: bevel),
        ),
      ),
      child: Icon(icon, size: size * 0.55, color: fg),
    );
  }
}
