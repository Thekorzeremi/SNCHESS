import 'package:flutter/material.dart';
import 'package:frontend/color.dart';
import 'package:ionicons/ionicons.dart';

class BlockHelps extends StatelessWidget {
  const BlockHelps({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Text(
            "Aide",
            style: TextStyle(color: AppColors.white, fontSize: 22),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 50,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.card,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Compensation en cas de retard",
                style: TextStyle(color: AppColors.white, fontSize: 16),
              ),
              Icon(Ionicons.arrow_redo_outline, color: AppColors.secondary),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 50,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.card,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bulletin de retard",
                style: TextStyle(color: AppColors.white, fontSize: 16),
              ),
              Icon(Ionicons.arrow_redo_outline, color: AppColors.secondary),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 50,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.card,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Contacter le service client",
                style: TextStyle(color: AppColors.white, fontSize: 16),
              ),
              Icon(Ionicons.call_outline, color: AppColors.secondary),
            ],
          ),
        ),
      ],
    );
  }
}
