import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class FirebaseAuthentificationService {

  void checkIfUserIsConnected() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("User is signed out !");
      } else {
        print("User is signed in !");
      }
    });
  }

  void registerWithEmailAndPassword(String email, String password, String FirstName, String LastName) async {
    try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        await userCredential.user?.updateDisplayName('$FirstName $LastName');
        print('User registered successfully : $email. Welcome $FirstName $LastName!');
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

  void connectWithEmailAndPassword(String email, String password) async {
    try {
        UserCredential userCredential = await
         FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
            final user = userCredential.user;
            final displayName = user?.displayName ?? '';
            print('User signed in successfully. Welcome back $displayName !');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('Error: ${e.message}');
      }
    }
  }

  void signOutCurrentUser() {
    try {
      FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }
}
