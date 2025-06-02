import 'package:flutter/material.dart';
import '../../color.dart';
import '../travel/travel.dart';
import './components/search_bar.dart' as travels_components;
import 'components/travel_card.dart';
import '../detailled_search/detailled_search.dart';
import 'package:intl/intl.dart';
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
    final filteredTickets = tickets.where((ticket) {
      final trip = ticket['trip'] ?? {};
      final route = trip['route'] ?? {};
      final fromStation = route['fromStation'] ?? {};
      final fromCity = fromStation['city']?.toLowerCase() ?? '';
      final toCity = route['toStation']?['city']?.toLowerCase() ?? '';
      final name = trip['name']?.toLowerCase() ?? '';
      final dateStr = fromStation['datetime'] ?? '';
      DateTime? date;
      try {
        date = DateFormat('dd/MM/yyyy HH:mm').parse(dateStr);
      } catch (_) {
        date = null;
      }
      final isFuture = date == null ? false : date.isAfter(DateTime.now());
      return isFuture &&
          (fromCity.contains(_search) ||
              toCity.contains(_search) ||
              name.contains(_search));
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
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: filteredTickets.length,
                      itemBuilder: (context, index) {
                        final ticket = filteredTickets[index];
                        final trip = ticket['trip'] ?? {};
                        final route = trip['route'] ?? {};
                        final fromStation = route['fromStation'] ?? {};
                        final toStation = route['toStation'] ?? {};
                        final vehicle = trip['vehicle'] ?? {};

                        return TravelCard(
                          voyage: ticket,
                          gareDepart: fromStation,
                          gareArrivee: toStation,
                          tram: vehicle,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Travel(
                                  travelData: ticket,
                                  gareDepart: fromStation,
                                  gareArrivee: toStation,
                                  tram: vehicle,
                                  gareDepartCoords: fromStation['coordinate'],
                                  gareArriveeCoords: toStation['coordinate'],
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
