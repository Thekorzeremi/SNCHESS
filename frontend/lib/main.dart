import 'package:flutter/material.dart';
import 'vues/navbar.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
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