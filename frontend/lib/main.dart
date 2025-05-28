import 'package:flutter/material.dart';
import 'vues/navbar.dart';

void main() {
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