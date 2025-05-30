import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/color.dart';
import 'package:frontend/services/firebaseAuthentificationService.dart';
import 'package:frontend/vues/landing.dart';

class BlockOtherFunctionalities extends StatelessWidget {
  const BlockOtherFunctionalities({super.key});

  void _showBugReportModal(BuildContext context) {
    final TextEditingController bugController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          "Signaler un bug",
          style: TextStyle(color: Colors.white),
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Décrivez le problème rencontré :",
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: bugController,
                maxLines: 5,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Ex. : L'application plante quand je clique sur...",
                  hintStyle: const TextStyle(color: Colors.white30),
                  filled: true,
                  fillColor: AppColors.primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                cursorColor: AppColors.secondary,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Merci de décrire le bug.";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Annuler", style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: AppColors.card,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.check_circle, color: Colors.green, size: 48),
                        SizedBox(height: 12),
                        Text(
                          "Merci pour votre retour !",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Nous allons examiner ce bug rapidement.",
                          style: TextStyle(color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
            child: const Text("Envoyer"),
          ),
        ],
      ),
    );
  }

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
          onTap: () => _showBugReportModal(context),
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
                  "Signaler un bug",
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
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Mot de passe",
                        hintStyle: TextStyle(color: Colors.white30),
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
