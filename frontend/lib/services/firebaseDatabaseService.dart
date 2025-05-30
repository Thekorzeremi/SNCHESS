import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseService {
  Future<void> loadFixturesDataInFirebaseDataBase() async {
    final firebaseDbFixtures = {
      "available_tickets": {
        "1": {
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
            "3": {
              "seatNb": "36",
              "wagonNb": "6",
              "qr_code": "HDUZADKNKN32",
              "trip": {
                "name": "TGV de Feur à Quoi",
                "price": "88",
                "route": {
                  "name": "Marseille à Paris",
                  "duration": "199",
                  "fromStation": {
                    "datetime": "29/06/2025 15:29",
                    "city": "Marseille",
                    "country": "FR",
                    "coordinate": {
                      "latitude": "43.2961743",
                      "longitude": "5.3699525",
                    },
                  },
                  "toStation": {
                    "datetime": "29/06/2025 18:48",
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
          key.toString(), value.map((e) => e is Map ? castMap(e) : e).toList());
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
        for (final ticket in tickets) {
          if (ticket == null) continue;
          final ticketMap = castMap(ticket as Map);
          print(ticketMap);
        }
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
          if ((userMap['email']?.toLowerCase()?.trim() ?? '') == email.toLowerCase().trim()) {
            final tickets = userMap['ticket'];
            if (tickets is List) {
              return tickets.where((t) => t != null).map((e) => castMap(e as Map)).toList();
            } else if (tickets is Map) {
              return tickets.values.map((e) => castMap(e as Map)).toList();
            }
          }
        }
      }
    }
    return [];
  }
}
