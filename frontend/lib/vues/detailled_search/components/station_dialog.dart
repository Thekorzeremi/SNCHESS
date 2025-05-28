import 'package:flutter/material.dart';
import '../../../color.dart';

class StationDialog extends StatelessWidget {
  final List<String> gares;
  final void Function(String) onSelected;
  final String title;
  const StationDialog({super.key, required this.gares, required this.onSelected, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.primary,
      title: Text(title, style: TextStyle(color: AppColors.white)),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: gares.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(gares[index], style: TextStyle(color: Colors.white)),
              onTap: () {
                onSelected(gares[index]);
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
    );
  }
} 