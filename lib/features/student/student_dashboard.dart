import 'package:flutter/material.dart';
import 'package:intelli_room/features/common/screens/personal_dashboard_screen.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersonalDashboardScreen(
      onViewAuditLog: () {
        // Navigate to audit log
      },
    );
  }
}
