import 'package:get/get.dart';

class AuthController extends GetxController {
  // Dono emails yahan set hain
  static const String adminEmail = 'admin@gmail.com';
  static const String userEmail = 'user@gmail.com';

  // Demo password (dono ke liye). Baad mein backend / Firebase se replace kar dena.
  static const String _demoPassword = '123456';

  final RxnString currentEmail = RxnString();

  bool get isLoggedIn => currentEmail.value != null;
  bool get isAdmin => currentEmail.value == adminEmail;

  /// Error message return karta hai, success par null.
  String? login(String email, String password) {
    final e = email.trim().toLowerCase();

    if (e.isEmpty || password.isEmpty) {
      return 'Email aur password dono likhein';
    }
    if (e != adminEmail && e != userEmail) {
      return 'Ye email registered nahi hai';
    }
    if (password != _demoPassword) {
      return 'Password ghalat hai';
    }

    currentEmail.value = e;
    return null;
  }

  void logout() {
    currentEmail.value = null;
  }
}
