import 'package:flutter/material.dart';
import 'package:frontend/color.dart';
import 'package:frontend/vues/components/text_form_field.dart';
import 'package:ionicons/ionicons.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    // TODO: Ajouter la logique pour récupérer les données de l'utilisateur
    _lastNameController.text = 'Doe';
    _firstNameController.text = 'John';
    _emailController.text = 'johndoe@ex.com';
    _passwordController.text = 'password123';
    _confirmPasswordController.text = 'password123';
  }

  void toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void saveChanges() {
    // TODO: Ajouter la logique pour enregistrer les modifications de l'utilisateur
    print(
      _firstNameController.text +
          _lastNameController.text +
          _emailController.text +
          _passwordController.text +
          _confirmPasswordController.text,
    );

    // IF update is ok (pour rebasculer l'icon en edit)
    toggleEditMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        color: AppColors.primary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Modifier votre Profil',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                if (isEditing)
                  IconButton(
                    onPressed: saveChanges,
                    icon: Icon(Icons.save, color: AppColors.white, size: 24),
                  )
                else
                  IconButton(
                    onPressed: toggleEditMode,
                    icon: Icon(Icons.edit, color: AppColors.white, size: 24),
                  ),
              ],
            ),
            SizedBox(height: 20),
            MyInputField(
              label: "Nom",
              controller: _lastNameController,
              textColor: AppColors.white,
              borderColor: AppColors.secondary,
              enabled: isEditing,
            ),
            SizedBox(height: 8),
            MyInputField(
              label: "Prénom",
              controller: _firstNameController,
              textColor: AppColors.white,
              borderColor: AppColors.secondary,
              enabled: isEditing,
            ),
            SizedBox(height: 8),
            MyInputField(
              label: "Adresse email",
              controller: _emailController,
              textColor: AppColors.white,
              borderColor: AppColors.secondary,
              enabled: isEditing,
            ),
            SizedBox(height: 8),
            MyInputField(
              label: "Mot de passe",
              controller: _passwordController,
              textColor: AppColors.white,
              borderColor: AppColors.secondary,
              enabled: isEditing,
              obscureText: true,
            ),
            SizedBox(height: 8),
            MyInputField(
              label: "Confirmer le mot de passe",
              controller: _confirmPasswordController,
              textColor: AppColors.white,
              borderColor: AppColors.secondary,
              enabled: isEditing,
              obscureText: true,
            ),
            SizedBox(height: 24),
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
            SizedBox(height: 20),
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
          ],
        ),
      ),
    );
  }
}
