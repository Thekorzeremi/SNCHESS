import 'package:flutter/material.dart';
import '../../color.dart';
import 'package:intl/intl.dart';
import '../ticket/ticket.dart';
import '../../services/firebaseDatabaseService.dart';
import '../../services/firebaseAuthentificationService.dart';

class Tickets extends StatefulWidget {
  const Tickets({super.key});

  @override
  State<Tickets> createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  bool showUpcoming = true;
  List<Map<String, dynamic>> ticketList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserTickets();
  }

  Future<void> fetchUserTickets() async {
    final userInfo = FirebaseAuthentificationService()
        .getCurrentUserInformation();
    final email = userInfo?['email'];
    if (email != null) {
      final tickets = await FirebaseDatabaseService().fetchUserTickets(email);
      setState(() {
        ticketList = tickets;
        isLoading = false;
      });
    } else {
      setState(() {
        ticketList = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    List<Map<String, dynamic>> filteredTickets = ticketList.where((ticket) {
      final trip = ticket['trip'];
      final route = trip['route'];
      final from = route['fromStation'];
      final dateStr = from['datetime'];
      final date = DateFormat('dd/MM/yyyy HH:mm').parse(dateStr);
      return showUpcoming ? date.isAfter(now) : date.isBefore(now);
    }).toList();

    return Scaffold(
      body: Container(
        color: AppColors.primary,
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mes tickets',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showUpcoming = true;
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        'À venir',
                        style: TextStyle(
                          color: showUpcoming
                              ? AppColors.secondary
                              : AppColors.white.withOpacity(0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 4,
                        width: 90,
                        decoration: BoxDecoration(
                          color: showUpcoming
                              ? AppColors.secondary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showUpcoming = false;
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        'Passés',
                        style: TextStyle(
                          color: !showUpcoming
                              ? AppColors.secondary
                              : AppColors.white.withOpacity(0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 4,
                        width: 90,
                        decoration: BoxDecoration(
                          color: !showUpcoming
                              ? AppColors.secondary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : filteredTickets.isEmpty
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
                            'Aucun ticket à venir',
                            style: TextStyle(color: AppColors.white),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredTickets.length,
                      itemBuilder: (context, index) {
                        final ticket = filteredTickets[index];
                        final trip = ticket['trip'];
                        final route = trip['route'];
                        final from = route['fromStation'];
                        final to = route['toStation'];
                        final vehicle = trip['vehicle'];
                        return GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Ticket(ticket: ticket),
                              ),
                            );
                            if (result == 'deleted') {
                              fetchUserTickets();
                            }
                          },
                          child: Card(
                            color: AppColors.card,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        trip['name'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      Text(
                                        '${trip['price']} €',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.tram,
                                        color: AppColors.secondary,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        vehicle['name'],
                                        style: const TextStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Text(
                                        'Wagon: ${ticket['wagonNb']}  Place: ${ticket['seatNb']}',
                                        style: const TextStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: AppColors.secondary,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        from['city'],
                                        style: const TextStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '→',
                                        style: const TextStyle(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        to['city'],
                                        style: const TextStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time,
                                        color: AppColors.secondary,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        from['datetime'],
                                        style: const TextStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '-',
                                        style: const TextStyle(
                                          color: AppColors.secondary,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        to['datetime'],
                                        style: const TextStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.qr_code,
                                        color: AppColors.secondary,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        ticket['qr_code'] ?? '',
                                        style: const TextStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
