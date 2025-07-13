import 'package:flutter/material.dart';

import 'course_management_screen.dart';

class ProfessorDashboard extends StatelessWidget {
  const ProfessorDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Professor Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome, Professor!'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CourseManagementScreen(),
                  ),
                );
              },
              child: const Text('Manage Courses'),
            ),
          ],
        ),
      ),
    );
  }
}
