import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../models/audit_entry.dart';
import '../utils/app_theme.dart';
import '../widgets/summary_stat_card.dart';

class AuditLogScreen extends StatefulWidget {
  const AuditLogScreen({Key? key}) : super(key: key);

  @override
  _AuditLogScreenState createState() => _AuditLogScreenState();
}

class _AuditLogScreenState extends State<AuditLogScreen> {
  String _filter = 'all';
  String _dateRange = 'week';

  final List<AuditEntry> _auditEntries = [
    AuditEntry(
        id: 1,
        timestamp: '2024-12-15 10:30:15',
        action: 'biometric_scan',
        status: 'success',
        location: 'CS-201',
        ip: '192.168.1.105',
        device: 'Mobile App',
        details: 'Fingerprint verification successful'),
    AuditEntry(
        id: 2,
        timestamp: '2024-12-15 10:30:45',
        action: 'location_check',
        status: 'success',
        location: 'CS-201',
        ip: '192.168.1.105',
        device: 'Mobile App',
        details: 'GPS coordinates verified within classroom boundary'),
    AuditEntry(
        id: 3,
        timestamp: '2024-12-15 10:31:12',
        action: 'wifi_connect',
        status: 'success',
        location: 'CS-201',
        ip: '192.168.1.105',
        device: 'Mobile App',
        details: 'Connected to EduNet-CS network'),
    AuditEntry(
        id: 4,
        timestamp: '2024-12-15 10:31:30',
        action: 'qr_generate',
        status: 'success',
        location: 'CS-201',
        ip: '192.168.1.105',
        device: 'Mobile App',
        details: 'QR code generated with 2-minute expiry'),
    AuditEntry(
        id: 5,
        timestamp: '2024-12-15 10:45:22',
        action: 'evaluation_access',
        status: 'success',
        location: 'CS-201',
        ip: '192.168.1.105',
        device: 'Mobile App',
        details: 'Token validated, access granted to Data Structures Quiz'),
    AuditEntry(
        id: 6,
        timestamp: '2024-12-15 11:15:45',
        action: 'quiz_submit',
        status: 'success',
        location: 'CS-201',
        ip: '192.168.1.105',
        device: 'Mobile App',
        details: 'Quiz submitted successfully, 10/10 questions answered'),
    AuditEntry(
        id: 7,
        timestamp: '2024-12-13 14:20:10',
        action: 'biometric_scan',
        status: 'failed',
        location: 'CS-202',
        ip: '192.168.1.089',
        device: 'Mobile App',
        details: 'Fingerprint scan failed - retry required'),
    AuditEntry(
        id: 8,
        timestamp: '2024-12-13 14:21:05',
        action: 'biometric_scan',
        status: 'success',
        location: 'CS-202',
        ip: '192.168.1.089',
        device: 'Mobile App',
        details: 'Face recognition successful on retry')
  ];

  @override
  Widget build(BuildContext context) {
    final filteredEntries = _auditEntries.where((entry) {
      if (_filter == 'all') return true;
      if (_filter == 'success') return entry.status == 'success';
      if (_filter == 'failed') return entry.status == 'failed';
      return entry.action == _filter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Audit Log'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Audit Log',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Complete transparency of your app activity',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildFilters(),
            const SizedBox(height: 16),
            _buildAuditTable(filteredEntries),
            const SizedBox(height: 24),
            _buildSummaryStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
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
          DropdownButton<String>(
            value: _filter,
            underline: const SizedBox(),
            onChanged: (String? newValue) {
              setState(() {
                _filter = newValue!;
              });
            },
            items: <String>[
              'all',
              'success',
              'failed',
              'biometric_scan',
              'location_check',
              'wifi_connect',
              'evaluation_access'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value.replaceAll('_', ' ').capitalize()),
              );
            }).toList(),
          ),
          DropdownButton<String>(
            value: _dateRange,
            underline: const SizedBox(),
            onChanged: (String? newValue) {
              setState(() {
                _dateRange = newValue!;
              });
            },
            items: <String>['week', 'month', 'semester', 'all']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text('Past ${value.capitalize()}'),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditTable(List<AuditEntry> entries) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Timestamp')),
            DataColumn(label: Text('Action')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Details')),
          ],
          rows: entries.map((entry) {
            return DataRow(cells: [
              DataCell(Text(entry.timestamp)),
              DataCell(Row(
                children: [
                  Icon(
                    _getActionIcon(entry.action),
                    size: 18,
                    color: _getActionColor(entry.action, entry.status),
                  ),
                  const SizedBox(width: 8),
                  Text(entry.action.replaceAll('_', ' ').capitalize()),
                ],
              )),
              DataCell(
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: entry.status == 'success'
                        ? AppTheme.success.withOpacity(0.1)
                        : AppTheme.danger.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    entry.status.capitalize(),
                    style: TextStyle(
                      color: entry.status == 'success'
                          ? AppTheme.success
                          : AppTheme.danger,
                    ),
                  ),
                ),
              ),
              DataCell(Text(entry.details)),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSummaryStats() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2,
      children: [
        SummaryStatCard(
          title: 'Biometric Scans',
          count: _auditEntries
              .where((e) => e.action == 'biometric_scan')
              .length
              .toString(),
          color: AppTheme.primary,
        ),
        SummaryStatCard(
          title: 'Evaluation Access',
          count: _auditEntries
              .where((e) => e.action == 'evaluation_access')
              .length
              .toString(),
          color: AppTheme.success,
        ),
        SummaryStatCard(
          title: 'Successful Actions',
          count:
              _auditEntries.where((e) => e.status == 'success').length.toString(),
          color: AppTheme.info,
        ),
        SummaryStatCard(
          title: 'Failed Attempts',
          count:
              _auditEntries.where((e) => e.status == 'failed').length.toString(),
          color: AppTheme.danger,
        ),
      ],
    );
  }

  IconData _getActionIcon(String action) {
    switch (action) {
      case 'biometric_scan':
        return LucideIcons.shield;
      case 'location_check':
        return LucideIcons.mapPin;
      case 'wifi_connect':
        return LucideIcons.wifi;
      case 'qr_generate':
      case 'evaluation_access':
      case 'quiz_submit':
        return LucideIcons.check;
      default:
        return LucideIcons.clock;
    }
  }

  Color _getActionColor(String action, String status) {
    if (status == 'failed') return AppTheme.danger;

    switch (action) {
      case 'biometric_scan':
        return AppTheme.primary;
      case 'location_check':
        return AppTheme.success;
      case 'wifi_connect':
        return AppTheme.info;
      default:
        return AppTheme.secondary;
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
