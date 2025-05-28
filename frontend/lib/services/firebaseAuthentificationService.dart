import 'package:firebase_auth/firebase_auth.dart';
import 'package:dotenv/dotenv.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class FirebaseAuthentificationService {
  late String email;
  late String password;


  FirebaseAuthentificationService() {
    var env = DotEnv(includePlatformEnvironment: true)..load();
    email = env['FIREBASE_TEST_EMAIL'] ?? "";
    password = env['FIREBASE_TEST_PASSWORD'] ?? "";
  }

  void checkIfUserIsConnected() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("User is signed out !");
      } else {
        print("User is signed in !");
      }
    });
  }

  void registerWithEmailAndPassword() async {
    try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
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

  void connectWithEmailAndPassword() async {
    try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
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
