import 'package:flutter/material.dart';
import '../../../color.dart';
import 'step_circle.dart';
import 'step_line.dart';

class TravelDetails extends StatelessWidget {
  final Map<String, dynamic> tram;
  final Map<String, dynamic> travelData;
  final Map<String, dynamic> gareDepart;
  final Map<String, dynamic> gareArrivee;
  final String arrivalHour;

  const TravelDetails({
    super.key,
    required this.tram,
    required this.travelData,
    required this.gareDepart,
    required this.gareArrivee,
    required this.arrivalHour,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.primary),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.train, color: AppColors.secondary),
              SizedBox(width: 8),
              Text(
                tram['name'],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(top: 40),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${travelData['duration']}',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                Positioned(left: 66, top: 0, bottom: 32, child: StepLine()),
                Positioned(
                  top: 4,
                  left: 0,
                  right: 0,
                  child: StepCircle(
                    time: travelData['departureHour'],
                    title: gareDepart['name'],
                    subtitle: 'Accès de plain-pied ou par ascenseur',
                    isTop: true,
                  ),
                ),
                Positioned(
                  top: 160,
                  left: 0,
                  right: 0,
                  child: StepCircle(
                    time: arrivalHour,
                    title: gareArrivee['name'],
                    subtitle: 'Accès de plain-pied ou par ascenseur',
                    isTop: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
