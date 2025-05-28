import 'package:flutter/material.dart';
import '../../../color.dart';

class StepCircle extends StatelessWidget {
  final String time;
  final String title;
  final String subtitle;
  final bool isTop;

  const StepCircle({
    super.key,
    required this.time,
    required this.title,
    required this.subtitle,
    required this.isTop,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heure dans bulle
        Container(
          margin: EdgeInsets.only(top: isTop ? 0 : 40),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Text(
            time,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 14),
        // Cercle noir
        Container(
          margin: EdgeInsets.only(top: isTop ? 0 : 40),
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 3),
          ),
        ),
        SizedBox(width: 14),
        // Infos
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: isTop ? 0 : 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
} 