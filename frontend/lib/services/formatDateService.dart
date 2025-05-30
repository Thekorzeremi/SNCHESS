import 'package:flutter/material.dart';

String getArrivalHour(String departure, String duration) {
  final departureTime = TimeOfDay(
    hour: int.parse(departure.split(':')[0]),
    minute: int.parse(departure.split(':')[1]),
  );
  final durationParts = duration.split(':');
  int durationHours = int.parse(durationParts[0]);
  int durationMinutes = int.parse(durationParts[1]);
  int arrivalHour = departureTime.hour + durationHours + ((departureTime.minute + durationMinutes) ~/ 60);
  int arrivalMinute = (departureTime.minute + durationMinutes) % 60;
  return '${arrivalHour.toString().padLeft(2, '0')}:${arrivalMinute.toString().padLeft(2, '0')}';
}

String formatDuration(dynamic duration) {
  int totalMinutes = 0;
  if (duration is int) {
    totalMinutes = duration;
  } else if (duration is String) {
    totalMinutes = int.tryParse(duration) ?? 0;
    if (totalMinutes == 0 && duration.contains(':')) {
      final parts = duration.split(':');
      if (parts.length == 2) {
        int hours = int.parse(parts[0]);
        int minutes = int.parse(parts[1]);
        totalMinutes = hours * 60 + minutes;
      }
    }
  }
  if (totalMinutes >= 60) {
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;
    return minutes == 0 ? '${hours}h' : '${hours}h${minutes.toString().padLeft(2, '0')}';
  } else {
    return '${totalMinutes} min';
  }
}
