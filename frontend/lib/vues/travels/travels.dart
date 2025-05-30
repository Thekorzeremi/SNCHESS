import 'package:flutter/material.dart';
import '../../color.dart';
import '../travel/travel.dart';
import './components/search_bar.dart' as travels_components;
import 'components/travel_card.dart';
import '../detailled_search/detailled_search.dart';
import '../../mocks/mock_data.dart';

class Voyage extends StatefulWidget {
  final String name;
  const Voyage({super.key, required this.name});

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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailledSearch(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Vous souhaitez réaliser une recherche plus précise ?',
                    style: TextStyle(color: AppColors.secondary),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4),
            Expanded(
              child: ListView.builder(
                itemCount: filteredVoyages.length,
                itemBuilder: (context, index) {
                  final v = filteredVoyages[index];
                  final tram = trams.firstWhere((t) => t['id'] == v['tramId']);
                  final gareDepart = gares.firstWhere(
                    (g) => g['id'] == v['fromGareId'],
                  );
                  final gareArrivee = gares.firstWhere(
                    (g) => g['id'] == v['toGareId'],
                  );
                  final gareDepartCoords = gares.firstWhere(
                    (g) => g['id'] == v['fromGareId'],
                  );
                  final gareArriveeCoords = gares.firstWhere(
                    (g) => g['id'] == v['toGareId'],
                  );

                  return TravelCard(
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
                            gareDepartCoords: gareDepartCoords,
                            gareArriveeCoords: gareArriveeCoords,
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
