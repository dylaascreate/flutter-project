import 'package:flutter/material.dart';

class ColorCircle extends StatelessWidget {
  final Color color;
  final double size;

  const ColorCircle({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black),
      ), // BoxDecoration
    );
  }
// Container
}