import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../models/alert.dart';
import '../utils/app_theme.dart';

class AlertCard extends StatelessWidget {
  final Alert alert;
  final bool isSelected;
  final VoidCallback onTap;

  const AlertCard({
    Key? key,
    required this.alert,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(getTypeIcon(alert.type), color: getLevelColor(alert.level)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alert.description,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${alert.student} • ${alert.timestamp}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    isSelected ? LucideIcons.chevronUp : LucideIcons.chevronDown,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            if (isSelected) _buildDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetails() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Alert Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...alert.details.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${entry.key}: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(entry.value.toString()),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getLevelColor(String level) {
    switch (level) {
      case 'high':
        return AppTheme.danger;
      case 'medium':
        return AppTheme.warning;
      case 'low':
        return AppTheme.info;
      default:
        return AppTheme.secondary;
    }
  }

  IconData getTypeIcon(String type) {
    switch (type) {
      case 'security_violation':
        return LucideIcons.shield;
      case 'attendance_anomaly':
        return LucideIcons.mapPin;
      case 'access_violation':
        return LucideIcons.eye;
      default:
        return LucideIcons.badgeAlert;
    }
  }
}
