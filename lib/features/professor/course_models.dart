class Course {
  final String id;
  final String name;
  final String description;
  final String enrollmentCode;
  final List<String> studentIds;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.enrollmentCode,
    this.studentIds = const [],
  });
}

class Lecture {
  final String id;
  final String courseId;
  final DateTime startTime;
  final DateTime endTime;

  Lecture({
    required this.id,
    required this.courseId,
    required this.startTime,
    required this.endTime,
  });

  bool get isInSession =>
      DateTime.now().isAfter(startTime) && DateTime.now().isBefore(endTime);
}
