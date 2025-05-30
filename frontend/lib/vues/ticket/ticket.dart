import 'package:flutter/material.dart';
import '../../color.dart';

class Ticket extends StatelessWidget {
  final Map<String, dynamic> ticket;
  const Ticket({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final trip = ticket['trip'];
    final route = trip['route'];
    final from = route['fromStation'];
    final to = route['toStation'];
    final vehicle = trip['vehicle'];
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
          child: Padding(
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
                            const Icon(Icons.access_time, color: AppColors.secondary),
                            const SizedBox(width: 6),
                            Text(
                              'Durée : ${route['duration']} min',
                              style: const TextStyle(color: AppColors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.airline_seat_recline_normal, color: AppColors.secondary),
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
                // QR code en grand
                Container(
                  width: size.width - 40, // padding horizontal
                  height: size.width - 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.secondary),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.qr_code, color: AppColors.secondary, size: size.width / 1.7),
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
                const SizedBox(height: 32),
                // CTA sous forme de questions cliquables
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Vous souhaitez changer la date de votre billet ?',
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Vous souhaitez changer de billet ?',
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {},
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
                // Ajoute ici d'autres infos ou images si besoin
              ],
            ),
          ),
        ),
      ),
    );
  }
}
