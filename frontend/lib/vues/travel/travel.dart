import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../../color.dart';
import './components/travel_map.dart';
import './components/travel_details.dart';
import './components/travel_co2_info.dart';
import './components/travel_alert_info.dart';
import './components/travel_buy_button.dart';
import '../../services/formatDateService.dart';

class Travel extends StatelessWidget {
  final Map<String, dynamic> travelData;
  final Map<String, dynamic> gareDepart;
  final Map<String, dynamic> gareArrivee;
  final Map<String, dynamic> gareDepartCoords;
  final Map<String, dynamic> gareArriveeCoords;
  final Map<String, dynamic> tram;

  const Travel({
    super.key,
    required this.travelData,
    required this.gareDepart,
    required this.gareArrivee,
    required this.tram,
    required this.gareDepartCoords,
    required this.gareArriveeCoords,
  });

  // TODO : Ajouter la récupération des données de voyage depuis Firebase RDB

  @override
  Widget build(BuildContext context) {
    final LatLng depart = LatLng(
      gareDepartCoords['latitude'],
      gareDepartCoords['longitude'],
    );
    final LatLng arrivee = LatLng(
      gareArriveeCoords['latitude'],
      gareArriveeCoords['longitude'],
    );
    final String arrivalHour = getArrivalHour(
      travelData['departureHour'],
      travelData['duration'],
    );

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
