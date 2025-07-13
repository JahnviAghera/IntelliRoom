import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intelli_room/app/app_state_notifier.dart';
import 'package:intelli_room/features/auth/auth_service.dart';
import 'package:intelli_room/features/auth/login_screen.dart';
import 'package:intelli_room/features/professor/professor_dashboard.dart';
import 'package:intelli_room/features/student/student_dashboard.dart';

import 'app/app_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IntelliRoom',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    if (appState.isLoggedIn) {
      switch (appState.currentUser!.role) {
        case UserRole.student:
          return const StudentDashboard();
        case UserRole.professor:
          return ChangeNotifierProvider(
            create: (context) => ProfessorState(),
            child: const ProfessorDashboard(),
          );
      }
    } else {
      return const LoginScreen();
    }
  }
}
