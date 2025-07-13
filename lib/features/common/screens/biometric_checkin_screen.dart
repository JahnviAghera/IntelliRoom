import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../utils/app_theme.dart';

class BiometricCheckinScreen extends StatefulWidget {
  final VoidCallback onCheckInComplete;

  const BiometricCheckinScreen({Key? key, required this.onCheckInComplete})
      : super(key: key);

  @override
  _BiometricCheckinScreenState createState() => _BiometricCheckinScreenState();
}

class _BiometricCheckinScreenState extends State<BiometricCheckinScreen> {
  int _step = 1;
  bool _isVerifying = false;

  void _handleBiometricScan() {
    setState(() {
      _isVerifying = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isVerifying = false;
        _step = 2;
      });
    });
  }

  void _handleLocationCheck() {
    setState(() {
      _isVerifying = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isVerifying = false;
        _step = 3;
      });
    });
  }

  void _handleWifiCheck() {
    setState(() {
      _isVerifying = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isVerifying = false;
      });
      widget.onCheckInComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade50,
              Colors.indigo.shade100,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildProgressBar(),
                    const SizedBox(height: 24),
                    _buildStepContent(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            LucideIcons.shield,
            color: AppTheme.primary,
            size: 40,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Secure Check-In',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Complete verification to access evaluations',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Step $_step of 3'),
            Text('${(_step / 3 * 100).round()}%'),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: _step / 3,
          backgroundColor: Colors.grey.shade300,
          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primary),
        ),
      ],
    );
  }

  Widget _buildStepContent() {
    switch (_step) {
      case 1:
        return _buildStep(
          icon: LucideIcons.fingerprint,
          title: 'Biometric Verification',
          description:
              'Place your finger on the sensor or look at the camera',
          buttonText: 'Start Biometric Scan',
          onPressed: _handleBiometricScan,
        );
      case 2:
        return _buildStep(
          icon: LucideIcons.mapPin,
          title: 'Location Verification',
          description: 'Confirming you\'re in the classroom',
          buttonText: 'Verify Location',
          onPressed: _handleLocationCheck,
          previousStepVerified: true,
          previousStepText: 'Biometric verification complete',
        );
      case 3:
        return _buildStep(
          icon: LucideIcons.wifi,
          title: 'Network Verification',
          description: 'Connecting to classroom WiFi',
          buttonText: 'Connect to WiFi',
          onPressed: _handleWifiCheck,
          previousStepVerified: true,
          previousStepText: 'Location confirmed',
        );
      default:
        return Container();
    }
  }

  Widget _buildStep({
    required IconData icon,
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onPressed,
    bool previousStepVerified = false,
    String previousStepText = '',
  }) {
    return Column(
      children: [
        if (previousStepVerified) ...[
          _buildVerificationStatus(previousStepText),
          const SizedBox(height: 16),
        ],
        Icon(icon, size: 64, color: AppTheme.primary),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _isVerifying ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: _isVerifying
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text(buttonText),
        ),
      ],
    );
  }

  Widget _buildVerificationStatus(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(LucideIcons.check,
              color: AppTheme.success, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(color: AppTheme.success),
          ),
        ],
      ),
    );
  }
}