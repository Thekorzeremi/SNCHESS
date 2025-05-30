import 'package:firebase_auth/firebase_auth.dart';
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
          onTap: () async {
            final TextEditingController passwordController =
                TextEditingController();

            final confirm = await showDialog<bool>(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                backgroundColor: AppColors.card,
                title: Text(
                  "Confirmation",
                  style: TextStyle(color: Colors.white),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Entrez votre mot de passe pour confirmer :",
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      cursorColor: AppColors.secondary,
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Mot de passe",
                        hintStyle: TextStyle(color: Colors.white30),
                        focusColor: AppColors.secondary,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondary),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondary),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      "Annuler",
                      style: TextStyle(color: AppColors.secondary),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      "Supprimer",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );

            if (confirm == true) {
              try {
                final email = FirebaseAuth.instance.currentUser?.email;
                final password = passwordController.text.trim();

                if (email != null && password.isNotEmpty) {
                  await FirebaseAuthentificationService()
                      .deleteCurrentUserWithReauth(
                        email: email,
                        password: password,
                      );

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => LandingPage(
                        successMessage: "Compte supprimé avec succès.",
                      ),
                    ),
                    (route) => false,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Mot de passe requis.")),
                  );
                }
              } on FirebaseAuthException catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Erreur : ${e.message}")),
                );
              }
            }
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
