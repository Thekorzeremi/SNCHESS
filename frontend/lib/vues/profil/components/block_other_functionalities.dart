import 'package:flutter/material.dart';
import 'package:frontend/color.dart';
import 'package:frontend/services/firebaseAuthentificationService.dart';
import 'package:frontend/vues/landing.dart';

class BlockOtherFunctionalities extends StatelessWidget {
  const BlockOtherFunctionalities({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Text(
            "Autres fonctionnalités",
            style: TextStyle(color: AppColors.white, fontSize: 22),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () => {},
          child: Container(
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
                  "Reporter un bug",
                  style: TextStyle(color: AppColors.white, fontSize: 16),
                ),
                Icon(Icons.bug_report, color: AppColors.secondary),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            FirebaseAuthentificationService().signOutCurrentUser();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LandingPage()),
              (route) => false,
            );
          },
          child: Container(
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
                  "Me déconnecter",
                  style: TextStyle(color: AppColors.white, fontSize: 16),
                ),
                Icon(Icons.logout, color: AppColors.secondary),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          child: Container(
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
                  "Supprimer mon compte",
                  style: TextStyle(color: AppColors.white, fontSize: 16),
                ),
                Icon(Icons.delete_outlined, color: AppColors.secondary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
