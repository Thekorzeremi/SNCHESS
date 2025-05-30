import 'package:flutter/material.dart';
import '../../../color.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const SearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Où voulez-vous partir ?',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
              style: TextStyle(fontSize: 20, color: Colors.grey[600]),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 6),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.search, color: AppColors.primary),
              onPressed: onSearch,
            ),
          ),
        ],
      ),
    );
  }
}
