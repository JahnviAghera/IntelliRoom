enum UserRole { student, professor }

class User {
  final String uid;
  final String email;
  final UserRole role;

  User({required this.uid, required this.email, required this.role});
}

class AuthService {
  // In a real app, this would interact with Firebase Auth and Firestore
  Future<User?> signIn(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (email == 'student@demo.com') {
      return User(uid: '123', email: email, role: UserRole.student);
    } else if (email == 'professor@demo.com') {
      return User(uid: '456', email: email, role: UserRole.professor);
    }
    return null;
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
