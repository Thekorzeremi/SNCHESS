import 'package:flutter/material.dart';
import 'package:snct/color.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../services/firebaseAuthentificationService.dart';
import 'dart:math';

class FakeGooglePayButton extends StatelessWidget {
  final BuildContext context;
  final Map<String, dynamic> travelData;
  final Map<String, dynamic> gareDepart;
  final Map<String, dynamic> gareArrivee;
  final Map<String, dynamic> tram;
  final VoidCallback? onPaymentStart;
  const FakeGooglePayButton({
    super.key,
    required this.context,
    required this.travelData,
    required this.gareDepart,
    required this.gareArrivee,
    required this.tram,
    this.onPaymentStart,
  });

  void simulatePayment() async {
    if (onPaymentStart != null) onPaymentStart!();
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Center(
          child: Container(
            width: 100,
            height: 100,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(0, 0, 0, 0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      );

      await Future.delayed(Duration(seconds: 2));
      if (Navigator.of(context).canPop()) Navigator.of(context).pop();

      final userInfo = FirebaseAuthentificationService()
          .getCurrentUserInformation();
      final email = userInfo?['email'];
      final db = FirebaseDatabase.instance.ref();
      final usersSnapshot = await db.child('fixtures/users').get();
      int? userIndex;
      Map<dynamic, dynamic>? userData;
      if (usersSnapshot.exists) {
        final users = usersSnapshot.value as List<dynamic>;
        for (int i = 0; i < users.length; i++) {
          final user = users[i];
          if (user != null && user['email'] == email) {
            userIndex = i;
            userData = user;
            break;
          }
        }
      }
      if (userIndex == null || userData == null) {
        userIndex = usersSnapshot.exists
            ? (usersSnapshot.value as List).length
            : 0;
        await db.child('fixtures/users/$userIndex').set({
          'email': email,
          'ticket': [],
        });
        userData = {'email': email, 'ticket': []};
      }
      final random = Random();
      final qrCode =
          DateTime.now().millisecondsSinceEpoch.toString() +
          random.nextInt(9999).toString();
      final seatNb = (random.nextInt(60) + 1).toString();
      final wagonNb = (random.nextInt(8) + 1).toString();
      final ticket = {
        'qr_code': qrCode,
        'seatNb': seatNb,
        'wagonNb': wagonNb,
        'trip': {
          ...travelData['trip'],
          'vehicle': tram,
          'route': {
            ...travelData['trip']['route'],
            'fromStation': gareDepart,
            'toStation': gareArrivee,
          },
        },
      };
      List<dynamic> tickets = [];
      if (userData == null || userData['ticket'] == null) {
        tickets = [];
      } else if (userData['ticket'] is List) {
        tickets = (userData['ticket'] as List).where((t) => t != null).toList();
      } else if (userData['ticket'] is Map) {
        tickets = (userData['ticket'] as Map).values
            .where((t) => t != null)
            .toList();
      }
      tickets.add(ticket);
      await db.child('fixtures/users/$userIndex/ticket').set(tickets);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const _SuccessDialog(),
      );
      await Future.delayed(Duration(seconds: 2));
      if (Navigator.of(context).canPop()) Navigator.of(context).pop();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Billet acheté avec succès !')));
    } catch (e) {
      print('Erreur lors de l\'achat du billet: $e');
      if (Navigator.of(context).canPop()) Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'achat du billet: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: simulatePayment,
      child: Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.payments, color: Colors.white, size: 24),
            SizedBox(width: 10),
            Text(
              'Acheter avec Google Pay',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessDialog extends StatefulWidget {
  const _SuccessDialog();

  @override
  State<_SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<_SuccessDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    )..forward();

    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 10),
              Text(
                "Paiement réussi !",
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  decoration: TextDecoration.none,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
