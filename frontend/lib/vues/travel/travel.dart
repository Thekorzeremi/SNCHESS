import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../color.dart';
import './components/step_circle.dart';
import './components/step_line.dart';
import './components/travel_map.dart';
import './components/travel_details.dart';
import './components/travel_co2_info.dart';
import './components/travel_alert_info.dart';
import './components/travel_buy_button.dart';
import '../../services/get_arrival_hour_service.dart';

class Travel extends StatelessWidget {
  final Map<String, dynamic> travelData;
  final Map<String, dynamic> gareDepart;
  final Map<String, dynamic> gareArrivee;
  final Map<String, dynamic> tram;

  const Travel({
    Key? key,
    required this.travelData,
    required this.gareDepart,
    required this.gareArrivee,
    required this.tram,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fake coordonnées pour exemple
    final LatLng depart = LatLng(48.8408, 2.3200); // Paris Montparnasse
    final LatLng arrivee = LatLng(44.8266, -0.5566); // Bordeaux St-Jean
    final String arrivalHour = getArrivalHour(travelData['departureHour'], travelData['duration']);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          TravelMap(
            depart: depart,
            arrivee: arrivee,
            onBack: () => Navigator.pop(context),
          ),
          Expanded(
            child: TravelDetails(
              tram: tram,
              travelData: travelData,
              gareDepart: gareDepart,
              gareArrivee: gareArrivee,
              arrivalHour: arrivalHour,
            ),
          ),
          TravelCO2Info(co2Text: 'CO2 émis pour cet itinéraire : 1.7 kg'),
          SizedBox(height: 14),
          TravelAlertInfo(),
          SizedBox(height: 10),
          TravelBuyButton(onPressed: () {}),
        ],
      ),
    );
  }
}
