import 'package:flutter/material.dart';
import 'package:frontend/color.dart';

class BlockBenefits extends StatelessWidget {
  const BlockBenefits({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Text(
            "Vos avantages",
            style: TextStyle(color: AppColors.white, fontSize: 22),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 65,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.card,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Commander votre Navigros",
                    style: TextStyle(color: AppColors.white, fontSize: 16),
                  ),
                  Text(
                    "Recevez la gratuitement chez vous !",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              Icon(Icons.keyboard_arrow_right, color: AppColors.secondary),
            ],
          ),
        ),
      ],
    );
  }
}
