import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class FirebaseAuthentificationService {
  void registerWithEmailAndPassword(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user?.updateDisplayName('$firstName $lastName');
      await userCredential.user?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> connectWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('User connected successfully');
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  void signOutCurrentUser() {
    try {
      FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUserProfile({
    String? newEmail,
    String? newPassword,
    String? firstName,
    String? lastName,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (newEmail != null && newEmail.isNotEmpty) {
        await user?.verifyBeforeUpdateEmail(newEmail);
      }

      if (newPassword != null && newPassword.isNotEmpty) {
        await user?.updatePassword(newPassword);
      }

      if (firstName != null &&
          lastName != null &&
          (firstName.isNotEmpty || lastName.isNotEmpty)) {
        await user?.updateDisplayName('$firstName $lastName');
      }

      await user?.reload();
      print('User profile updated');
    } on FirebaseAuthException catch (e) {
      print('Error updating profile: ${e.code} - ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
    }
  }

  Future<void> reauthenticate(String email, String password) async {
    final user = FirebaseAuth.instance.currentUser;
    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await user?.reauthenticateWithCredential(credential);
  }
}
