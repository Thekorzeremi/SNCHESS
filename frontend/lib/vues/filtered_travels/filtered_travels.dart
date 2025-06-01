import 'package:flutter/material.dart';
import '../../color.dart';
import '../travels/components/travel_card.dart';
import 'filtered_travel_details.dart';
import '../../mocks/mock_data.dart';
import '../detailled_search/firebase_station_utils.dart';
import '../travel/travel.dart';
import 'package:intl/intl.dart';
import 'components/date_price_card.dart';
import 'components/initial_search_button.dart';

class FilteredTravels extends StatefulWidget {
  final String gareDepart;
  final String gareArrivee;
  final DateTime dateDepart;

  const FilteredTravels({
    super.key,
    required this.gareDepart,
    required this.gareArrivee,
    required this.dateDepart,
  });

  @override
  State<FilteredTravels> createState() => _FilteredTravelsState();
}

class _FilteredTravelsState extends State<FilteredTravels> {
  late DateTime selectedDate;
  final ScrollController _scrollController = ScrollController();
  late List<DateTime> visibleDays;

  List<Map<String, dynamic>> availableTickets = [];
  bool isLoading = true;
  String? errorMsg;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.dateDepart;
    visibleDays = List.generate(
      10,
      (i) => widget.dateDepart.add(Duration(days: i)),
    );
    _loadAvailableTickets();
  }

  Future<void> _loadAvailableTickets() async {
    setState(() { isLoading = true; });
    try {
      final tickets = await fetchAvailableTickets();
      setState(() {
        availableTickets = tickets;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMsg = 'Erreur lors du chargement des trajets';
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
    final initialDate = widget.dateDepart;

    final filteredTickets = availableTickets.where((t) {
      final from = t['trip']['route']['fromStation']['city']?.toLowerCase();
      final to = t['trip']['route']['toStation']['city']?.toLowerCase();
      final depDate = t['trip']['route']['fromStation']['datetime'];
      final depDateOnly = depDate != null && depDate.contains(' ') ? depDate.split(' ')[0] : '';
      final selectedDateStr2 = DateFormat('dd/MM/yyyy').format(selectedDate);
      return from == widget.gareDepart.toLowerCase()
          && to == widget.gareArrivee.toLowerCase()
          && depDateOnly == selectedDateStr2;
    }).toList();

    final gareDepartId = gares.firstWhere(
      (g) => g['name'].toLowerCase() == widget.gareDepart.toLowerCase(),
      orElse: () => <String, dynamic>{},
    )['id'];
    final gareArriveeId = gares.firstWhere(
      (g) => g['name'].toLowerCase() == widget.gareArrivee.toLowerCase(),
      orElse: () => <String, dynamic>{},
    )['id'];

    final Map<String, List<Map<String, dynamic>>> ticketsByDate = {};
    for (final t in availableTickets) {
      final from = t['trip']['route']['fromStation']['city']?.toLowerCase();
      final to = t['trip']['route']['toStation']['city']?.toLowerCase();
      if (from == widget.gareDepart.toLowerCase() && to == widget.gareArrivee.toLowerCase()) {
        final depDate = t['trip']['route']['fromStation']['datetime'];
        final depDateOnly = depDate != null && depDate.contains(' ') ? depDate.split(' ')[0] : '';
        if (depDateOnly.isNotEmpty) {
          ticketsByDate.putIfAbsent(depDateOnly, () => []).add(t);
        }
      }
    }
    final List<Map<String, dynamic>> daysWithPrice = ticketsByDate.entries.map((e) {
      final date = DateFormat('dd/MM/yyyy').parse(e.key);
      final minPrice = e.value.map((t) => double.tryParse(t['trip']['price'].toString()) ?? 0).reduce((a, b) => a < b ? a : b);
      return {'date': date, 'minPrice': minPrice};
    }).toList()
      ..sort((a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'De ${widget.gareDepart} à ${widget.gareArrivee}',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'Le $dateStr',
              style: TextStyle(color: AppColors.white, fontSize: 12),
            ),
          ],
        ),
        iconTheme: IconThemeData(color: AppColors.white),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMsg != null
              ? Center(child: Text(errorMsg!, style: TextStyle(color: Colors.red)))
              : Container(
                  color: AppColors.primary,
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: ListView.separated(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: daysWithPrice.length,
                          separatorBuilder: (_, __) => SizedBox(width: 16),
                          itemBuilder: (context, i) {
                            final d = daysWithPrice[i]['date'] as DateTime;
                            final minPrice = daysWithPrice[i]['minPrice'];
                            final isSelected =
                                d.year == selectedDate.year &&
                                d.month == selectedDate.month &&
                                d.day == selectedDate.day;
                            final weekDay = DateFormat('E', 'fr_FR').format(d);
                            final dayNum = d.day;
                            return DatePriceCard(
                              date: d,
                              minPrice: minPrice,
                              isSelected: isSelected,
                              weekDay: weekDay,
                              dayNum: dayNum,
                              onTap: () async {
                                final double cardWidth = 90 + 16;
                                await _scrollController.animateTo(
                                  cardWidth * i,
                                  duration: Duration(milliseconds: 250),
                                  curve: Curves.ease,
                                );
                                setState(() {
                                  selectedDate = d;
                                  visibleDays = List.generate(
                                    10,
                                    (j) => d.add(Duration(days: j)),
                                  );
                                });
                                await Future.delayed(Duration(milliseconds: 50));
                                _scrollController.jumpTo(0);
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      InitialSearchButton(
                        onTap: () async {
                          setState(() {
                            selectedDate = initialDate;
                            visibleDays = List.generate(
                              10,
                              (j) => initialDate.add(Duration(days: j)),
                            );
                          });
                          await Future.delayed(Duration(milliseconds: 50));
                          _scrollController.jumpTo(0);
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Voyages disponibles',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: filteredTickets.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.warning,
                                      color: AppColors.secondary,
                                      size: 48,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Aucun voyage disponible pour le $dateStr',
                                      style: TextStyle(color: AppColors.white),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: filteredTickets.length,
                                itemBuilder: (context, index) {
                                  final t = filteredTickets[index];
                                  final trip = t['trip'];
                                  final route = trip['route'];
                                  final fromStation = route['fromStation'];
                                  final toStation = route['toStation'];
                                  final vehicle = trip['vehicle'];
                                  return Card(
                                    color: AppColors.card,
                                    child: ListTile(
                                      title: Text('${fromStation['city']} → ${toStation['city']}', style: TextStyle(color: AppColors.white)),
                                      subtitle: Text('Départ: ${fromStation['datetime']}\nArrivée: ${toStation['datetime']}\nPrix: ${trip['price']} €', style: TextStyle(color: Colors.white70)),
                                      trailing: Text(vehicle['name'] ?? '', style: TextStyle(color: AppColors.secondary)),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => Scaffold(
                                              appBar: AppBar(
                                                backgroundColor: AppColors.primary,
                                                elevation: 0,
                                                title: Text('Détail du trajet', style: TextStyle(color: AppColors.white)),
                                                iconTheme: IconThemeData(color: AppColors.white),
                                              ),
                                              body: FilteredTravelDetails(
                                                trip: Map<String, dynamic>.from(trip as Map),
                                                fromStation: Map<String, dynamic>.from(fromStation as Map),
                                                toStation: Map<String, dynamic>.from(toStation as Map),
                                                vehicle: Map<String, dynamic>.from(vehicle as Map),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
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
