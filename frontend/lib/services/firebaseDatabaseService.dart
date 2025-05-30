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
          "email": "remi@remi.remi",
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
      final value = snapshot.value;
      if (value is Map) {
        return value.values.map((e) => castMap(e as Map)).toList();
      } else if (value is List) {
        return value
            .where((e) => e != null)
            .map((e) => castMap(e as Map))
            .toList();
      }
    }
    return [];
  }
}
