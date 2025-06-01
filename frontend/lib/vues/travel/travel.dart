import 'package:flutter/material.dart';
import 'package:frontend/vues/travel/components/fake_google_pay_button.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import '../../color.dart';
import './components/travel_map.dart';
import './components/travel_details.dart';
import './components/travel_co2_info.dart';
import './components/travel_alert_info.dart';
import './components/travel_buy_button.dart';

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
      gareDepartCoords['latitude'] is double
          ? gareDepartCoords['latitude']
          : double.parse(gareDepartCoords['latitude'].toString()),
      gareDepartCoords['longitude'] is double
          ? gareDepartCoords['longitude']
          : double.parse(gareDepartCoords['longitude'].toString()),
    );
    final LatLng arrivee = LatLng(
      gareArriveeCoords['latitude'] is double
          ? gareArriveeCoords['latitude']
          : double.parse(gareArriveeCoords['latitude'].toString()),
      gareArriveeCoords['longitude'] is double
          ? gareArriveeCoords['longitude']
          : double.parse(gareArriveeCoords['longitude'].toString()),
    );

    final formatedArrivedTime =
        travelData['trip']['route']['fromStation']['datetime'];
    final String arrivalHour = formatedArrivedTime != null
        ? TimeOfDay.fromDateTime(
            DateFormat('dd/MM/yyyy HH:mm').parse(formatedArrivedTime),
          ).format(context)
        : '';

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
                        travelData: travelData,
                        gareDepart: gareDepart,
                        gareArrivee: gareArrivee,
                        tram: tram,
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
