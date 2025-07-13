import 'package:flutter/material.dart';
import 'package:intelli_room/app/app_state.dart';
import 'package:intelli_room/features/professor/course_models.dart';
import 'package:intelli_room/features/professor/lecture_management_screen.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CourseManagementScreen extends StatelessWidget {
  const CourseManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final professorState = Provider.of<ProfessorState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Management'),
      ),
      body: professorState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : professorState.courses.isEmpty
              ? const Center(child: Text('No courses found.'))
              : ListView.builder(
                  itemCount: professorState.courses.length,
                  itemBuilder: (context, index) {
                    final course = professorState.courses[index];
                    return ListTile(
                      title: Text(course.name),
                      subtitle: Text(course.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () =>
                                _navigateToLectureManagement(context, course),
                          ),
                          IconButton(
                            icon: const Icon(Icons.qr_code),
                            onPressed: () => _showEnrollmentQrCode(context, course),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _editCourse(context, course),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteCourse(context, course.id),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addCourse(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addCourse(BuildContext context) {
    final professorState = Provider.of<ProfessorState>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        final nameController = TextEditingController();
        final descriptionController = TextEditingController();
        return AlertDialog(
          title: const Text('Add Course'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Course Name'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                professorState.createCourse(
                  nameController.text,
                  descriptionController.text,
                );
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editCourse(BuildContext context, Course course) {
    final professorState = Provider.of<ProfessorState>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        final nameController = TextEditingController(text: course.name);
        final descriptionController =
            TextEditingController(text: course.description);
        return AlertDialog(
          title: const Text('Edit Course'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Course Name'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedCourse = Course(
                  id: course.id,
                  name: nameController.text,
                  description: descriptionController.text,
                  enrollmentCode: course.enrollmentCode,
                  studentIds: course.studentIds,
                );
                professorState.updateCourse(updatedCourse);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteCourse(BuildContext context, String courseId) {
    final professorState = Provider.of<ProfessorState>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Course'),
          content: const Text('Are you sure you want to delete this course?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                professorState.deleteCourse(courseId);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showEnrollmentQrCode(BuildContext context, Course course) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enrollment Code'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Scan the QR code or enter the code below to enroll:'),
              const SizedBox(height: 16),
              SizedBox(
                width: 200,
                height: 200,
                child: QrImageView(
                  data: course.enrollmentCode,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                course.enrollmentCode,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToLectureManagement(BuildContext context, Course course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LectureManagementScreen(course: course),
      ),
    );
  }
}

