import 'package:flutter/material.dart';
import 'package:frontend/color.dart';
import 'package:frontend/vues/components/text_form_field.dart';
import 'package:ionicons/ionicons.dart';
import '../services/firebaseAuthentificationService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final FirebaseAuthentificationService _authService = FirebaseAuthentificationService();

  void login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Merci de remplir tous les champs !")),
      );
      return;
    };

    _authService.connectWithEmailAndPassword(email, password);
  }

  void showForgotPasswordDialog() {
    final TextEditingController emailResetController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.primary,
          title: Text(
            "Mot de passe oublié",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Rentrer votre adresse email pour recevoir lien de réinitialisation",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20),
              MyInputField(
                label: "Votre adresse email",
                controller: emailResetController,
                textColor: Colors.white,
                borderColor: AppColors.secondary,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Annuler", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppColors.secondary),
              ),
              onPressed: () {
                final email = emailResetController.text.trim();
                if (email.isNotEmpty) {
                  sendNewPassword(email);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Merci de rentrer votre email !", style: TextStyle(color: Colors.black),),
                      backgroundColor: AppColors.secondary,
                    ),
                  );
                  return;
                }
              },
              child: Text("Envoyer", style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  void sendNewPassword(String email) {
    // TODO: ajouter la logique pour renvoyer un password
    print("Envoi d'un nouveau mot de passe à : $email");
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
          "Connexion",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Ionicons.happy_outline, size: 48, color: Colors.white),
                SizedBox(height: 16),
                Text(
                  "Bon retour parmi nous !",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                SizedBox(height: 60),
                MyInputField(
                  label: "Adresse email (exemple@mail.fr)",
                  controller: _emailController,
                  textColor: AppColors.white,
                  borderColor: AppColors.secondary,
                ),
                SizedBox(height: 16),
                MyInputField(
                  label: "Mot de passe",
                  obscureText: true,
                  controller: _passwordController,
                  textColor: AppColors.white,
                  borderColor: AppColors.secondary,
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: showForgotPasswordDialog,
                    child: Text(
                      "Mot de passe oublié ?",
                      style: TextStyle(color: AppColors.secondary),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      AppColors.secondary,
                    ),
                    fixedSize: WidgetStateProperty.all(Size(140, 40)),
                  ),
                  onPressed: login,
                  child: Text(
                    "Se connecter",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
