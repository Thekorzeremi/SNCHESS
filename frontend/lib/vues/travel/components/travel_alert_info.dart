import 'package:flutter/material.dart';
import '../../../color.dart';

class TravelAlertInfo extends StatelessWidget {
  const TravelAlertInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => TravelAlertDialog(),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Icon(Icons.sms_failed, color: Colors.pinkAccent, size: 28),
                    Text(
                      '3117',
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Numéro d'alerte 3117",
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Un risque pour votre sécurité ou celle des autres ?',
                      style: TextStyle(color: AppColors.white, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.secondary, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}

class TravelAlertDialog extends StatelessWidget {
  const TravelAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Numéro d'alerte 3117",
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Icons.close, color: AppColors.secondary),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "En cas d'urgence sur les réseaux SNCF ou Île-de-France Mobilités",
              style: TextStyle(color: AppColors.white, fontSize: 15),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {},
                    child: Text("Appeler le 31 17", style: TextStyle(color: Colors.black)),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      side: BorderSide(color: AppColors.secondary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {},
                    child: Text("SMS au 31 17 7", style: TextStyle(color: AppColors.secondary)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Si vous êtes témoin d'une situation qui présente un risque pour votre sécurité ou celle des autres voyageurs, appelez le 31 17, envoyez un SMS au 31 17 7, ou utilisez l'application 31 17.",
              style: TextStyle(color: AppColors.white, fontSize: 14),
            ),
            SizedBox(height: 10),
            Text(
              "Service disponible 24h/24 - 7j/7",
              style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            SizedBox(height: 10),
            Text(
              "Les informations clés à donner au moment de l'appel :\n• La nature de l'appel : malaise ou danger encouru par un voyageur.\n• La localisation : gare et heure de départ, gare d'arrivée, l'endroit où se passe l'incident (avant, milieu, arrière du train / hall, voie en gare).",
              style: TextStyle(color: AppColors.white, fontSize: 13),
            ),
            SizedBox(height: 10),
            Text(
              "TÉL. 31 17, appel gratuit et numéro enregistré.\nSMS 31 17 7, prix de votre opérateur.",
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
