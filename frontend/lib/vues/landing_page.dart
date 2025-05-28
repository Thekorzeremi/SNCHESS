import 'package:flutter/material.dart';
import 'package:frontend/color.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 80),
          Container(
            height: 220,
            width: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.card, AppColors.primary],
              ),
            ),
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Votre compte",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primary,
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(69, 201, 116, 200),
                          ),
                          child: Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 201, 116, 200),
                            size: 15,
                          ),
                        ),
                        Text(
                          "Compagnons de voyage",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primary,
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 5, 15, 5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(69, 116, 201, 177),
                          ),
                          child: Icon(
                            Icons.train,
                            color: Color.fromARGB(255, 116, 201, 177),
                            size: 15,
                          ),
                        ),
                        Text(
                          "Voyage à venir",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primary,
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 5, 15, 5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(69, 218, 198, 99),
                          ),
                          child: Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 218, 198, 99),
                            size: 15,
                          ),
                        ),
                        Text(
                          "Itininéraires favoris",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 50),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Un seul identifiant",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Avec votre compte Mon identifiant SNCHESS, retrouvez tous vos voyages, abonnements, cartes...",
                style: TextStyle(color: AppColors.white, fontSize: 14),
              ),
            ),
          ),
          SizedBox(height: 45),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.secondary),
              fixedSize: WidgetStateProperty.all(Size(160, 40)),
            ),
            child: Text(
              "Créer un compte",
              style: TextStyle(color: Colors.black),
            ),
          ),

          SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.primary),
              fixedSize: WidgetStateProperty.all(Size(160, 40)),
              side: WidgetStateProperty.all(
                BorderSide(color: AppColors.secondary, width: 2),
              ),
            ),
            child: Text(
              "Se connecter",
              style: TextStyle(color: AppColors.secondary),
            ),
          ),
        ],
      ),
    );
  }
}
