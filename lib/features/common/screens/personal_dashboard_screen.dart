import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../models/attendance.dart';
import '../models/evaluation.dart';
import '../utils/app_theme.dart';
import '../widgets/summary_stat_card.dart';

class PersonalDashboardScreen extends StatelessWidget {
  final VoidCallback onViewAuditLog;

  const PersonalDashboardScreen({Key? key, required this.onViewAuditLog})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Attendance> attendanceData = [
      Attendance(month: 'Sep', attended: 18, total: 20),
      Attendance(month: 'Oct', attended: 22, total: 23),
      Attendance(month: 'Nov', attended: 19, total: 21),
      Attendance(month: 'Dec', attended: 15, total: 16),
    ];

    final List<Evaluation> recentEvaluations = [
      Evaluation(
          subject: 'Data Structures',
          score: 85,
          date: '2024-12-15',
          status: 'completed'),
      Evaluation(
          subject: 'Algorithms',
          score: 92,
          date: '2024-12-13',
          status: 'completed'),
      Evaluation(
          subject: 'Database Systems',
          score: 78,
          date: '2024-12-10',
          status: 'completed'),
      Evaluation(
          subject: 'Web Development',
          score: null,
          date: '2024-12-18',
          status: 'missed'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Analytics'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Personal Analytics',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Track your attendance and evaluation performance',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildStatsGrid(),
            const SizedBox(height: 24),
            _buildAttendanceOverview(attendanceData),
            const SizedBox(height: 24),
            _buildRecentEvaluations(recentEvaluations),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onViewAuditLog,
              child: const Text('View Audit Log'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2,
      children: const [
        SummaryStatCard(
            title: 'Attendance Rate', count: '89%', color: AppTheme.success),
        SummaryStatCard(
            title: 'Avg. Score', count: '85.2', color: AppTheme.primary),
        SummaryStatCard(
            title: 'Evaluations', count: '12', color: AppTheme.info),
        SummaryStatCard(
            title: 'Trend', count: '+5.2%', color: AppTheme.warning),
      ],
    );
  }

  Widget _buildAttendanceOverview(List<Attendance> data) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Attendance Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...data.map((d) => _buildAttendanceRow(d)),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceRow(Attendance data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(data.month),
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: data.attended / data.total,
              backgroundColor: Colors.grey.shade300,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppTheme.success),
            ),
          ),
          const SizedBox(width: 16),
          Text('${data.attended}/${data.total}'),
        ],
      ),
    );
  }

  Widget _buildRecentEvaluations(List<Evaluation> evaluations) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Evaluations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...evaluations.map((e) => _buildEvaluationTile(e)),
          ],
        ),
      ),
    );
  }

  Widget _buildEvaluationTile(Evaluation evaluation) {
    return ListTile(
      leading: Icon(
        evaluation.status == 'completed'
            ? LucideIcons.check
            : LucideIcons.x,
        color: evaluation.status == 'completed'
            ? AppTheme.success
            : AppTheme.danger,
      ),
      title: Text(evaluation.subject),
      subtitle: Text(evaluation.date),
      trailing: evaluation.score != null
          ? Text(
              '${evaluation.score}%',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.success,
              ),
            )
          : const Text(
              'Missed',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.danger,
              ),
            ),
    );
  }
}
