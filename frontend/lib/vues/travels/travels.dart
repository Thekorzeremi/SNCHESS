import 'package:flutter/material.dart';
import '../../color.dart';
import '../travel/travel.dart';
import './components/search_bar.dart' as travels_components;
import './components/voyage_card.dart';

class Voyage extends StatefulWidget {
  final String name;
  Voyage({required this.name});

  @override
  State<Voyage> createState() => _VoyageState();
}

class _VoyageState extends State<Voyage> {
  final TextEditingController _searchController = TextEditingController();
  String _search = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _search = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fake data

    final List<Map<String, dynamic>> gares = [
      {'id': '3', 'name': 'Paris'},
      {'id': '4', 'name': 'Lyon'},
      {'id': '5', 'name': 'Marseille'},
      {'id': '6', 'name': 'Toulouse'},
      {'id': '7', 'name': 'Nantes'},
    ];

    final List<Map<String, dynamic>> trams = [
      {'id': '2', 'name': 'TGV 8412', 'type': 'TGV', 'status': 'En service'},
      {'id': '3', 'name': 'TGV 8450', 'type': 'TGV', 'status': 'En service'},
      {'id': '4', 'name': 'TGV 8472', 'type': 'TGV', 'status': 'En service'},
      {'id': '5', 'name': 'TGV 8500', 'type': 'TGV', 'status': 'En service'},
    ];

    final List<Map<String, dynamic>> voyages = [
      {
        'tramId': '2',
        'duration': '03:02',
        'departureHour': '06:00',
        'departureDate': '2025-05-28',
        'fromGareId': '3',
        'toGareId': '4',
        'price': 39,
      },
      {
        'tramId': '3',
        'duration': '02:16',
        'departureHour': '06:32',
        'departureDate': '2025-05-28',
        'fromGareId': '4',
        'toGareId': '5',
        'price': 55,
      },
      {
        'tramId': '4',
        'duration': '03:27',
        'departureHour': '06:44',
        'departureDate': '2025-05-28',
        'fromGareId': '5',
        'toGareId': '6',
        'price': 43,
      },
      {
        'tramId': '5',
        'duration': '03:14',
        'departureHour': '07:03',
        'departureDate': '2025-05-28',
        'fromGareId': '6',
        'toGareId': '7',
        'price': 60,
      },
      {
        'tramId': '5',
        'duration': '03:14',
        'departureHour': '07:03',
        'departureDate': '2025-05-28',
        'fromGareId': '7',
        'toGareId': '3',
        'price': 60,
      },
      {
        'tramId': '3',
        'duration': '03:14',
        'departureHour': '07:03',
        'departureDate': '2025-05-28',
        'fromGareId': '3',
        'toGareId': '4',
        'price': 60,
      },
      {
        'tramId': '4',
        'duration': '03:14',
        'departureHour': '07:03',
        'departureDate': '2025-05-28',
        'fromGareId': '4',
        'toGareId': '5',
        'price': 60,
      },
    ];

    final filteredVoyages = voyages.where((v) {
      final tram = trams.firstWhere((t) => t['id'] == v['tramId']);
      final gareDepart = gares.firstWhere((g) => g['id'] == v['fromGareId']);
      final gareArrivee = gares.firstWhere((g) => g['id'] == v['toGareId']);
      return tram['name'].toLowerCase().contains(_search) ||
          gareDepart['name'].toLowerCase().contains(_search) ||
          gareArrivee['name'].toLowerCase().contains(_search);
    }).toList();

    return Scaffold(
      body: Container(
        color: AppColors.primary,
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bonjour ${widget.name},',
              style: TextStyle(fontSize: 14, color: AppColors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Votre prochaine destination est',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            SizedBox(height: 16),
            travels_components.SearchBar(
              controller: _searchController,
              onSearch: () {},
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Vous souhaitez réaliser une recherche plus précise ?',
                  style: TextStyle(color: AppColors.secondary),
                ),
              ],
            ),
            SizedBox(height: 4),
            Expanded(
              child: ListView.builder(
                itemCount: filteredVoyages.length,
                itemBuilder: (context, index) {
                  final v = filteredVoyages[index];
                  final tram = trams.firstWhere((t) => t['id'] == v['tramId']);
                  final gareDepart = gares.firstWhere((g) => g['id'] == v['fromGareId']);
                  final gareArrivee = gares.firstWhere((g) => g['id'] == v['toGareId']);

                  return VoyageCard(
                    voyage: v,
                    gareDepart: gareDepart,
                    gareArrivee: gareArrivee,
                    tram: tram,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Travel(
                            travelData: v,
                            gareDepart: gareDepart,
                            gareArrivee: gareArrivee,
                            tram: tram,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
