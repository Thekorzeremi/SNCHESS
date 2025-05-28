import 'package:flutter/material.dart';
import 'package:frontend/color.dart';
import 'package:frontend/vues/components/text_form_field.dart';
import 'package:ionicons/ionicons.dart';
import '../services/firebaseAuthentificationService.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final FirebaseAuthentificationService _authService = FirebaseAuthentificationService();

  void register() {
    final nom = _nomController.text.trim();
    final prenom = _prenomController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    _authService.registerWithEmailAndPassword(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 32),
        ),

        title: Text(
          "Création de votre compte",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(40, 60, 40, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyInputField(
              label: "Nom",
              controller: _nomController,
              textColor: AppColors.white,
              borderColor: AppColors.secondary,
            ),
            SizedBox(height: 12),
            MyInputField(
              label: "Prénom",
              controller: _prenomController,
              textColor: AppColors.white,
              borderColor: AppColors.secondary,
            ),
            SizedBox(height: 12),
            MyInputField(
              label: "Adresse email (exemple@mail.fr)",
              controller: _emailController,
              textColor: AppColors.white,
              borderColor: AppColors.secondary,
            ),
            SizedBox(height: 12),
            MyInputField(
              label: "Mot de passe",
              obscureText: true,
              controller: _passwordController,
              textColor: AppColors.white,
              borderColor: AppColors.secondary,
            ),
            SizedBox(height: 12),
            MyInputField(
              label: "Confirmer le mot de passe",
              obscureText: true,
              controller: _confirmPasswordController,
              textColor: AppColors.white,
              borderColor: AppColors.secondary,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppColors.secondary),
                fixedSize: WidgetStateProperty.all(Size(160, 40)),
              ),
              onPressed: register,
              child: Text("S'inscrire", style: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 32),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Column(
                children: [
                  Icon(Ionicons.key_outline, color: AppColors.white, size: 42),
                  SizedBox(height: 8),
                  Text(
                    "Connexions sécurisées",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Un identifiant unique pour accéder à tous les espaces SNCF.",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Icon(
                    Ionicons.alarm_outline,
                    color: AppColors.white,
                    size: 42,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Réservations facilitées",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Un profil personnalisé pour gagner du temps lors de vos réservations.",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Icon(
                    Ionicons.laptop_outline,
                    color: AppColors.white,
                    size: 42,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Voyages maîtrisés",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Retrouvez tous vos billets et vos justificatifs où que vous soyez.",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
