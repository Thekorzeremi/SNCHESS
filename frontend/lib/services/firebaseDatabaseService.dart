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
            "name": "Train de Aktach à Oust-Koksa",
            "price": "61",
            "route": {
              "name": "Aktach à Oust-Koksa",
              "duration": "240",
              "fromStation": {
                "datetime": "02/06/2025 12:00",
                "city": "Aktach",
                "country": "Russia",
                "coordinate": {"latitude": "50.2731", "longitude": "87.6781"},
              },
              "toStation": {
                "datetime": "02/06/2025 16:00",
                "city": "Oust-Koksa",
                "country": "Russia",
                "coordinate": {"latitude": "50.9606", "longitude": "85.6356"},
              },
            },
            "vehicle": {
              "name": "Train 1001",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "7",
            },
          },
        },
        "2": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Oust-Koksa à Akjash",
            "price": "62",
            "route": {
              "name": "Oust-Koksa à Akjash",
              "duration": "300",
              "fromStation": {
                "datetime": "02/06/2025 15:00",
                "city": "Oust-Koksa",
                "country": "Russia",
                "coordinate": {"latitude": "50.9606", "longitude": "85.6356"},
              },
              "toStation": {
                "datetime": "02/06/2025 20:00",
                "city": "Akjash",
                "country": "Kazakstan",
                "coordinate": {"latitude": "49.8037", "longitude": "84.9167"},
              },
            },
            "vehicle": {
              "name": "Train 1002",
              "type": "tram",
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
            "name": "Train de Akjash à Olgiy",
            "price": "63",
            "route": {
              "name": "Akjash à Olgiy",
              "duration": "270",
              "fromStation": {
                "datetime": "02/06/2025 18:00",
                "city": "Akjash",
                "country": "Kazakstan",
                "coordinate": {"latitude": "49.8037", "longitude": "84.9167"},
              },
              "toStation": {
                "datetime": "02/06/2025 22:30",
                "city": "Olgiy",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.9683", "longitude": "89.9625"},
              },
            },
            "vehicle": {
              "name": "Train 1003",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "9",
            },
          },
        },
        "4": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Olgiy à Kyzil-Kaya",
            "price": "64",
            "route": {
              "name": "Olgiy à Kyzil-Kaya",
              "duration": "210",
              "fromStation": {
                "datetime": "02/06/2025 21:00",
                "city": "Olgiy",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.9683", "longitude": "89.9625"},
              },
              "toStation": {
                "datetime": "03/06/2025 00:30",
                "city": "Kyzil-Kaya",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.0000", "longitude": "90.0000"},
              },
            },
            "vehicle": {
              "name": "Train 1004",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "10",
            },
          },
        },
        "5": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Kyzil-Kaya à Buir",
            "price": "65",
            "route": {
              "name": "Kyzil-Kaya à Buir",
              "duration": "330",
              "fromStation": {
                "datetime": "03/06/2025 00:00",
                "city": "Kyzil-Kaya",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.0000", "longitude": "90.0000"},
              },
              "toStation": {
                "datetime": "03/06/2025 05:30",
                "city": "Buir",
                "country": "China",
                "coordinate": {"latitude": "46.0000", "longitude": "117.5000"},
              },
            },
            "vehicle": {
              "name": "Train 1005",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "6",
            },
          },
        },
        "6": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Buir à Orgon",
            "price": "66",
            "route": {
              "name": "Buir à Orgon",
              "duration": "180",
              "fromStation": {
                "datetime": "03/06/2025 03:00",
                "city": "Buir",
                "country": "China",
                "coordinate": {"latitude": "46.0000", "longitude": "117.5000"},
              },
              "toStation": {
                "datetime": "03/06/2025 06:00",
                "city": "Orgon",
                "country": "China",
                "coordinate": {"latitude": "45.0000", "longitude": "118.0000"},
              },
            },
            "vehicle": {
              "name": "Train 1006",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "7",
            },
          },
        },
        "7": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Orgon à Aktach",
            "price": "67",
            "route": {
              "name": "Orgon à Aktach",
              "duration": "240",
              "fromStation": {
                "datetime": "03/06/2025 06:00",
                "city": "Orgon",
                "country": "China",
                "coordinate": {"latitude": "45.0000", "longitude": "118.0000"},
              },
              "toStation": {
                "datetime": "03/06/2025 10:00",
                "city": "Aktach",
                "country": "Russia",
                "coordinate": {"latitude": "50.2731", "longitude": "87.6781"},
              },
            },
            "vehicle": {
              "name": "Train 1007",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "8",
            },
          },
        },
        "8": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Aktach à Akjash",
            "price": "68",
            "route": {
              "name": "Aktach à Akjash",
              "duration": "320",
              "fromStation": {
                "datetime": "03/06/2025 09:00",
                "city": "Aktach",
                "country": "Russia",
                "coordinate": {"latitude": "50.2731", "longitude": "87.6781"},
              },
              "toStation": {
                "datetime": "03/06/2025 14:20",
                "city": "Akjash",
                "country": "Kazakstan",
                "coordinate": {"latitude": "49.8037", "longitude": "84.9167"},
              },
            },
            "vehicle": {
              "name": "Train 1008",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "9",
            },
          },
        },
        "9": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Oust-Koksa à Olgiy",
            "price": "69",
            "route": {
              "name": "Oust-Koksa à Olgiy",
              "duration": "350",
              "fromStation": {
                "datetime": "03/06/2025 12:00",
                "city": "Oust-Koksa",
                "country": "Russia",
                "coordinate": {"latitude": "50.9606", "longitude": "85.6356"},
              },
              "toStation": {
                "datetime": "03/06/2025 17:50",
                "city": "Olgiy",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.9683", "longitude": "89.9625"},
              },
            },
            "vehicle": {
              "name": "Train 1009",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "10",
            },
          },
        },
        "10": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Akjash à Kyzil-Kaya",
            "price": "70",
            "route": {
              "name": "Akjash à Kyzil-Kaya",
              "duration": "210",
              "fromStation": {
                "datetime": "03/06/2025 15:00",
                "city": "Akjash",
                "country": "Kazakstan",
                "coordinate": {"latitude": "49.8037", "longitude": "84.9167"},
              },
              "toStation": {
                "datetime": "03/06/2025 18:30",
                "city": "Kyzil-Kaya",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.0000", "longitude": "90.0000"},
              },
            },
            "vehicle": {
              "name": "Train 1010",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "6",
            },
          },
        },
        "11": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Olgiy à Buir",
            "price": "71",
            "route": {
              "name": "Olgiy à Buir",
              "duration": "400",
              "fromStation": {
                "datetime": "03/06/2025 18:00",
                "city": "Olgiy",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.9683", "longitude": "89.9625"},
              },
              "toStation": {
                "datetime": "03/06/2025 23:40",
                "city": "Buir",
                "country": "China",
                "coordinate": {"latitude": "46.0000", "longitude": "117.5000"},
              },
            },
            "vehicle": {
              "name": "Train 1011",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "7",
            },
          },
        },
        "12": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Kyzil-Kaya à Orgon",
            "price": "72",
            "route": {
              "name": "Kyzil-Kaya à Orgon",
              "duration": "210",
              "fromStation": {
                "datetime": "03/06/2025 21:00",
                "city": "Kyzil-Kaya",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.0000", "longitude": "90.0000"},
              },
              "toStation": {
                "datetime": "04/06/2025 00:30",
                "city": "Orgon",
                "country": "China",
                "coordinate": {"latitude": "45.0000", "longitude": "118.0000"},
              },
            },
            "vehicle": {
              "name": "Train 1012",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "8",
            },
          },
        },
        "13": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Buir à Aktach",
            "price": "73",
            "route": {
              "name": "Buir à Aktach",
              "duration": "320",
              "fromStation": {
                "datetime": "04/06/2025 00:00",
                "city": "Buir",
                "country": "China",
                "coordinate": {"latitude": "46.0000", "longitude": "117.5000"},
              },
              "toStation": {
                "datetime": "04/06/2025 05:20",
                "city": "Aktach",
                "country": "Russia",
                "coordinate": {"latitude": "50.2731", "longitude": "87.6781"},
              },
            },
            "vehicle": {
              "name": "Train 1013",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "9",
            },
          },
        },
        "14": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Orgon à Oust-Koksa",
            "price": "74",
            "route": {
              "name": "Orgon à Oust-Koksa",
              "duration": "350",
              "fromStation": {
                "datetime": "04/06/2025 03:00",
                "city": "Orgon",
                "country": "China",
                "coordinate": {"latitude": "45.0000", "longitude": "118.0000"},
              },
              "toStation": {
                "datetime": "04/06/2025 08:50",
                "city": "Oust-Koksa",
                "country": "Russia",
                "coordinate": {"latitude": "50.9606", "longitude": "85.6356"},
              },
            },
            "vehicle": {
              "name": "Train 1014",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "10",
            },
          },
        },
        "15": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Aktach à Buir",
            "price": "75",
            "route": {
              "name": "Aktach à Buir",
              "duration": "410",
              "fromStation": {
                "datetime": "04/06/2025 06:00",
                "city": "Aktach",
                "country": "Russia",
                "coordinate": {"latitude": "50.2731", "longitude": "87.6781"},
              },
              "toStation": {
                "datetime": "04/06/2025 12:50",
                "city": "Buir",
                "country": "China",
                "coordinate": {"latitude": "46.0000", "longitude": "117.5000"},
              },
            },
            "vehicle": {
              "name": "Train 1015",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "6",
            },
          },
        },
        "16": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Akjash à Orgon",
            "price": "76",
            "route": {
              "name": "Akjash à Orgon",
              "duration": "320",
              "fromStation": {
                "datetime": "04/06/2025 09:00",
                "city": "Akjash",
                "country": "Kazakstan",
                "coordinate": {"latitude": "49.8037", "longitude": "84.9167"},
              },
              "toStation": {
                "datetime": "04/06/2025 14:20",
                "city": "Orgon",
                "country": "China",
                "coordinate": {"latitude": "45.0000", "longitude": "118.0000"},
              },
            },
            "vehicle": {
              "name": "Train 1016",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "7",
            },
          },
        },
        "17": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Oust-Koksa à Kyzil-Kaya",
            "price": "77",
            "route": {
              "name": "Oust-Koksa à Kyzil-Kaya",
              "duration": "350",
              "fromStation": {
                "datetime": "04/06/2025 12:00",
                "city": "Oust-Koksa",
                "country": "Russia",
                "coordinate": {"latitude": "50.9606", "longitude": "85.6356"},
              },
              "toStation": {
                "datetime": "04/06/2025 17:50",
                "city": "Kyzil-Kaya",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.0000", "longitude": "90.0000"},
              },
            },
            "vehicle": {
              "name": "Train 1017",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "8",
            },
          },
        },
        "18": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Olgiy à Aktach",
            "price": "78",
            "route": {
              "name": "Olgiy à Aktach",
              "duration": "400",
              "fromStation": {
                "datetime": "04/06/2025 15:00",
                "city": "Olgiy",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.9683", "longitude": "89.9625"},
              },
              "toStation": {
                "datetime": "04/06/2025 21:40",
                "city": "Aktach",
                "country": "Russia",
                "coordinate": {"latitude": "50.2731", "longitude": "87.6781"},
              },
            },
            "vehicle": {
              "name": "Train 1018",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "9",
            },
          },
        },
        "19": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Kyzil-Kaya à Oust-Koksa",
            "price": "79",
            "route": {
              "name": "Kyzil-Kaya à Oust-Koksa",
              "duration": "320",
              "fromStation": {
                "datetime": "04/06/2025 18:00",
                "city": "Kyzil-Kaya",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.0000", "longitude": "90.0000"},
              },
              "toStation": {
                "datetime": "04/06/2025 23:20",
                "city": "Oust-Koksa",
                "country": "Russia",
                "coordinate": {"latitude": "50.9606", "longitude": "85.6356"},
              },
            },
            "vehicle": {
              "name": "Train 1019",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "10",
            },
          },
        },
        "20": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Buir à Akjash",
            "price": "80",
            "route": {
              "name": "Buir à Akjash",
              "duration": "410",
              "fromStation": {
                "datetime": "05/06/2025 00:00",
                "city": "Buir",
                "country": "China",
                "coordinate": {"latitude": "46.0000", "longitude": "117.5000"},
              },
              "toStation": {
                "datetime": "05/06/2025 06:50",
                "city": "Akjash",
                "country": "Kazakstan",
                "coordinate": {"latitude": "49.8037", "longitude": "84.9167"},
              },
            },
            "vehicle": {
              "name": "Train 1020",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "6",
            },
          },
        },
        "21": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Orgon à Olgiy",
            "price": "81",
            "route": {
              "name": "Orgon à Olgiy",
              "duration": "320",
              "fromStation": {
                "datetime": "05/06/2025 03:00",
                "city": "Orgon",
                "country": "China",
                "coordinate": {"latitude": "45.0000", "longitude": "118.0000"},
              },
              "toStation": {
                "datetime": "05/06/2025 08:20",
                "city": "Olgiy",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.9683", "longitude": "89.9625"},
              },
            },
            "vehicle": {
              "name": "Train 1021",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "7",
            },
          },
        },
        "22": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Aktach à Kyzil-Kaya",
            "price": "82",
            "route": {
              "name": "Aktach à Kyzil-Kaya",
              "duration": "350",
              "fromStation": {
                "datetime": "05/06/2025 06:00",
                "city": "Aktach",
                "country": "Russia",
                "coordinate": {"latitude": "50.2731", "longitude": "87.6781"},
              },
              "toStation": {
                "datetime": "05/06/2025 11:50",
                "city": "Kyzil-Kaya",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.0000", "longitude": "90.0000"},
              },
            },
            "vehicle": {
              "name": "Train 1022",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "8",
            },
          },
        },
        "23": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Akjash à Buir",
            "price": "83",
            "route": {
              "name": "Akjash à Buir",
              "duration": "410",
              "fromStation": {
                "datetime": "05/06/2025 09:00",
                "city": "Akjash",
                "country": "Kazakstan",
                "coordinate": {"latitude": "49.8037", "longitude": "84.9167"},
              },
              "toStation": {
                "datetime": "05/06/2025 15:50",
                "city": "Buir",
                "country": "China",
                "coordinate": {"latitude": "46.0000", "longitude": "117.5000"},
              },
            },
            "vehicle": {
              "name": "Train 1023",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "9",
            },
          },
        },
        "24": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Oust-Koksa à Orgon",
            "price": "84",
            "route": {
              "name": "Oust-Koksa à Orgon",
              "duration": "320",
              "fromStation": {
                "datetime": "05/06/2025 12:00",
                "city": "Oust-Koksa",
                "country": "Russia",
                "coordinate": {"latitude": "50.9606", "longitude": "85.6356"},
              },
              "toStation": {
                "datetime": "05/06/2025 17:20",
                "city": "Orgon",
                "country": "China",
                "coordinate": {"latitude": "45.0000", "longitude": "118.0000"},
              },
            },
            "vehicle": {
              "name": "Train 1024",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "10",
            },
          },
        },
        "25": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Olgiy à Kyzil-Kaya",
            "price": "85",
            "route": {
              "name": "Olgiy à Kyzil-Kaya",
              "duration": "210",
              "fromStation": {
                "datetime": "05/06/2025 15:00",
                "city": "Olgiy",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.9683", "longitude": "89.9625"},
              },
              "toStation": {
                "datetime": "05/06/2025 18:30",
                "city": "Kyzil-Kaya",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.0000", "longitude": "90.0000"},
              },
            },
            "vehicle": {
              "name": "Train 1025",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "6",
            },
          },
        },
        "26": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Kyzil-Kaya à Aktach",
            "price": "86",
            "route": {
              "name": "Kyzil-Kaya à Aktach",
              "duration": "400",
              "fromStation": {
                "datetime": "05/06/2025 18:00",
                "city": "Kyzil-Kaya",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.0000", "longitude": "90.0000"},
              },
              "toStation": {
                "datetime": "06/06/2025 00:40",
                "city": "Aktach",
                "country": "Russia",
                "coordinate": {"latitude": "50.2731", "longitude": "87.6781"},
              },
            },
            "vehicle": {
              "name": "Train 1026",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "7",
            },
          },
        },
        "27": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Buir à Oust-Koksa",
            "price": "87",
            "route": {
              "name": "Buir à Oust-Koksa",
              "duration": "320",
              "fromStation": {
                "datetime": "06/06/2025 00:00",
                "city": "Buir",
                "country": "China",
                "coordinate": {"latitude": "46.0000", "longitude": "117.5000"},
              },
              "toStation": {
                "datetime": "06/06/2025 05:20",
                "city": "Oust-Koksa",
                "country": "Russia",
                "coordinate": {"latitude": "50.9606", "longitude": "85.6356"},
              },
            },
            "vehicle": {
              "name": "Train 1027",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "8",
            },
          },
        },
        "28": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Orgon à Akjash",
            "price": "88",
            "route": {
              "name": "Orgon à Akjash",
              "duration": "350",
              "fromStation": {
                "datetime": "06/06/2025 03:00",
                "city": "Orgon",
                "country": "China",
                "coordinate": {"latitude": "45.0000", "longitude": "118.0000"},
              },
              "toStation": {
                "datetime": "06/06/2025 08:50",
                "city": "Akjash",
                "country": "Kazakstan",
                "coordinate": {"latitude": "49.8037", "longitude": "84.9167"},
              },
            },
            "vehicle": {
              "name": "Train 1028",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "9",
            },
          },
        },
        "29": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Aktach à Olgiy",
            "price": "89",
            "route": {
              "name": "Aktach à Olgiy",
              "duration": "400",
              "fromStation": {
                "datetime": "06/06/2025 06:00",
                "city": "Aktach",
                "country": "Russia",
                "coordinate": {"latitude": "50.2731", "longitude": "87.6781"},
              },
              "toStation": {
                "datetime": "06/06/2025 12:40",
                "city": "Olgiy",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.9683", "longitude": "89.9625"},
              },
            },
            "vehicle": {
              "name": "Train 1029",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "10",
            },
          },
        },
        "30": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Akjash à Kyzil-Kaya",
            "price": "90",
            "route": {
              "name": "Akjash à Kyzil-Kaya",
              "duration": "210",
              "fromStation": {
                "datetime": "06/06/2025 09:00",
                "city": "Akjash",
                "country": "Kazakstan",
                "coordinate": {"latitude": "49.8037", "longitude": "84.9167"},
              },
              "toStation": {
                "datetime": "06/06/2025 12:30",
                "city": "Kyzil-Kaya",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.0000", "longitude": "90.0000"},
              },
            },
            "vehicle": {
              "name": "Train 1030",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "6",
            },
          },
        },
        "31": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Olgiy à Orgon",
            "price": "91",
            "route": {
              "name": "Olgiy à Orgon",
              "duration": "320",
              "fromStation": {
                "datetime": "06/06/2025 12:00",
                "city": "Olgiy",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.9683", "longitude": "89.9625"},
              },
              "toStation": {
                "datetime": "06/06/2025 17:20",
                "city": "Orgon",
                "country": "China",
                "coordinate": {"latitude": "45.0000", "longitude": "118.0000"},
              },
            },
            "vehicle": {
              "name": "Train 1031",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "7",
            },
          },
        },
        "32": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Kyzil-Kaya à Buir",
            "price": "92",
            "route": {
              "name": "Kyzil-Kaya à Buir",
              "duration": "410",
              "fromStation": {
                "datetime": "06/06/2025 15:00",
                "city": "Kyzil-Kaya",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.0000", "longitude": "90.0000"},
              },
              "toStation": {
                "datetime": "06/06/2025 21:50",
                "city": "Buir",
                "country": "China",
                "coordinate": {"latitude": "46.0000", "longitude": "117.5000"},
              },
            },
            "vehicle": {
              "name": "Train 1032",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "8",
            },
          },
        },
        "33": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Buir à Kyzil-Kaya",
            "price": "93",
            "route": {
              "name": "Buir à Kyzil-Kaya",
              "duration": "410",
              "fromStation": {
                "datetime": "06/06/2025 18:00",
                "city": "Buir",
                "country": "China",
                "coordinate": {"latitude": "46.0000", "longitude": "117.5000"},
              },
              "toStation": {
                "datetime": "07/06/2025 00:50",
                "city": "Kyzil-Kaya",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.0000", "longitude": "90.0000"},
              },
            },
            "vehicle": {
              "name": "Train 1033",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "9",
            },
          },
        },
        "34": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Orgon à Buir",
            "price": "94",
            "route": {
              "name": "Orgon à Buir",
              "duration": "350",
              "fromStation": {
                "datetime": "07/06/2025 00:00",
                "city": "Orgon",
                "country": "China",
                "coordinate": {"latitude": "45.0000", "longitude": "118.0000"},
              },
              "toStation": {
                "datetime": "07/06/2025 05:50",
                "city": "Buir",
                "country": "China",
                "coordinate": {"latitude": "46.0000", "longitude": "117.5000"},
              },
            },
            "vehicle": {
              "name": "Train 1034",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "10",
            },
          },
        },
        "35": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Aktach à Orgon",
            "price": "95",
            "route": {
              "name": "Aktach à Orgon",
              "duration": "320",
              "fromStation": {
                "datetime": "07/06/2025 03:00",
                "city": "Aktach",
                "country": "Russia",
                "coordinate": {"latitude": "50.2731", "longitude": "87.6781"},
              },
              "toStation": {
                "datetime": "07/06/2025 08:20",
                "city": "Orgon",
                "country": "China",
                "coordinate": {"latitude": "45.0000", "longitude": "118.0000"},
              },
            },
            "vehicle": {
              "name": "Train 1035",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "6",
            },
          },
        },
        "36": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Akjash à Buir",
            "price": "96",
            "route": {
              "name": "Akjash à Buir",
              "duration": "410",
              "fromStation": {
                "datetime": "07/06/2025 06:00",
                "city": "Akjash",
                "country": "Kazakstan",
                "coordinate": {"latitude": "49.8037", "longitude": "84.9167"},
              },
              "toStation": {
                "datetime": "07/06/2025 12:50",
                "city": "Buir",
                "country": "China",
                "coordinate": {"latitude": "46.0000", "longitude": "117.5000"},
              },
            },
            "vehicle": {
              "name": "Train 1036",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "7",
            },
          },
        },
        "37": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Oust-Koksa à Olgiy",
            "price": "97",
            "route": {
              "name": "Oust-Koksa à Olgiy",
              "duration": "350",
              "fromStation": {
                "datetime": "07/06/2025 09:00",
                "city": "Oust-Koksa",
                "country": "Russia",
                "coordinate": {"latitude": "50.9606", "longitude": "85.6356"},
              },
              "toStation": {
                "datetime": "07/06/2025 14:50",
                "city": "Olgiy",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.9683", "longitude": "89.9625"},
              },
            },
            "vehicle": {
              "name": "Train 1037",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "8",
            },
          },
        },
        "38": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Olgiy à Akjash",
            "price": "98",
            "route": {
              "name": "Olgiy à Akjash",
              "duration": "320",
              "fromStation": {
                "datetime": "07/06/2025 12:00",
                "city": "Olgiy",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.9683", "longitude": "89.9625"},
              },
              "toStation": {
                "datetime": "07/06/2025 17:20",
                "city": "Akjash",
                "country": "Kazakstan",
                "coordinate": {"latitude": "49.8037", "longitude": "84.9167"},
              },
            },
            "vehicle": {
              "name": "Train 1038",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "9",
            },
          },
        },
        "39": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Kyzil-Kaya à Oust-Koksa",
            "price": "99",
            "route": {
              "name": "Kyzil-Kaya à Oust-Koksa",
              "duration": "350",
              "fromStation": {
                "datetime": "07/06/2025 15:00",
                "city": "Kyzil-Kaya",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.0000", "longitude": "90.0000"},
              },
              "toStation": {
                "datetime": "07/06/2025 20:50",
                "city": "Oust-Koksa",
                "country": "Russia",
                "coordinate": {"latitude": "50.9606", "longitude": "85.6356"},
              },
            },
            "vehicle": {
              "name": "Train 1039",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "10",
            },
          },
        },
        "40": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Buir à Aktach",
            "price": "100",
            "route": {
              "name": "Buir à Aktach",
              "duration": "320",
              "fromStation": {
                "datetime": "07/06/2025 18:00",
                "city": "Buir",
                "country": "China",
                "coordinate": {"latitude": "46.0000", "longitude": "117.5000"},
              },
              "toStation": {
                "datetime": "07/06/2025 23:20",
                "city": "Aktach",
                "country": "Russia",
                "coordinate": {"latitude": "50.2731", "longitude": "87.6781"},
              },
            },
            "vehicle": {
              "name": "Train 1040",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "6",
            },
          },
        },
        "41": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Orgon à Kyzil-Kaya",
            "price": "101",
            "route": {
              "name": "Orgon à Kyzil-Kaya",
              "duration": "350",
              "fromStation": {
                "datetime": "08/06/2025 00:00",
                "city": "Orgon",
                "country": "China",
                "coordinate": {"latitude": "45.0000", "longitude": "118.0000"},
              },
              "toStation": {
                "datetime": "08/06/2025 05:50",
                "city": "Kyzil-Kaya",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.0000", "longitude": "90.0000"},
              },
            },
            "vehicle": {
              "name": "Train 1041",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "7",
            },
          },
        },
        "42": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Aktach à Buir",
            "price": "102",
            "route": {
              "name": "Aktach à Buir",
              "duration": "410",
              "fromStation": {
                "datetime": "08/06/2025 03:00",
                "city": "Aktach",
                "country": "Russia",
                "coordinate": {"latitude": "50.2731", "longitude": "87.6781"},
              },
              "toStation": {
                "datetime": "08/06/2025 09:50",
                "city": "Buir",
                "country": "China",
                "coordinate": {"latitude": "46.0000", "longitude": "117.5000"},
              },
            },
            "vehicle": {
              "name": "Train 1042",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "8",
            },
          },
        },
        "43": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Akjash à Orgon",
            "price": "103",
            "route": {
              "name": "Akjash à Orgon",
              "duration": "320",
              "fromStation": {
                "datetime": "08/06/2025 06:00",
                "city": "Akjash",
                "country": "Kazakstan",
                "coordinate": {"latitude": "49.8037", "longitude": "84.9167"},
              },
              "toStation": {
                "datetime": "08/06/2025 11:20",
                "city": "Orgon",
                "country": "China",
                "coordinate": {"latitude": "45.0000", "longitude": "118.0000"},
              },
            },
            "vehicle": {
              "name": "Train 1043",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "9",
            },
          },
        },
        "44": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Oust-Koksa à Kyzil-Kaya",
            "price": "104",
            "route": {
              "name": "Oust-Koksa à Kyzil-Kaya",
              "duration": "350",
              "fromStation": {
                "datetime": "08/06/2025 09:00",
                "city": "Oust-Koksa",
                "country": "Russia",
                "coordinate": {"latitude": "50.9606", "longitude": "85.6356"},
              },
              "toStation": {
                "datetime": "08/06/2025 14:50",
                "city": "Kyzil-Kaya",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.0000", "longitude": "90.0000"},
              },
            },
            "vehicle": {
              "name": "Train 1044",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "10",
            },
          },
        },
        "45": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Olgiy à Aktach",
            "price": "105",
            "route": {
              "name": "Olgiy à Aktach",
              "duration": "400",
              "fromStation": {
                "datetime": "08/06/2025 12:00",
                "city": "Olgiy",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.9683", "longitude": "89.9625"},
              },
              "toStation": {
                "datetime": "08/06/2025 18:40",
                "city": "Aktach",
                "country": "Russia",
                "coordinate": {"latitude": "50.2731", "longitude": "87.6781"},
              },
            },
            "vehicle": {
              "name": "Train 1045",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "6",
            },
          },
        },
        "46": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Kyzil-Kaya à Akjash",
            "price": "106",
            "route": {
              "name": "Kyzil-Kaya à Akjash",
              "duration": "320",
              "fromStation": {
                "datetime": "08/06/2025 15:00",
                "city": "Kyzil-Kaya",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.0000", "longitude": "90.0000"},
              },
              "toStation": {
                "datetime": "08/06/2025 20:20",
                "city": "Akjash",
                "country": "Kazakstan",
                "coordinate": {"latitude": "49.8037", "longitude": "84.9167"},
              },
            },
            "vehicle": {
              "name": "Train 1046",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "7",
            },
          },
        },
        "47": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Buir à Oust-Koksa",
            "price": "107",
            "route": {
              "name": "Buir à Oust-Koksa",
              "duration": "320",
              "fromStation": {
                "datetime": "08/06/2025 18:00",
                "city": "Buir",
                "country": "China",
                "coordinate": {"latitude": "46.0000", "longitude": "117.5000"},
              },
              "toStation": {
                "datetime": "08/06/2025 23:20",
                "city": "Oust-Koksa",
                "country": "Russia",
                "coordinate": {"latitude": "50.9606", "longitude": "85.6356"},
              },
            },
            "vehicle": {
              "name": "Train 1047",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "8",
            },
          },
        },
        "48": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Orgon à Olgiy",
            "price": "108",
            "route": {
              "name": "Orgon à Olgiy",
              "duration": "320",
              "fromStation": {
                "datetime": "09/06/2025 00:00",
                "city": "Orgon",
                "country": "China",
                "coordinate": {"latitude": "45.0000", "longitude": "118.0000"},
              },
              "toStation": {
                "datetime": "09/06/2025 05:20",
                "city": "Olgiy",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.9683", "longitude": "89.9625"},
              },
            },
            "vehicle": {
              "name": "Train 1048",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "9",
            },
          },
        },
        "49": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Aktach à Kyzil-Kaya",
            "price": "109",
            "route": {
              "name": "Aktach à Kyzil-Kaya",
              "duration": "350",
              "fromStation": {
                "datetime": "09/06/2025 03:00",
                "city": "Aktach",
                "country": "Russia",
                "coordinate": {"latitude": "50.2731", "longitude": "87.6781"},
              },
              "toStation": {
                "datetime": "09/06/2025 08:50",
                "city": "Kyzil-Kaya",
                "country": "Mongolia",
                "coordinate": {"latitude": "48.0000", "longitude": "90.0000"},
              },
            },
            "vehicle": {
              "name": "Train 1049",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "10",
            },
          },
        },
        "50": {
          "seatNb": "",
          "wagonNb": "",
          "qr_code": "",
          "trip": {
            "name": "Train de Akjash à Buir",
            "price": "110",
            "route": {
              "name": "Akjash à Buir",
              "duration": "410",
              "fromStation": {
                "datetime": "09/06/2025 06:00",
                "city": "Akjash",
                "country": "Kazakstan",
                "coordinate": {"latitude": "49.8037", "longitude": "84.9167"},
              },
              "toStation": {
                "datetime": "09/06/2025 12:50",
                "city": "Buir",
                "country": "China",
                "coordinate": {"latitude": "46.0000", "longitude": "117.5000"},
              },
            },
            "vehicle": {
              "name": "Train 1050",
              "type": "tram",
              "status": "service",
              "nbOfWagon": "6",
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
                  "type": "tram",
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
                  "type": "tram",
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
