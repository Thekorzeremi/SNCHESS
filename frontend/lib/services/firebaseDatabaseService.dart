import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseService {
  Future<void> loadFixturesDataInFirebaseDataBase() async {
    final firebaseDbFixtures = {
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
    };

    await FirebaseDatabase.instance.ref("fixtures").set(firebaseDbFixtures);
  }
}
