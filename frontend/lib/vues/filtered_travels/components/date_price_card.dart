import 'package:flutter/material.dart';
import '../../../color.dart';

class DatePriceCard extends StatelessWidget {
  final DateTime date;
  final double? minPrice;
  final bool isSelected;
  final String weekDay;
  final int dayNum;
  final VoidCallback onTap;

  const DatePriceCard({
    super.key,
    required this.date,
    required this.minPrice,
    required this.isSelected,
    required this.weekDay,
    required this.dayNum,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondary : AppColors.card,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$weekDay $dayNum',
              style: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            minPrice != null
                ? Text(
                    '${minPrice!.toStringAsFixed(2).replaceAll('.00', '')} €',
                    style: TextStyle(
                      color: isSelected ? AppColors.primary : AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )
                : Text(
                    '-',
                    style: TextStyle(
                      color: isSelected ? AppColors.primary : AppColors.white,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
