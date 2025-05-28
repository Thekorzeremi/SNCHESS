import 'package:flutter/material.dart';
import '../../../color.dart';

class TravelCO2Info extends StatelessWidget {
  final String co2Text;
  const TravelCO2Info({Key? key, required this.co2Text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        decoration: BoxDecoration(
          color: AppColors.card,
          border: Border.all(color: Colors.lightGreenAccent, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.eco, color: Colors.lightGreenAccent, size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                co2Text,
                style: TextStyle(color: AppColors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 