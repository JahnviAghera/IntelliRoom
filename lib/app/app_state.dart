import 'package:flutter/material.dart';
import 'package:intelli_room/features/professor/course_models.dart';
import 'package:intelli_room/features/professor/course_service.dart';
import 'package:intelli_room/features/professor/lecture_service.dart';

class StudentState with ChangeNotifier {
  // Add student-specific properties and methods here
}

class ProfessorState with ChangeNotifier {
  final CourseService _courseService = CourseService();
  final LectureService _lectureService = LectureService();

  List<Course> _courses = [];
  List<Course> get courses => _courses;

  Map<String, List<Lecture>> _lectures = {};
  Map<String, List<Lecture>> get lectures => _lectures;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ProfessorState() {
    fetchCourses();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> fetchCourses() async {
    _setLoading(true);
    _courses = await _courseService.getCourses();
    _setLoading(false);
  }

  Future<void> createCourse(String name, String description) async {
    _setLoading(true);
    await _courseService.createCourse(name, description);
    await fetchCourses();
  }

  Future<void> updateCourse(Course course) async {
    _setLoading(true);
    await _courseService.updateCourse(course);
    await fetchCourses();
  }

  Future<void> deleteCourse(String courseId) async {
    _setLoading(true);
    await _courseService.deleteCourse(courseId);
    await fetchCourses();
  }

  Future<void> fetchLectures(String courseId) async {
    _setLoading(true);
    _lectures[courseId] = await _lectureService.getLecturesForCourse(courseId);
    _setLoading(false);
  }

  Future<void> scheduleLecture(
      String courseId, DateTime startTime, DateTime endTime) async {
    _setLoading(true);
    await _lectureService.scheduleLecture(courseId, startTime, endTime);
    await fetchLectures(courseId);
  }
}
