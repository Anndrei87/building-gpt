import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    required this.label,
    super.key,
    this.fontSize = 18,
    this.color,
    this.fontWeight,
  });

  final String label;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        label,
        style: TextStyle(
          color: color ?? Colors.white,
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
      ),
    );
  }
}
