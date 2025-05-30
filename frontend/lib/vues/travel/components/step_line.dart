import 'package:flutter/material.dart';
import '../../../color.dart';

class StepLine extends StatelessWidget {
  final double? height;
  final Color color;

  const StepLine({super.key, this.height, this.color = AppColors.secondary});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(32),
      ),
    );
  }
}
