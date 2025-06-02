import 'package:flutter/material.dart';
import '../../color.dart';
import '../travel/components/step_circle.dart';
import '../travel/components/step_line.dart';
import 'package:snct/services/formatDateService.dart';
import 'filtered_travel_map.dart';
import '../travel/components/fake_google_pay_button.dart';
import '../travel/components/travel_buy_button.dart';
import '../travel/components/travel_co2_info.dart';
import '../travel/components/travel_alert_info.dart';

class FilteredTravelDetails extends StatelessWidget {
  final Map<String, dynamic> trip;
  final Map<String, dynamic> fromStation;
  final Map<String, dynamic> toStation;
  final Map<String, dynamic> vehicle;

  const FilteredTravelDetails({
    super.key,
    required this.trip,
    required this.fromStation,
    required this.toStation,
    required this.vehicle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.primary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilteredTravelMap(
            fromStation: fromStation,
            toStation: toStation,
            onBack: () => Navigator.pop(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.tram, color: AppColors.secondary),
                SizedBox(width: 8),
                Text(
                  vehicle['name'] ?? 'Train inconnu',
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
                    '${formatDuration(trip['route']?['duration'] ?? "0")}',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 300,
              child: Stack(
                children: [
                  Positioned(left: 66, top: 0, bottom: 32, child: StepLine()),
                  Positioned(
                    top: 4,
                    left: 0,
                    right: 0,
                    child: StepCircle(
                      time: fromStation['datetime'].split(' ')[1],
                      title: fromStation['city'] ?? 'Ville inconnue',
                      subtitle: 'Accès de plain-pied ou par ascenseur',
                      isTop: true,
                    ),
                  ),
                  Positioned(
                    top: 160,
                    left: 0,
                    right: 0,
                    child: StepCircle(
                      time: toStation['datetime'].split(' ')[1],
                      title: toStation['city'] ?? 'Ville inconnue',
                      subtitle: 'Accès de plain-pied ou par ascenseur',
                      isTop: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
          TravelCO2Info(co2Text: 'CO2 émis pour cet itinéraire : 1.7 kg'),
          TravelAlertInfo(),
          TravelBuyButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                backgroundColor: Colors.white,
                builder: (_) => Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Paiement du billet',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      FakeGooglePayButton(
                        context: context,
                        travelData: {'trip': trip},
                        gareDepart: fromStation,
                        gareArrivee: toStation,
                        tram: vehicle,
                        onPaymentStart: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
