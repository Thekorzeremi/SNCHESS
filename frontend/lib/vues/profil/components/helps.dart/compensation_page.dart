import 'package:flutter/material.dart';
import 'package:snct/color.dart';

class CompensationPage extends StatelessWidget {
  const CompensationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          "Compensation en cas de retard",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                '''
En cas de retard de votre tram de plus de 15 minutes, vous pouvez demander une compensation.

Conditions :
- Le retard doit être imputable au transporteur.
- Le délai doit être supérieur à 15 minutes.
- La demande doit être faite dans un délai de 7 jours suivant le voyage.

Montant de la compensation :
- Retard entre 15 et 30 minutes : bon de réduction de 25%
- Retard entre 30 et 60 minutes : remboursement de 50%
- Retard supérieur à 60 minutes : remboursement intégral

Procédure :
1. Conservez la référence de votre billet.
2. Accédez à la section "Bulletin de retard".
3. Renseignez votre référence et la date du voyage.
4. Un e-mail de confirmation vous sera envoyé sous 48h.

Pour toute assistance, vous pouvez également contacter notre service client.
              ''',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
