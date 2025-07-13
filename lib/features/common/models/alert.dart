class Alert {
  final int id;
  final String level;
  final String type;
  final String student;
  final String timestamp;
  final String location;
  final String description;
  final Map<String, dynamic> details;
  final String status;

  Alert({
    required this.id,
    required this.level,
    required this.type,
    required this.student,
    required this.timestamp,
    required this.location,
    required this.description,
    required this.details,
    required this.status,
  });
}
