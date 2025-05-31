import 'package:flutter/material.dart';
import '../../color.dart';
import '../travel/travel.dart';
import './components/search_bar.dart' as travels_components;
import 'components/travel_card.dart';
import '../detailled_search/detailled_search.dart';
import '../../mocks/mock_data.dart';
import '../../services/firebaseAuthentificationService.dart';
import '../../services/firebaseDatabaseService.dart';

class Travels extends StatefulWidget {
  final String name;
  const Travels({super.key, required this.name});

  @override
  State<Travels> createState() => _TravelsState();
}

class _TravelsState extends State<Travels> {
  final TextEditingController _searchController = TextEditingController();
  String _search = '';
  List<Map<String, dynamic>> tickets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _search = _searchController.text.toLowerCase();
      });
    });
    fetchTickets();
  }

  Future<void> fetchTickets() async {
    try {
      final fetchedTickets = await FirebaseDatabaseService()
          .fetchAvailableTickets();
      setState(() {
        tickets = fetchedTickets;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching tickets: $e');
      setState(() {
        isLoading = false;
      });
    }
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
              '${DateTime.now().hour >= 18 || DateTime.now().hour < 6 ? 'Bonsoir' : 'Bonjour'} ${FirebaseAuthentificationService().getCurrentUserInformation()?["displayName"] ?? widget.name},',
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

String safeGetHour(dynamic datetime) {
  if (datetime == null ||
      datetime == "" ||
      !(datetime is String) ||
      !datetime.contains(':')) {
    return "00";
  }
  return datetime.split(':')[0];
}
