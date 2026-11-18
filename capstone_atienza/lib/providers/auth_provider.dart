import 'package:flutter/foundation.dart';

enum UserRole { student, admin }

/// No real auth: type any student ID to enter as a student,
/// or type "admin" to unlock the post form.
class AuthProvider extends ChangeNotifier {
  String? _userId;
  UserRole _role = UserRole.student;

  String? get userId => _userId;
  UserRole get role => _role;
  bool get isLoggedIn => _userId != null;
  bool get isAdmin => _role == UserRole.admin;

  bool login(String input) {
    final id = input.trim();
    if (id.isEmpty) return false;
    _userId = id;
    _role = id.toLowerCase() == 'admin' ? UserRole.admin : UserRole.student;
    notifyListeners();
    return true;
  }

  void logout() {
    _userId = null;
    _role = UserRole.student;
    notifyListeners();
  }
}
