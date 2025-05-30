import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/color.dart';
import 'package:frontend/vues/components/text_form_field.dart';
import 'package:frontend/vues/profil/components/block_benefits.dart';
import 'package:frontend/vues/profil/components/block_helps.dart';
import 'package:frontend/vues/profil/components/block_other_functionalities.dart';
import 'package:ionicons/ionicons.dart';
import '../../services/firebaseAuthentificationService.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isEditing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final displayName = user.displayName ?? '';
      final parts = displayName.split(' ');

      setState(() {
        _firstNameController.text = parts.isNotEmpty ? parts.first : '';
        _lastNameController.text = parts.length > 1
            ? parts.sublist(1).join(' ')
            : '';
        _emailController.text = user.email ?? '';
        _passwordController.text = '';
        _confirmPasswordController.text = '';
      });
    }
  }

  void toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void saveChanges() async {
    final email = _emailController.text.trim();
    final newPassword = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final currentPassword = _currentPasswordController.text.trim();

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Les mots de passe ne correspondent pas.")),
      );
      return;
    }

    if (currentPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Merci de rentrer votre mot de passe actuel pour modifier le profil.",
          ),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    _showLoadingDialog();

    try {
      final authService = FirebaseAuthentificationService();

      final currentEmail = FirebaseAuth.instance.currentUser?.email ?? '';
      await authService.reauthenticate(currentEmail, currentPassword);

      await authService.updateUserProfile(
        newEmail: email,
        newPassword: newPassword.isNotEmpty ? newPassword : null,
        firstName: firstName,
        lastName: lastName,
      );

      Navigator.of(context).pop();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Profil mis à jour avec succès.")));

      // On vide les champs de mot de passe apres la mise à jour
      _currentPasswordController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();

      toggleEditMode();
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erreur Firebase : ${e.message}")));
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erreur : ${e.toString()}")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          Center(child: CircularProgressIndicator(color: AppColors.secondary)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                    Row(
                      children: [
                        IconButton(
                          onPressed: saveChanges,
                          icon: Icon(
                            Icons.save,
                            color: AppColors.white,
                            size: 24,
                          ),
                        ),
                        IconButton(
                          onPressed: toggleEditMode,
                          icon: Icon(
                            Ionicons.close,
                            color: AppColors.white,
                            size: 24,
                          ),
                        ),
                      ],
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
              if (isEditing) ...[
                MyInputField(
                  label: "Mot de passe actuel",
                  controller: _currentPasswordController,
                  textColor: AppColors.white,
                  borderColor: AppColors.secondary,
                  obscureText: true,
                  enabled: true,
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
              ],
              SizedBox(height: 24),
              BlockBenefits(),
              SizedBox(height: 20),
              BlockHelps(),
              SizedBox(height: 20),
              BlockOtherFunctionalities(),
            ],
          ),
        ),
      ),
    );
  }
}
