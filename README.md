<img src="https://github.com/JahnviAghera/IntelliRoom/blob/faea6f6a814a829e4faac63120ead375d0d9d890/images_protoype/e54ae5c4-f749-46d0-8bfc-235295b86f56%201.png?raw=true" alt="Rounded Image" style="border-radius: 20px; width: 100px; height: 100px;" />

# IntelliRoom
A Flutter project for managing room access and attendance.

Description
This project is a cross-platform application built with Flutter, designed to run on Android, iOS, macOS, Linux and Windows. It is focused on managing room access, attendance tracking, and potentially other administrative tasks within an educational or organizational setting.
| ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20165933.png?raw=true) | ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20170100.png?raw=true) | ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20170130.png?raw=true) |
|---|---|---|
| ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20170205.png?raw=true) | ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20170240.png?raw=true) | ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20170305.png?raw=true) |
| ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20170901.png?raw=true) | ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20170914.png?raw=true) | ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20170947.png?raw=true) |
| ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20171005.png?raw=true) | ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20171019.png?raw=true) | ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20171054.png?raw=true) |
| ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20171106.png?raw=true) | ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20171130.png?raw=true) |  |

Key Features
* Cross-Platform: Built with Flutter, ensuring compatibility across multiple operating systems.
* Authentication: Includes login functionality (lib/features/auth/login_screen.dart, lib/features/auth/auth_service.dart).
* Biometric Check-in: Supports biometric authentication for check-in (lib/features/common/screens/biometric_checkin_screen.dart).
* QR Code Generation: Can generate QR codes, likely for room access or attendance tracking (lib/features/common/screens/qr_generation_screen.dart).
* Admin Alerts: Includes functionality for managing alerts, likely for administrative purposes (lib/features/common/screens/admin_alerts_screen.dart).
* Audit Logging: Tracks audit entries, providing a log of activities within the application (lib/features/common/screens/audit_log_screen.dart).
* Evaluation Access: Manages access to evaluations or assessments (lib/features/common/screens/evaluation_access_screen.dart).
* Secure Quiz Mode: Offers a secure mode for quizzes or assessments (lib/features/common/screens/secure_quiz_mode_screen.dart).
* Professor and Student Dashboards: Separate dashboards for professors and students, suggesting role-based access and functionality (lib/features/professor/professor_dashboard.dart, lib/features/student/student_dashboard.dart).
* Course and Lecture Management: Professors can manage courses and lectures (lib/features/professor/course_management_screen.dart, lib/features/professor/lecture_management_screen.dart).

Project Structure
* .env: Contains environment variables.
* android/: Contains the Android-specific code.
* ios/: Contains the iOS-specific code.
* macos/: Contains the macOS-specific code.
* linux/: Contains the Linux-specific code.
* windows/: Contains the Windows-specific code.
* lib/: Contains the Dart code for the Flutter app.
* main.dart: The entry point of the Flutter application.
* app/: Contains core application state management files.
* features/: Contains the different features of the application, such as authentication, common components, professor-specific functionality, and student-specific functionality.
* test/: Contains widget tests.
* web/: Contains the web-specific code.

Dependencies
The project uses the following dependencies (as listed in pubspec.yaml):
* cupertino_icons: For providing iOS-style icons.

This project provides a comprehensive solution for managing room access and attendance, with features tailored for both professors and students. It leverages Flutter's cross-platform capabilities to ensure accessibility across various devices and operating systems. The application incorporates modern security measures such as biometric authentication and secure quiz modes to maintain data integrity and user privacy.
