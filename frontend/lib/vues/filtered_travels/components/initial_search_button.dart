import 'package:flutter/material.dart';
import '../../../color.dart';

class InitialSearchButton extends StatelessWidget {
  final VoidCallback onTap;
  const InitialSearchButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Vous retournez à la recherche initiale ?',
            style: TextStyle(color: AppColors.secondary),
          ),
        ],
      ),
    );
  }
}
