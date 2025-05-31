import 'package:flutter/material.dart';
import '../../../color.dart';

class AdminTabs extends StatelessWidget {
  final String selected;
  final List<Map<String, String>> tabs;
  final void Function(String) onSelect;
  const AdminTabs({
    super.key,
    required this.selected,
    required this.tabs,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: tabs.map((tab) {
        final isSelected = selected == tab['key'];
        return GestureDetector(
          onTap: () => onSelect(tab['key']!),
          child: Column(
            children: [
              Text(
                tab['label']!,
                style: TextStyle(
                  color: isSelected ? AppColors.secondary : AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                height: 3,
                width: 40,
                color: isSelected ? AppColors.secondary : Colors.transparent,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
