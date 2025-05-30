import 'package:flutter/material.dart';

String getArrivalHour(String departure, String duration) {
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
