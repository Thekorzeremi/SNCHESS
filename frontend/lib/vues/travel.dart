import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../color.dart';

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

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          // Carte
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(
                      (depart.latitude + arrivee.latitude) / 2,
                      (depart.longitude + arrivee.longitude) / 2,
                    ),
                    initialZoom: 5.5,
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.none,
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: [depart, arrivee],
                          color: AppColors.primary,
                          strokeWidth: 4,
                        ),
                      ],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: depart,
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.location_on,
                            color: AppColors.primary,
                            size: 32,
                          ),
                        ),
                        Marker(
                          point: arrivee,
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.location_on,
                            color: AppColors.primary,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Détails du trajet
          Expanded(
            child: Container(
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
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
                  // Etapes
                  SizedBox(
                    height: 300,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 66,
                          top: 0,
                          bottom: 32,
                          child: Container(
                            width: 26,
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          left: 0,
                          right: 0,
                          child: _stepCircleV2(
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
                          child: _stepCircleV2(
                            time: _getArrivalHour(
                              travelData['departureHour'],
                              travelData['duration'],
                            ),
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
            ),
          ),
          Container(
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
                      'CO2 émis pour cet itinéraire : 1.7 kg',
                      style: TextStyle(color: AppColors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 14),
          Container(
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.sms_failed,
                          color: Colors.pinkAccent,
                          size: 28,
                        ),
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
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.secondary,
                    size: 28,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                ),
                onPressed: () {},
                child: Text(
                  'Acheter votre billet de train',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepCircleV2({
    required String time,
    required String title,
    required String subtitle,
    required bool isTop,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heure dans bulle
        Container(
          margin: EdgeInsets.only(top: isTop ? 0 : 40),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Text(
            time,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 14),
        // Cercle noir
        Container(
          margin: EdgeInsets.only(top: isTop ? 0 : 40),
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 3),
          ),
        ),
        SizedBox(width: 14),
        // Infos
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: isTop ? 0 : 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getArrivalHour(String departure, String duration) {
    final dep = TimeOfDay(
      hour: int.parse(departure.split(':')[0]),
      minute: int.parse(departure.split(':')[1]),
    );
    final d = duration.split(':');
    int addH = int.parse(d[0]);
    int addM = int.parse(d[1]);
    int arrH = dep.hour + addH + ((dep.minute + addM) ~/ 60);
    int arrM = (dep.minute + addM) % 60;
    return '${arrH.toString().padLeft(2, '0')}:${arrM.toString().padLeft(2, '0')}';
  }
}
