# IntelliRoom

A Flutter project for managing room access and attendance.

## Description

This project is a cross-platform application built with Flutter, designed to run on Android, iOS, macOS, Linux and Windows. It appears to be focused on managing room access, attendance tracking, and potentially other administrative tasks, possibly within an educational or organizational setting.

## Key Features

*   **Cross-Platform:** Built with Flutter, ensuring compatibility across multiple operating systems.
*   **Authentication:** Includes login functionality (`lib/features/auth/login_screen.dart`, `lib/features/auth/auth_service.dart`).
*   **Biometric Check-in:** Supports biometric authentication for check-in (`lib/features/common/screens/biometric_checkin_screen.dart`).
*   **QR Code Generation:** Can generate QR codes, likely for room access or attendance tracking (`lib/features/common/screens/qr_generation_screen.dart`).
*   **Admin Alerts:** Includes functionality for managing alerts, likely for administrative purposes (`lib/features/common/screens/admin_alerts_screen.dart`).
*   **Audit Logging:** Tracks audit entries, providing a log of activities within the application (`lib/features/common/screens/audit_log_screen.dart`).
*   **Evaluation Access:** Manages access to evaluations or assessments (`lib/features/common/screens/evaluation_access_screen.dart`).
*   **Secure Quiz Mode:** Offers a secure mode for quizzes or assessments (`lib/features/common/screens/secure_quiz_mode_screen.dart`).
*   **Professor and Student Dashboards:** Separate dashboards for professors and students, suggesting role-based access and functionality (`lib/features/professor/professor_dashboard.dart`, `lib/features/student/student_dashboard.dart`).
*   **Course and Lecture Management:** Professors can manage courses and lectures (`lib/features/professor/course_management_screen.dart`, `lib/features/professor/lecture_management_screen.dart`).

## Getting Started

To run this project, you need to have Flutter installed on your machine.

### Prerequisites

*   Flutter SDK

### Installation

1.  Clone the repository:

    ```bash
    git clone [repository_url]
    ```
2.  Navigate to the project directory:

    ```bash
    cd IntelliRoom
    ```
3.  Install dependencies:

    ```bash
    flutter pub get
    ```

### Running the app

```bash
flutter run
```

## Project Structure

*   `.env`: Contains environment variables.
*   `android/`: Contains the Android-specific code.
*   `ios/`: Contains the iOS-specific code.
*   `macos/`: Contains the macOS-specific code.
*   `linux/`: Contains the Linux-specific code.
*   `windows/`: Contains the Windows-specific code.
*   `lib/`: Contains the Dart code for the Flutter app.
    *   `main.dart`: The entry point of the Flutter application.
    *   `app/`: Contains core application state management files.
    *   `features/`: Contains the different features of the application, such as authentication, common components, professor-specific functionality, and student-specific functionality.
*   `test/`: Contains widget tests.
*   `web/`: Contains the web-specific code.

## Dependencies

The project uses the following dependencies (as listed in `pubspec.yaml`):

*   cupertino\_icons: For providing iOS-style icons.

## More Information

For more detailed information about specific features or functionalities, refer to the code within the respective directories.
