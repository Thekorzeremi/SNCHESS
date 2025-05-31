import 'package:flutter/material.dart';
import '../../../color.dart';

class TravelerCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool selected;
  const TravelerCard({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 125,
        height: 90,
        decoration: BoxDecoration(
          color: selected
              ? AppColors.secondary.withOpacity(0.4)
              : AppColors.card,
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
                      color: selected ? Colors.lightGreen : AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(2),
                    child: Icon(
                      selected ? Icons.check : Icons.add,
                      color: selected ? Colors.white : AppColors.primary,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(label, style: TextStyle(color: AppColors.white)),
          ],
        ),
      ),
    );
  }
}
