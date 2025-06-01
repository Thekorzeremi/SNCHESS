import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../color.dart';

class FilteredTravelMap extends StatelessWidget {
  final Map<String, dynamic> fromStation;
  final Map<String, dynamic> toStation;
  const FilteredTravelMap({
    super.key,
    required this.fromStation,
    required this.toStation,
  });

  @override
  Widget build(BuildContext context) {
    double? getLat(Map s) =>
        s['lat'] as double? ??
        (s['latitude'] is String
            ? double.tryParse(s['latitude'])
            : s['latitude'] as double?) ??
        (s['coordinate']?['latitude'] is String
            ? double.tryParse(s['coordinate']?['latitude'])
            : s['coordinate']?['latitude'] as double?) ??
        null;
    double? getLng(Map s) =>
        s['lng'] as double? ??
        (s['longitude'] is String
            ? double.tryParse(s['longitude'])
            : s['longitude'] as double?) ??
        (s['coordinate']?['longitude'] is String
            ? double.tryParse(s['coordinate']?['longitude'])
            : s['coordinate']?['longitude'] as double?) ??
        null;
    final fromLat = getLat(fromStation);
    final fromLng = getLng(fromStation);
    final toLat = getLat(toStation);
    final toLng = getLng(toStation);
    final valid =
        fromLat != null &&
        fromLng != null &&
        toLat != null &&
        toLng != null &&
        fromLat != 0 &&
        fromLng != 0 &&
        toLat != 0 &&
        toLng != 0;
    if (!valid) {
      return Container(
        height: 250,
        color: Colors.black12,
        alignment: Alignment.center,
        child: Text(
          'Carte indisponible',
          style: TextStyle(color: Colors.white54),
        ),
      );
    }
    final depart = LatLng(fromLat!, fromLng!);
    final arrivee = LatLng(toLat!, toLng!);
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
        ],
      ),
    );
  }
}
