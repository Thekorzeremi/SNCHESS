import 'package:flutter/material.dart';
import 'package:frontend/color.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class FilteredTravelMap extends StatelessWidget {
  final Map<String, dynamic> fromStation;
  final Map<String, dynamic> toStation;
  const FilteredTravelMap({super.key, required this.fromStation, required this.toStation});

  @override
  Widget build(BuildContext context) {
    final fromCoord = fromStation['coordinate'];
    final toCoord = toStation['coordinate'];
    final fromLat = double.tryParse(fromCoord?['latitude']?.toString() ?? '') ?? 0.0;
    final fromLng = double.tryParse(fromCoord?['longitude']?.toString() ?? '') ?? 0.0;
    final toLat = double.tryParse(toCoord?['latitude']?.toString() ?? '') ?? 0.0;
    final toLng = double.tryParse(toCoord?['longitude']?.toString() ?? '') ?? 0.0;
    final centerLat = (fromLat + toLat) / 2;
    final centerLng = (fromLng + toLng) / 2;

    return Container(
      height: 180,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(centerLat, centerLng),
            initialZoom: 5.5,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 40,
                  height: 40,
                  point: LatLng(fromLat, fromLng),
                  child: Icon(Icons.location_on, color: Colors.green, size: 32),
                ),
                Marker(
                  width: 40,
                  height: 40,
                  point: LatLng(toLat, toLng),
                  child: Icon(Icons.flag, color: Colors.red, size: 32),
                ),
              ],
            ),
            PolylineLayer(
              polylines: [
                Polyline(
                  points: [LatLng(fromLat, fromLng), LatLng(toLat, toLng)],
                  color: AppColors.secondary,
                  strokeWidth: 4.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
