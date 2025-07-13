import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../utils/app_theme.dart';

class EvaluationAccessScreen extends StatefulWidget {
  final VoidCallback onAccessGranted;
  final bool isAttended;

  const EvaluationAccessScreen({
    Key? key,
    required this.onAccessGranted,
    this.isAttended = true,
  }) : super(key: key);

  @override
  _EvaluationAccessScreenState createState() => _EvaluationAccessScreenState();
}

class _EvaluationAccessScreenState extends State<EvaluationAccessScreen> {
  final TextEditingController _tokenController = TextEditingController();
  bool _isValidating = false;
  String _error = '';

  void _handleTokenSubmit() {
    if (!widget.isAttended) {
      setState(() {
        _error = 'Access denied: Attendance verification required';
      });
      return;
    }

    if (_tokenController.text.length < 8) {
      setState(() {
        _error = 'Please enter a valid access token';
      });
      return;
    }

    setState(() {
      _isValidating = true;
      _error = '';
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isValidating = false;
      });
      widget.onAccessGranted();
    });
  }

  void _handleQRScan() {
    // Simulate QR code scanning
    _tokenController.text = 'AIA-EVAL-2024-XK9P';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.shade50,
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
                    if (widget.isAttended)
                      _buildAccessForm()
                    else
                      _buildAccessDenied(),
                    const SizedBox(height: 24),
                    _buildSecurityNotice(),
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
            color: (widget.isAttended ? AppTheme.success : AppTheme.danger)
                .withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            widget.isAttended ? LucideIcons.lockOpen : LucideIcons.lock,
            color: widget.isAttended ? AppTheme.success : AppTheme.danger,
            size: 40,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Evaluation Access',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.isAttended
              ? 'Enter your access token to begin'
              : 'Attendance verification required',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildAccessForm() {
    return Column(
      children: [
        TextField(
          controller: _tokenController,
          decoration: InputDecoration(
            labelText: 'Access Token',
            hintText: 'Enter or scan your token',
            prefixIcon: const Icon(LucideIcons.key),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: _handleQRScan,
          icon: const Icon(LucideIcons.qrCode),
          label: const Text('Scan QR Code Instead'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        if (_error.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            _error,
            style: const TextStyle(color: AppTheme.danger),
          ),
        ],
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed:
              !widget.isAttended || _tokenController.text.length < 8 || _isValidating
                  ? null
                  : _handleTokenSubmit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: _isValidating
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : const Text('Access Evaluation'),
        ),
      ],
    );
  }

  Widget _buildAccessDenied() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.danger.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.danger.withOpacity(0.2)),
      ),
      child: const Row(
        children: [
          Icon(LucideIcons.circleAlert, color: AppTheme.danger),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'You must be present in class to access evaluations. Please complete the check-in process first.',
              style: TextStyle(color: AppTheme.danger),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityNotice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.info.withOpacity(0.2)),
      ),
      child: const Row(
        children: [
          Icon(LucideIcons.shield, color: AppTheme.info),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'This evaluation is secured with one-time access tokens. Screenshots and app switching are disabled during the assessment.',
              style: TextStyle(color: AppTheme.info),
            ),
          ),
        ],
      ),
    );
  }
}
