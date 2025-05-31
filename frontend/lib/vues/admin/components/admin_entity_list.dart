import 'package:flutter/material.dart';

class AdminEntityList extends StatelessWidget {
  final List<Widget> children;
  const AdminEntityList({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return ListView(children: children);
  }
}
