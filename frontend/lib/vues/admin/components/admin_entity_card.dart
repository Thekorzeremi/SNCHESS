import 'package:flutter/material.dart';
import '../../../color.dart';

class AdminEntityCard extends StatelessWidget {
  final List<Widget> infoWidgets;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const AdminEntityCard({
    super.key,
    required this.infoWidgets,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.card,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: infoWidgets,
              ),
            ),
            if (onEdit != null)
              IconButton(
                icon: const Icon(Icons.edit, color: AppColors.secondary, size: 20),
                onPressed: onEdit,
                tooltip: 'Editer',
              ),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent, size: 20),
                onPressed: onDelete,
                tooltip: 'Supprimer',
              ),
          ],
        ),
      ),
    );
  }
} 