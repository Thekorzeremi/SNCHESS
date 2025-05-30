import 'package:flutter/material.dart';
import '../../../color.dart';

class TravelAlertInfo extends StatelessWidget {
  const TravelAlertInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Icon(Icons.sms_failed, color: Colors.pinkAccent, size: 28),
                  Text(
                    '3117',
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Numéro d'alerte 3117",
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Un risque pour votre sécurité ou celle des autres ?',
                    style: TextStyle(color: AppColors.white, fontSize: 13),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.secondary, size: 28),
          ],
        ),
      ),
    );
  }
}
