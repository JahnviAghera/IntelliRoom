<img src="https://github.com/JahnviAghera/IntelliRoom/blob/faea6f6a814a829e4faac63120ead375d0d9d890/images_protoype/e54ae5c4-f749-46d0-8bfc-235295b86f56%201.png?raw=true" alt="Rounded IntelliRoom Logo" style="border-radius: 20px; width: 100px; height: 100px;" />

# IntelliRoom
A secure, cross-platform Flutter application for managing lecture attendance, access control, and evaluation workflows in educational environments.

## Description
IntelliRoom is a role-based mobile and desktop application developed using Flutter, designed to streamline classroom management for both professors and students. The application ensures secure attendance tracking, in-class assessment access control, and performance logging through modern technologies such as biometric authentication, QR code validation, and session-specific evaluation gating.

The app supports Android, iOS, macOS, Linux, and Windows platforms.

---

| ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20165933.png?raw=true) | ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20170100.png?raw=true) | ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20170130.png?raw=true) |
|---|---|---|
| ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20170205.png?raw=true) | ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20170240.png?raw=true) | ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20170305.png?raw=true) |
| ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20170901.png?raw=true) | ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20170914.png?raw=true) | ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20170947.png?raw=true) |
| ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20171005.png?raw=true) | ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20171019.png?raw=true) | ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20171054.png?raw=true) |
| ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20171106.png?raw=true) | ![](https://github.com/JahnviAghera/IntelliRoom/blob/db5c972f1964df1d0189032f36b1f72382e747f8/images_protoype/Screenshot%202025-07-13%20171130.png?raw=true) |  |

---

## Key Features

- **Cross-Platform Compatibility**  
  Runs on Android, iOS, macOS, Windows, and Linux using Flutter.

- **Authentication & Role-Based Access**  
  Secure login system and user flow based on Professor or Student roles.

- **Biometric Check-In**  
  Verifies student presence with biometric authentication during lecture entry.

- **QR Code Generation & Scan**  
  Professors generate QR codes to confirm physical attendance.

- **Admin Alerts**  
  Professors can issue announcements or alerts to all enrolled students.

- **Audit Logs**  
  Tracks all major system activities for accountability and traceability.

- **Controlled Evaluation Access**  
  Students can access lecture-specific evaluations only once after attending.

- **Secure Quiz Mode**  
  Prevents reattempts, screenshots, and unauthorized access during assessments.

- **Professor Dashboard**  
  Course creation, lecture scheduling, student lists, and analytics view.

- **Student Dashboard**  
  View lectures, attendance records, evaluation status, and announcements.

---

## Project Structure

- `.env` – Stores sensitive environment variables  
- `lib/` – All Dart source code  
  - `app/` – Core app state and logic  
  - `features/` – Divided into `auth/`, `common/`, `professor/`, and `student/`  
- `android/`, `ios/`, `linux/`, `macos/`, `windows/` – Platform-specific configuration  
- `test/` – Widget and unit tests  
- `web/` – Web support files  
- `main.dart` – App entry point

---

## Dependencies (from `pubspec.yaml`)

- `cupertino_icons` – iOS-style icons  
- `firebase_auth` – Authentication module  
- `cloud_firestore` – NoSQL database  
- `local_auth` – Biometric support  
- `qr_flutter` – QR code rendering  
- `geolocator` – GPS-based presence  
- `flutter_secure_storage` – Token security  
- `provider` or `riverpod` – State management

---

## Summary

**IntelliRoom** offers a scalable, extensible architecture for managing modern classrooms. With support for both mobile and desktop platforms, it simplifies lecture logistics, enforces academic integrity, and ensures data privacy for both professors and students.

