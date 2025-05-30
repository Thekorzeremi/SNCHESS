import 'package:flutter/material.dart';
import '../../color.dart';
import '../travels/components/travel_card.dart';
import '../../mocks/mock_data.dart';
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

  @override
  void initState() {
    super.initState();
    selectedDate = widget.dateDepart;
    visibleDays = List.generate(
      10,
      (i) => widget.dateDepart.add(Duration(days: i)),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gareDepartId = gares.firstWhere(
      (g) => g['name'].toLowerCase() == widget.gareDepart.toLowerCase(),
      orElse: () => <String, dynamic>{},
    )['id'];
    final gareArriveeId = gares.firstWhere(
      (g) => g['name'].toLowerCase() == widget.gareArrivee.toLowerCase(),
      orElse: () => <String, dynamic>{},
    )['id'];

    final List<DateTime> days = visibleDays;

    List<Map<String, dynamic>> daysWithPrice = days.map((date) {
      final dateStr = DateFormat('yyyy-MM-dd').format(date);
      final voyagesOfDay = voyages
          .where(
            (v) =>
                v['fromGareId'] == gareDepartId &&
                v['toGareId'] == gareArriveeId &&
                v['departureDate'] == dateStr,
          )
          .toList();
      double? minPrice;
      if (voyagesOfDay.isNotEmpty) {
        minPrice = voyagesOfDay
            .map((v) => v['price'] as num)
            .reduce((a, b) => a < b ? a : b)
            .toDouble();
      }
      return {'date': date, 'minPrice': minPrice};
    }).toList();

    final selectedDateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
    final filteredVoyages =
        voyages.where((v) {
          return v['fromGareId'] == gareDepartId &&
              v['toGareId'] == gareArriveeId &&
              v['departureDate'] == selectedDateStr;
        }).toList()..sort((a, b) {
          final aHour = int.parse(a['departureHour'].split(':')[0]);
          final aMin = int.parse(a['departureHour'].split(':')[1]);
          final bHour = int.parse(b['departureHour'].split(':')[0]);
          final bMin = int.parse(b['departureHour'].split(':')[1]);
          if (aHour != bHour) return aHour.compareTo(bHour);
          return aMin.compareTo(bMin);
        });

    final dateStr = DateFormat('yyyy-MM-dd').format(selectedDate);

    final initialDate = widget.dateDepart;

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
      body: Container(
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
              child: filteredVoyages.isEmpty
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
                      itemCount: filteredVoyages.length,
                      itemBuilder: (context, index) {
                        final v = filteredVoyages[index];
                        final tram = trams.firstWhere(
                          (t) => t['id'] == v['tramId'],
                        );
                        final gareDep = gares.firstWhere(
                          (g) => g['id'] == v['fromGareId'],
                        );
                        final gareArr = gares.firstWhere(
                          (g) => g['id'] == v['toGareId'],
                        );
                        final gareDepCoords = gares.firstWhere(
                          (g) => g['id'] == v['fromGareId'],
                        );
                        final gareArrCoords = gares.firstWhere(
                          (g) => g['id'] == v['toGareId'],
                        );

                        return TravelCard(
                          voyage: v,
                          gareDepart: gareDep,
                          gareArrivee: gareArr,
                          tram: tram,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Travel(
                                  travelData: v,
                                  gareDepart: gareDep,
                                  gareArrivee: gareArr,
                                  tram: tram,
                                  gareDepartCoords: gareDepCoords,
                                  gareArriveeCoords: gareArrCoords,
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
