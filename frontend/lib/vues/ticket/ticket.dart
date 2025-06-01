import 'package:flutter/material.dart';
import '../../color.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../services/firebaseAuthentificationService.dart';
import '../../services/firebaseDatabaseService.dart';

class Ticket extends StatelessWidget {
  final Map<String, dynamic> ticket;
  const Ticket({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    bool _isUpcoming(String dateStr) {
      try {
        final date = DateFormat('dd/MM/yyyy HH:mm').parse(dateStr);
        return date.isAfter(DateTime.now());
      } catch (_) {
        return false;
      }
    }
    final trip = ticket['trip'];
    final route = trip['route'];
    final from = route['fromStation'];
    final to = route['toStation'];
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mon ticket',
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: Container(
        color: AppColors.primary,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.train, color: AppColors.secondary, size: 48),
                const SizedBox(height: 8),
                Text(
                  trip['name'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '${from['city']} → ${to['city']}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.event, color: AppColors.secondary),
                            const SizedBox(width: 6),
                            Text(
                              from['datetime'],
                              style: const TextStyle(color: AppColors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: AppColors.secondary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Durée : ${formatDuration(route['duration'])}',
                              style: const TextStyle(color: AppColors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.airline_seat_recline_normal,
                              color: AppColors.secondary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Wagon : ${ticket['wagonNb']}  Place : ${ticket['seatNb']}',
                              style: const TextStyle(color: AppColors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '${trip['price']} €',
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Container(
                  width: size.width - 64,
                  height: size.width - 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.secondary),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code,
                          color: AppColors.secondary,
                          size: size.width / 1.7,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          ticket['qr_code'] ?? '',
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (_isUpcoming(from['datetime']))
                  GestureDetector(
                    onTap: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: AppColors.primary,
                          titleTextStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          contentTextStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          title: const Text('Confirmation'),
                          content: const Text(
                            'Es-tu sûr de vouloir annuler ce voyage ?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Non', style: TextStyle(color: Colors.white)),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Oui', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                    );
                    if (confirm == true) {
                      final userInfo = FirebaseAuthentificationService()
                          .getCurrentUserInformation();
                      final email = userInfo?['email'];
                      if (email == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Utilisateur non connecté')),
                        );
                        return;
                      }
                      final success = await FirebaseDatabaseService()
                          .deleteTicket(
                            email: email,
                            qrCode: ticket['qr_code'],
                          );
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Ticket annulé avec succès')),
                        );
                        Navigator.of(context).pop('deleted');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Erreur lors de l\'annulation'),
                          ),
                        );
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Tu souhaites annuler ton voyage ?',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatDuration(dynamic duration) {
    int d = 0;
    if (duration is int) {
      d = duration;
    } else if (duration is String) {
      d = int.tryParse(duration) ?? 0;
    }
    if (d >= 60) {
      int h = d ~/ 60;
      int m = d % 60;
      return m == 0 ? '${h}h' : '${h}h${m.toString().padLeft(2, '0')}';
    } else {
      return '${d} min';
    }
  }
}
