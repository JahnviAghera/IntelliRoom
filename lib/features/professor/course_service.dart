import 'dart:math';
import 'package:intelli_room/features/professor/course_models.dart';

class CourseService {
  final List<Course> _courses = [];
  final Map<String, bool> _lectureSessions = {};
  final Map<String, Map<String, bool>> _attendance = {};

  Map<String, bool> get lectureSessions => _lectureSessions;
  Map<String, Map<String, bool>> get attendance => _attendance;

  Future<List<Course>> getCourses() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _courses;
  }

  Future<Course> createCourse(String name, String description) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final newCourse = Course(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
      enrollmentCode: _generateEnrollmentCode(),
    );
    _courses.add(newCourse);
    return newCourse;
  }

  Future<void> deleteCourse(String courseId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _courses.removeWhere((course) => course.id == courseId);
  }

  Future<Course> updateCourse(Course course) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _courses.indexWhere((c) => c.id == course.id);
    if (index != -1) {
      _courses[index] = course;
    }
    return course;
  }

  Future<void> addStudentToCourse(String courseId, String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _courses.indexWhere((c) => c.id == courseId);
    if (index != -1) {
      if (!_courses[index].studentIds.contains(studentId)) {
        _courses[index].studentIds.add(studentId);
      }
    }
  }

  String _generateEnrollmentCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        6,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  String generateEnrollmentLink(String enrollmentCode) {
    return 'https://intelliroom.example.com/enroll?code=$enrollmentCode';
  }

  Future<void> startLectureSession(String lectureId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _lectureSessions[lectureId] = true;
  }

  Future<void> endLectureSession(String lectureId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _lectureSessions[lectureId] = false;
  }

  String generateAttendanceQrCode(String lectureId) {
    // TODO: Implement generate attendance QR code logic
    return 'https://intelliroom.example.com/attendance?lectureId=$lectureId';
  }

  Future<void> markAttendance(String lectureId, String studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!_attendance.containsKey(lectureId)) {
      _attendance[lectureId] = {};
    }
    _attendance[lectureId]![studentId] = true;
  }
}
