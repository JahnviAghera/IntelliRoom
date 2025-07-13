import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../models/alert.dart';
import '../utils/app_theme.dart';
import '../widgets/alert_card.dart';
import '../widgets/alert_stat_card.dart';

class AdminAlertsScreen extends StatefulWidget {
  const AdminAlertsScreen({Key? key}) : super(key: key);

  @override
  _AdminAlertsScreenState createState() => _AdminAlertsScreenState();
}

class _AdminAlertsScreenState extends State<AdminAlertsScreen> {
  int? selectedAlert;
  String filterLevel = 'all';

  final List<Alert> alerts = [
    Alert(
      id: 1,
      level: 'high',
      type: 'security_violation',
      student: 'John Doe (ID: 12345)',
      timestamp: '2024-12-15 14:23:15',
      location: 'CS-201',
      description: 'Multiple screenshot attempts during evaluation',
      details: {
        'attempts': 5,
        'duration': '2 minutes',
        'quiz': 'Data Structures Final',
        'actions': ['Right-click blocked', 'Print Screen detected', 'Alt+Tab attempted']
      },
      status: 'active',
    ),
    Alert(
      id: 2,
      level: 'medium',
      type: 'attendance_anomaly',
      student: 'Jane Smith (ID: 12346)',
      timestamp: '2024-12-15 10:15:30',
      location: 'CS-202',
      description: 'Unusual location variance during check-in',
      details: {
        'variance': '15 meters',
        'expected': 'CS-202 Classroom',
        'actual': 'CS Building Lobby',
        'resolution': 'Manual verification required'
      },
      status: 'pending',
    ),
    Alert(
      id: 3,
      level: 'low',
      type: 'system_notice',
      student: 'Alex Johnson (ID: 12347)',
      timestamp: '2024-12-15 09:45:12',
      location: 'CS-201',
      description: 'Biometric scan retry successful',
      details: {
        'attempts': 2,
        'method': 'Fingerprint to Face recognition',
        'reason': 'Sensor reading error',
        'resolved': true
      },
      status: 'resolved',
    ),
    Alert(
      id: 4,
      level: 'high',
      type: 'access_violation',
      student: 'Mike Wilson (ID: 12348)',
      timestamp: '2024-12-15 11:30:45',
      location: 'Unknown',
      description: 'Evaluation access attempted without proper check-in',
      details: {
        'token': 'Invalid token used',
        'attempts': 3,
        'ip': '192.168.1.999',
        'blocked': true
      },
      status: 'active',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredAlerts = alerts.where((alert) {
      return filterLevel == 'all' || alert.level == filterLevel;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Alerts'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Security Alerts',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Monitor and respond to security events',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                AlertStatCard(
                  title: 'High Priority',
                  count: alerts.where((a) => a.level == 'high').length.toString(),
                  icon: LucideIcons.badgeAlert,
                  color: AppTheme.danger,
                ),
                AlertStatCard(
                  title: 'Medium Priority',
                  count: alerts.where((a) => a.level == 'medium').length.toString(),
                  icon: LucideIcons.eye,
                  color: AppTheme.warning,
                ),
                AlertStatCard(
                  title: 'Active Alerts',
                  count: alerts.where((a) => a.status == 'active').length.toString(),
                  icon: LucideIcons.shield,
                  color: AppTheme.info,
                ),
                AlertStatCard(
                  title: 'Total Today',
                  count: alerts.length.toString(),
                  icon: LucideIcons.clock,
                  color: AppTheme.primary,
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildFilter(),
            const SizedBox(height: 16),
            ...filteredAlerts.map((alert) {
              return AlertCard(
                alert: alert,
                isSelected: selectedAlert == alert.id,
                onTap: () {
                  setState(() {
                    if (selectedAlert == alert.id) {
                      selectedAlert = null;
                    } else {
                      selectedAlert = alert.id;
                    }
                  });
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Filter by priority:',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          DropdownButton<String>(
            value: filterLevel,
            underline: const SizedBox(),
            onChanged: (String? newValue) {
              setState(() {
                filterLevel = newValue!;
              });
            },
            items: <String>['all', 'high', 'medium', 'low']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value[0].toUpperCase() + value.substring(1)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
