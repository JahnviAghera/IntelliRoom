import 'package:flutter/material.dart';
import 'package:intelli_room/features/professor/course_models.dart';
import 'package:intelli_room/features/professor/course_service.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class LectureManagementScreen extends StatefulWidget {
  final Course course;

  const LectureManagementScreen({Key? key, required this.course})
      : super(key: key);

  @override
  _LectureManagementScreenState createState() =>
      _LectureManagementScreenState();
}

class _LectureManagementScreenState extends State<LectureManagementScreen> {
  final List<Lecture> _lectures = [];
  final CourseService _courseService = CourseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lectures for ${widget.course.name}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _lectures.length,
              itemBuilder: (context, index) {
                final lecture = _lectures[index];
                return ListTile(
                  title: Text('Lecture ${index + 1}'),
                  subtitle: Text(
                      '${DateFormat('hh:mm a').format(lecture.startTime)} - ${DateFormat('hh:mm a').format(lecture.endTime)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_courseService.lectureSessions[lecture.id] == true)
                        const Icon(Icons.circle, color: Colors.green),
                      IconButton(
                        icon: const Icon(Icons.play_arrow),
                        onPressed: () {
                          _courseService.startLectureSession(lecture.id);
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.stop),
                        onPressed: () {
                          _courseService.endLectureSession(lecture.id);
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.qr_code),
                        onPressed: () {
                          // Generate attendance QR code
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Attendance QR Code'),
                                content: SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: QrImageView(
                                    data: _courseService.generateAttendanceQrCode(lecture.id),
                                    version: QrVersions.auto,
                                    size: 200.0,
                                  ),
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
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: widget.course.studentIds.length,
              itemBuilder: (context, index) {
                final studentId = widget.course.studentIds[index];
                return ListTile(
                  title: Text('Student $studentId'),
                  trailing: IconButton(
                    icon: Icon(
                      _courseService.attendance[widget.course.id] != null &&
                              _courseService.attendance[widget.course.id]![studentId] ==
                                  true
                          ? Icons.check_circle
                          : Icons.check,
                      color: _courseService.attendance[widget.course.id] != null &&
                              _courseService.attendance[widget.course.id]![studentId] ==
                                  true
                          ? Colors.green
                          : null,
                    ),
                    onPressed: () {
                      _courseService.markAttendance(widget.course.id, studentId);
                      setState(() {});
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addLecture,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addLecture(BuildContext context) {
    final professorState = Provider.of<ProfessorState>(context, listen: false);
    DateTime? selectedDate;
    TimeOfDay? startTime;
    TimeOfDay? endTime;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Schedule Lecture'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                },
                child: const Text('Select Date'),
              ),
              ElevatedButton(
                onPressed: () async {
                  startTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                },
                child: const Text('Select Start Time'),
              ),
              ElevatedButton(
                onPressed: () async {
                  endTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                },
                child: const Text('Select End Time'),
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
                if (selectedDate != null &&
                    startTime != null &&
                    endTime != null) {
                  final startDateTime = DateTime(
                    selectedDate!.year,
                    selectedDate!.month,
                    selectedDate!.day,
                    startTime!.hour,
                    startTime!.minute,
                  );
                  final endDateTime = DateTime(
                    selectedDate!.year,
                    selectedDate!.month,
                    selectedDate!.day,
                    endTime!.hour,
                    endTime!.minute,
                  );
                  professorState.scheduleLecture(
                      widget.course.id, startDateTime, endDateTime);
                  Navigator.pop(context);
                }
              },
              child: const Text('Schedule'),
            ),
          ],
        );
      },
    );
  }
}
