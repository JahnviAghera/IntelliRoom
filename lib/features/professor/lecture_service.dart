import 'package:intelli_room/features/professor/course_models.dart';

class LectureService {
  final Map<String, List<Lecture>> _lectures = {};

  Future<List<Lecture>> getLecturesForCourse(String courseId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _lectures[courseId] ?? [];
  }

  Future<Lecture> scheduleLecture(
      String courseId, DateTime startTime, DateTime endTime) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final newLecture = Lecture(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      courseId: courseId,
      startTime: startTime,
      endTime: endTime,
    );

    if (_lectures.containsKey(courseId)) {
      _lectures[courseId]!.add(newLecture);
    } else {
      _lectures[courseId] = [newLecture];
    }
    return newLecture;
  }
}
