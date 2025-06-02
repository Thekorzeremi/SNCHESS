import 'package:firebase_database/firebase_database.dart';

// TODO : Ajouter plein de fixtures

class FirebaseDatabaseService {
  Future<void> loadFixturesDataInFirebaseDataBase() async {
    final firebaseDbFixtures = {
      "available_tickets": {
        "1": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "TGV de Paris à Lyon",
            "price": "88",
            "route": {
              "name": "Paris à Lyon",
              "duration": "199",
              "fromStation": {
                "datetime": "05/06/2025 15:29",
                "city": "Paris",
                "country": "FR",
                "coordinate": {
                  "latitude": "48.8534951",
                  "longitude": "2.3483915",
                },
              },
              "toStation": {
                "datetime": "05/06/2025 18:48",
                "city": "Lyon",
                "country": "FR",
                "coordinate": {
                  "latitude": "43.2961743",
                  "longitude": "5.3699525",
                },
              },
            },
            "vehicle": {
              "name": "TGV 3501",
              "type": "train",
              "status": "service",
              "nbOfWagon": "8",
            },
          },
        },
        "2": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "TGV de Paris à Marseille",
            "price": "88",
            "route": {
              "name": "Paris à Marseille",
              "duration": "199",
              "fromStation": {
                "datetime": "28/05/2025 15:29",
                "city": "Paris",
                "country": "FR",
                "coordinate": {
                  "latitude": "48.8534951",
                  "longitude": "2.3483915",
                },
              },
              "toStation": {
                "datetime": "28/05/2025 18:48",
                "city": "Marseille",
                "country": "FR",
                "coordinate": {
                  "latitude": "43.2961743",
                  "longitude": "5.3699525",
                },
              },
            },
            "vehicle": {
              "name": "TGV 3501",
              "type": "train",
              "status": "service",
              "nbOfWagon": "8",
            },
          },
        },
        "3": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "TGV de Paris à Marseille",
            "price": "88",
            "route": {
              "name": "Paris à Marseille",
              "duration": "199",
              "fromStation": {
                "datetime": "28/05/2025 15:29",
                "city": "Paris",
                "country": "FR",
                "coordinate": {
                  "latitude": "48.8534951",
                  "longitude": "2.3483915",
                },
              },
              "toStation": {
                "datetime": "28/05/2025 18:48",
                "city": "Marseille",
                "country": "FR",
                "coordinate": {
                  "latitude": "43.2961743",
                  "longitude": "5.3699525",
                },
              },
            },
            "vehicle": {
              "name": "TGV 3501",
              "type": "train",
              "status": "service",
              "nbOfWagon": "8",
            },
          },
        },
        "4": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "TGV de Paris à Lyon",
            "price": "75",
            "route": {
              "name": "Paris à Lyon",
              "duration": "199",
              "fromStation": {
                "datetime": "07/06/2025 15:29",
                "city": "Paris",
                "country": "FR",
                "coordinate": {
                  "latitude": "48.8534951",
                  "longitude": "2.3483915",
                },
              },
              "toStation": {
                "datetime": "07/06/2025 18:48",
                "city": "Lyon",
                "country": "FR",
                "coordinate": {
                  "latitude": "43.2961743",
                  "longitude": "5.3699525",
                },
              },
            },
            "vehicle": {
              "name": "TGV 3501",
              "type": "train",
              "status": "service",
              "nbOfWagon": "8",
            },
          },
        },
      },
      "users": {
        "1": {
          "email": "test@snchess.com",
          "ticket": {
            "1": {
              "seatNb": "12",
              "wagonNb": "3",
              "qr_code": "BUB3E2OBE32OE",
              "trip": {
                "name": "TGV de Paris à Marseille",
                "price": "88",
                "route": {
                  "name": "Paris à Marseille",
                  "duration": "199",
                  "fromStation": {
                    "datetime": "28/05/2025 15:29",
                    "city": "Paris",
                    "country": "FR",
                    "coordinate": {
                      "latitude": "48.8534951",
                      "longitude": "2.3483915",
                    },
                  },
                  "toStation": {
                    "datetime": "28/05/2025 18:48",
                    "city": "Marseille",
                    "country": "FR",
                    "coordinate": {
                      "latitude": "43.2961743",
                      "longitude": "5.3699525",
                    },
                  },
                },
                "vehicle": {
                  "name": "TGV 3501",
                  "type": "train",
                  "status": "service",
                  "nbOfWagon": "8",
                },
              },
            },
            "2": {
              "seatNb": "36",
              "wagonNb": "6",
              "qr_code": "HDUZADKNKN32",
              "trip": {
                "name": "TGV de Marseille à Paris",
                "price": "88",
                "route": {
                  "name": "Marseille à Paris",
                  "duration": "199",
                  "fromStation": {
                    "datetime": "29/05/2025 15:29",
                    "city": "Marseille",
                    "country": "FR",
                    "coordinate": {
                      "latitude": "43.2961743",
                      "longitude": "5.3699525",
                    },
                  },
                  "toStation": {
                    "datetime": "29/05/2025 18:48",
                    "city": "Paris",
                    "country": "FR",
                    "coordinate": {
                      "latitude": "48.8534951",
                      "longitude": "2.3483915",
                    },
                  },
                },
                "vehicle": {
                  "name": "TGV 6495",
                  "type": "train",
                  "status": "service",
                  "nbOfWagon": "8",
                },
              },
            },
          },
        },
      },
    };

    await FirebaseDatabase.instance.ref("fixtures").set(firebaseDbFixtures);
  }

  Map<String, dynamic> castMap(Map original) {
    return original.map((key, value) {
      if (value is Map) {
        return MapEntry(key.toString(), castMap(value));
      } else if (value is List) {
        return MapEntry(
          key.toString(),
          value.map((e) => e is Map ? castMap(e) : e).toList(),
        );
      } else {
        return MapEntry(key.toString(), value);
      }
    });
  }

  Future<List<Map<String, dynamic>>> fetchAvailableTickets() async {
    final ref = FirebaseDatabase.instance.ref("fixtures/available_tickets");
    final snapshot = await ref.get();
    if (snapshot.exists) {
      final tickets = snapshot.value;
      if (tickets is List) {
        return tickets
            .where((ticket) => ticket != null)
            .map((ticket) => castMap(ticket as Map))
            .toList();
      } else if (tickets is Map) {
        return tickets.values
            .where((ticket) => ticket != null)
            .map((ticket) => castMap(ticket as Map))
            .toList();
      }
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> fetchUserTickets(String email) async {
    final ref = FirebaseDatabase.instance.ref("fixtures/users");
    final snapshot = await ref.get();
    if (snapshot.exists) {
      final users = snapshot.value;
      if (users is List) {
        for (final user in users) {
          if (user == null) continue;
          final userMap = castMap(user as Map);
          if ((userMap['email']?.toLowerCase()?.trim() ?? '') ==
              email.toLowerCase().trim()) {
            final tickets = userMap['ticket'];
            if (tickets is List) {
              return tickets
                  .where((t) => t != null)
                  .map((e) => castMap(e as Map))
                  .toList();
            } else if (tickets is Map) {
              return tickets.values.map((e) => castMap(e as Map)).toList();
            }
          }
        }
      }
    }
    return [];
  }

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

  Future<bool> deleteTicket({
    required String email,
    required String qrCode,
  }) async {
    try {
      final db = FirebaseDatabase.instance.ref();
      final usersSnapshot = await db.child('fixtures/users').get();
      int? userIndex;
      Map<dynamic, dynamic>? userData;
      if (usersSnapshot.exists) {
        final users = usersSnapshot.value as List<dynamic>;
        for (int i = 0; i < users.length; i++) {
          final user = users[i];
          if (user != null && user['email'] == email) {
            userIndex = i;
            userData = user;
            break;
          }
        }
      }
      if (userIndex == null || userData == null) {
        return false;
      }

      final tickets = userData['ticket'] as List<dynamic>;
      int? ticketIndex;
      for (int i = 0; i < tickets.length; i++) {
        final t = tickets[i];
        if (t != null && t['qr_code'] == qrCode) {
          ticketIndex = i;
          break;
        }
      }
      if (ticketIndex == null) {
        return false;
      }
      await db.child('fixtures/users/$userIndex/ticket/$ticketIndex').remove();
      return true;
    } catch (e) {
      return false;
    }
  }

    Future<List<Map<String, dynamic>>> getUsers() async {
    final ref = FirebaseDatabase.instance.ref("fixtures/users");
    final snapshot = await ref.get();
    final List<Map<String, dynamic>> users = [];
    if (snapshot.exists) {
      final val = snapshot.value;
      if (val is List) {
        for (final user in val) {
          if (user != null) users.add(castMap(user as Map));
        }
      } else if (val is Map) {
        for (final user in (val as Map).values) {
          if (user != null) users.add(castMap(user as Map));
        }
      }
    }
    return users;
  }

  Future<List<Map<String, dynamic>>> getTrips() async {
    final ref = FirebaseDatabase.instance.ref("fixtures/available_tickets");
    final snapshot = await ref.get();
    final List<Map<String, dynamic>> trips = [];
    if (snapshot.exists) {
      final val = snapshot.value;
      if (val is List) {
        for (final trip in val) {
          if (trip != null) trips.add(castMap(trip as Map));
        }
      } else if (val is Map) {
        for (final trip in (val as Map).values) {
          if (trip != null) trips.add(castMap(trip as Map));
        }
      }
    }
    return trips;
  }

  Future<List<Map<String, dynamic>>> getStations() async {
    final trips = await getTrips();
    final Map<String, Map<String, dynamic>> stations = {};
    for (final trip in trips) {
      final from = trip['trip']?['route']?['fromStation'];
      final to = trip['trip']?['route']?['toStation'];
      if (from != null && from['city'] != null) stations[from['city']] = from;
      if (to != null && to['city'] != null) stations[to['city']] = to;
    }
    return stations.values.toList();
  }
}
