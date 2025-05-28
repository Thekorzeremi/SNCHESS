import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../color.dart';

class TravelMap extends StatelessWidget {
  final LatLng depart;
  final LatLng arrivee;
  final VoidCallback onBack;

  const TravelMap({
    super.key,
    required this.depart,
    required this.arrivee,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
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
                onPressed: onBack,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 