import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firebaseDatabaseService.dart';
import 'vues/navbar.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await FirebaseDatabaseService().loadFixturesDataInFirebaseDataBase();
  runApp(const SNCHESS());
}

class SNCHESS extends StatelessWidget {
  const SNCHESS({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navbar());
  }
}