import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import '../../core/services/auth_controller.dart';

/// Sirf logged-in user ke liye. Login nahi to /login par bhej deta hai.
class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final auth = Get.find<AuthController>();
    if (!auth.isLoggedIn) {
      return const RouteSettings(name: '/login');
    }
    return null;
  }
}

/// Sirf admin@gmail.com ke liye.
/// - Login nahi to /login
/// - Login hai magar admin nahi to /user-home
class AdminMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final auth = Get.find<AuthController>();
    if (!auth.isLoggedIn) {
      return const RouteSettings(name: '/login');
    }
    if (!auth.isAdmin) {
      return const RouteSettings(name: '/user-home');
    }
    return null;
  }
}
