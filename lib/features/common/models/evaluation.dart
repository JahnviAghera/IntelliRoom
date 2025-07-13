class Evaluation {
  final String subject;
  final int? score;
  final String date;
  final String status;

  Evaluation({
    required this.subject,
    this.score,
    required this.date,
    required this.status,
  });
}
