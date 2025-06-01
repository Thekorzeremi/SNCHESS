import 'package:firebase_database/firebase_database.dart';

Future<Map<String, List<String>>> fetchStationsFromFirebase() async {
  final db = await FirebaseDatabase.instance
      .ref()
      .child('fixtures/available_tickets')
      .get();
  final Set<String> fromSet = {};
  final Set<String> toSet = {};
  if (db.exists) {
    final value = db.value;
    if (value is List) {
      for (var t in value) {
        if (t == null) continue;
        final from = t['trip']['route']['fromStation']['city'] ?? '';
        final to = t['trip']['route']['toStation']['city'] ?? '';
        if (from.isNotEmpty) fromSet.add(from);
        if (to.isNotEmpty) toSet.add(to);
      }
    } else if (value is Map) {
      value.forEach((_, t) {
        if (t == null) return;
        final from = t['trip']['route']['fromStation']['city'] ?? '';
        final to = t['trip']['route']['toStation']['city'] ?? '';
        if (from.isNotEmpty) fromSet.add(from);
        if (to.isNotEmpty) toSet.add(to);
      });
    }
  }
  return {
    'fromStations': fromSet.toList()..sort(),
    'toStations': toSet.toList()..sort(),
  };
}

Future<List<Map<String, dynamic>>> fetchAvailableTickets() async {
  final db = await FirebaseDatabase.instance
      .ref()
      .child('fixtures/available_tickets')
      .get();
  final List<Map<String, dynamic>> tickets = [];
  if (db.exists) {
    final value = db.value;
    if (value is List) {
      for (var t in value) {
        if (t == null) continue;
        tickets.add(Map<String, dynamic>.from(t));
      }
    } else if (value is Map) {
      value.forEach((_, t) {
        if (t == null) return;
        tickets.add(Map<String, dynamic>.from(t));
      });
    }
  }
  return tickets;
}
