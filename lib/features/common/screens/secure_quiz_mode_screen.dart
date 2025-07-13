import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../utils/app_theme.dart';

class SecureQuizModeScreen extends StatefulWidget {
  final VoidCallback onQuizComplete;

  const SecureQuizModeScreen({Key? key, required this.onQuizComplete})
      : super(key: key);

  @override
  _SecureQuizModeScreenState createState() => _SecureQuizModeScreenState();
}

class _SecureQuizModeScreenState extends State<SecureQuizModeScreen> {
  late Timer _timer;
  int _timeLeft = 1800; // 30 minutes
  int _currentQuestion = 1;
  final int _totalQuestions = 10;
  final Map<int, String> _answers = {};
  int _securityWarnings = 0;

  final List<Map<String, dynamic>> _questions = [
    {
      'id': 1,
      'question': 'What is the time complexity of binary search?',
      'options': ['O(n)', 'O(log n)', 'O(n²)', 'O(1)'],
    },
    {
      'id': 2,
      'question': 'Which data structure uses LIFO principle?',
      'options': ['Queue', 'Stack', 'Array', 'Linked List'],
    },
    // Add more questions
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer.cancel();
        widget.onQuizComplete();
      }
    });
  }

  String _formatTime(int seconds) {
    final mins = (seconds / 60).floor();
    final secs = seconds % 60;
    return '$mins:${secs.toString().padLeft(2, '0')}';
  }

  void _handleAnswerChange(int questionId, String answer) {
    setState(() {
      _answers[questionId] = answer;
    });
  }

  void _nextQuestion() {
    if (_currentQuestion < _totalQuestions) {
      setState(() {
        _currentQuestion++;
      });
    }
  }

  void _prevQuestion() {
    if (_currentQuestion > 1) {
      setState(() {
        _currentQuestion--;
      });
    }
  }

  void _submitQuiz() {
    widget.onQuizComplete();
  }

  @override
  Widget build(BuildContext context) {
    final currentQ = _questions.firstWhere(
      (q) => q['id'] == _currentQuestion,
      orElse: () => _questions.first,
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Column(
          children: [
            _buildSecurityHeader(),
            _buildTimerAndProgress(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildQuestionCard(currentQ),
                    const SizedBox(height: 16),
                    _buildNavigation(),
                  ],
                ),
              ),
            ),
            _buildSecurityFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.red.shade900,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(LucideIcons.shield, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text(
                'SECURE MODE ACTIVE',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          if (_securityWarnings > 0)
            Row(
              children: [
                const Icon(LucideIcons.badgeAlert,
                    color: Colors.yellow, size: 18),
                const SizedBox(width: 8),
                Text(
                  '$_securityWarnings Warning(s)',
                  style: const TextStyle(color: Colors.yellow),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildTimerAndProgress() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade800,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(LucideIcons.clock, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    _formatTime(_timeLeft),
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                'Question $_currentQuestion of $_totalQuestions',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _currentQuestion / _totalQuestions,
            backgroundColor: Colors.grey.shade700,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(Map<String, dynamic> question) {
    return Card(
      color: Colors.grey.shade800,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question['question'],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...List<Widget>.from(
              (question['options'] as List<String>).map(
                (option) => RadioListTile<String>(
                  title: Text(option, style: const TextStyle(color: Colors.white)),
                  value: option,
                  groupValue: _answers[_currentQuestion],
                  onChanged: (value) {
                    if (value != null) {
                      _handleAnswerChange(_currentQuestion, value);
                    }
                  },
                  activeColor: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: _currentQuestion > 1 ? _prevQuestion : null,
          child: const Text('Previous'),
        ),
        if (_currentQuestion == _totalQuestions)
          ElevatedButton(
            onPressed: _submitQuiz,
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.success),
            child: const Text('Submit Quiz'),
          )
        else
          ElevatedButton(
            onPressed: _nextQuestion,
            child: const Text('Next'),
          ),
      ],
    );
  }

  Widget _buildSecurityFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey.shade800,
      child: const Text(
        '⚠️ Screenshots disabled • App switching blocked • Session monitored',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }
}
