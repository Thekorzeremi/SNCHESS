import 'package:flutter/material.dart';
import 'package:frontend/color.dart';

class FakeGooglePayButton extends StatelessWidget {
  final BuildContext context;
  const FakeGooglePayButton({super.key, required this.context});

  void simulatePayment() async {
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

    Navigator.of(context).pop();
    Navigator.of(context).pop();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _SuccessDialog(),
    );

    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pop();

    // TODO: ajouter le trajet à l'utilisateur (et le rediriger vers celui-ci ?)
    // + supprimer le trajet de la liste ?
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
