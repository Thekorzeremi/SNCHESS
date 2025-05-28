import 'package:flutter/material.dart';
import '../../../color.dart';

class TravelerCard extends StatelessWidget {
  final IconData icon;
  final String label;
  const TravelerCard({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 90,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Icon(icon, color: AppColors.white, size: 36),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(2),
                  child: Icon(Icons.add, color: AppColors.primary, size: 16),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(color: AppColors.white)),
        ],
      ),
    );
  }
} 