import 'package:flutter/material.dart';
import '../../../color.dart';

class ShowPriceButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ShowPriceButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            padding: EdgeInsets.symmetric(vertical: 16),
            elevation: 0,
          ),
          onPressed: onPressed,
          child: Text(
            'Voir les prix',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
} 