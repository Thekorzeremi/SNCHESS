import 'package:flutter/material.dart';
import '../../../color.dart';

class TravelCard extends StatelessWidget {
  final Map<String, dynamic> voyage;
  final Map<String, dynamic> gareDepart;
  final Map<String, dynamic> gareArrivee;
  final Map<String, dynamic> tram;
  final VoidCallback onTap;

  const TravelCard({
    super.key,
    required this.voyage,
    required this.gareDepart,
    required this.gareArrivee,
    required this.tram,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final trip = voyage['trip'] ?? {};
    final route = trip['route'] ?? {};
    final fromStation = route['fromStation'] ?? {};
    final toStation = route['toStation'] ?? {};

    final depDateTime = fromStation['datetime'] ?? '';
    final arrDateTime = toStation['datetime'] ?? '';

    String extractHour(String dt) {
      if (dt.contains(' ')) {
        return dt.split(' ').last;
      }
      return dt;
    }

    final departureHour = extractHour(depDateTime);
    final arrivalHour = extractHour(arrDateTime);

    String durationStr = '';
    if (route['duration'] != null) {
      int duration = int.tryParse(route['duration'].toString()) ?? 0;
      int h = duration ~/ 60;
      int m = duration % 60;
      durationStr = '${h}h${m.toString().padLeft(2, '0')}';
    }

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        color: AppColors.card,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.train, color: AppColors.secondary, size: 42),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        departureHour,
                        style: TextStyle(fontSize: 16, color: AppColors.white),
                      ),
                      SizedBox(width: 12),
                      Text(
                        fromStation['city'] ?? '',
                        style: TextStyle(fontSize: 16, color: AppColors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        arrivalHour,
                        style: TextStyle(fontSize: 16, color: AppColors.white),
                      ),
                      SizedBox(width: 12),
                      Text(
                        toStation['city'] ?? '',
                        style: TextStyle(fontSize: 16, color: AppColors.white),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Text(
                '${trip['price'] ?? ''} €',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                  fontSize: 22,
                ),
              ),
            ),
            Divider(color: AppColors.primary),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                children: [
                  Icon(Icons.schedule, size: 18, color: AppColors.secondary),
                  SizedBox(width: 8),
                  Text(
                    durationStr,
                    style: TextStyle(fontSize: 14, color: AppColors.white),
                  ),
                  SizedBox(width: 16),
                  Text(
                    tram['type'] ?? '',
                    style: TextStyle(fontSize: 14, color: AppColors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
