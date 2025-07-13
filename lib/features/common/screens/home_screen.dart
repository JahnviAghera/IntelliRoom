import 'package:flutter/material.dart';
import 'package:intelli_room/features/common/screens/personal_dashboard_screen.dart';
import 'package:intelli_room/features/common/screens/qr_generation_screen.dart';
import 'package:intelli_room/features/common/screens/secure_quiz_mode_screen.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../utils/app_theme.dart';
import 'admin_alerts_screen.dart';
import 'audit_log_screen.dart';
import 'biometric_checkin_screen.dart';
import 'evaluation_access_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _currentScreen = 'home';
  String _userRole = 'student'; // or 'admin'

  void _navigateTo(String screen) {
    setState(() {
      _currentScreen = screen;
    });
  }

  Widget _renderScreen() {
    switch (_currentScreen) {
      case 'checkin':
        return BiometricCheckinScreen(
            onCheckInComplete: () => _navigateTo('qr'));
      case 'qr':
        return QrGenerationScreen(onContinue: () => _navigateTo('access'));
      case 'access':
        return EvaluationAccessScreen(
            onAccessGranted: () => _navigateTo('quiz'));
      case 'quiz':
        return SecureQuizModeScreen(
            onQuizComplete: () => _navigateTo('dashboard'));
      case 'dashboard':
        return PersonalDashboardScreen(
            onViewAuditLog: () => _navigateTo('audit'));
      case 'audit':
        return const AuditLogScreen();
      case 'admin':
        return const AdminAlertsScreen();
      default:
        return _buildHomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentScreen == 'home'
          ? AppBar(
              title: const Text('AIA'),
              actions: [
                IconButton(
                  icon: const Icon(LucideIcons.user),
                  onPressed: () {
                    // Handle profile/settings
                  },
                ),
              ],
            )
          : null,
      drawer: _currentScreen == 'home' ? _buildDrawer() : null,
      body: _renderScreen(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppTheme.primary,
            ),
            child: Text(
              'AIA Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_rounded),
            title: const Text('Home'),
            onTap: () {
              _navigateTo('home');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(LucideIcons.chartBar),
            title: const Text('Dashboard'),
            onTap: () {
              _navigateTo('dashboard');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(LucideIcons.clock),
            title: const Text('Audit Log'),
            onTap: () {
              _navigateTo('audit');
              Navigator.pop(context);
            },
          ),
          if (_userRole == 'admin')
            ListTile(
              leading: const Icon(LucideIcons.badgeAlert),
              title: const Text('Alerts'),
              onTap: () {
                _navigateTo('admin');
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildHomeScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Welcome to AIA',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Attendance & Intelligence Analyzer',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => _navigateTo('checkin'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              textStyle: const TextStyle(fontSize: 18),
            ),
            child: const Text('Start Secure Check-in'),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => _navigateTo('dashboard'),
            child: const Text('View Dashboard'),
          ),
          if (_userRole == 'admin')
            TextButton(
              onPressed: () => _navigateTo('admin'),
              child: const Text('Admin Alerts'),
            ),
        ],
      ),
    );
  }
}
