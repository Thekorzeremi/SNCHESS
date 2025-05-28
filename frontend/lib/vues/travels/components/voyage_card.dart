import 'package:flutter/material.dart';
import '../../../color.dart';

class VoyageCard extends StatelessWidget {
  final Map<String, dynamic> voyage;
  final Map<String, dynamic> gareDepart;
  final Map<String, dynamic> gareArrivee;
  final Map<String, dynamic> tram;
  final VoidCallback onTap;

  const VoyageCard({
    Key? key,
    required this.voyage,
    required this.gareDepart,
    required this.gareArrivee,
    required this.tram,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calcul de l'heure d'arrivée
    TimeOfDay dep = TimeOfDay(
      hour: int.parse(voyage['departureHour'].split(':')[0]),
      minute: int.parse(voyage['departureHour'].split(':')[1]),
    );
    List<String> d = voyage['duration'].split(':');
    int addH = int.parse(d[0]);
    int addM = int.parse(d[1]);
    int arrH = dep.hour + addH + ((dep.minute + addM) ~/ 60);
    int arrM = (dep.minute + addM) % 60;
    String heureArrivee = '${arrH.toString().padLeft(2, '0')}:${arrM.toString().padLeft(2, '0')}';

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        color: AppColors.card,
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.train,
                color: AppColors.secondary,
                size: 42,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        voyage['departureHour'],
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        gareDepart['name'],
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        heureArrivee,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        gareArrivee['name'],
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Text(
                '${voyage['price']} €',
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
                  Icon(
                    Icons.schedule,
                    size: 18,
                    color: AppColors.secondary,
                  ),
                  SizedBox(width: 8),
                  Text(
                    voyage['duration'],
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    tram['type'],
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.white,
                    ),
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
