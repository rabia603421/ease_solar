import 'package:get/get.dart';

import '../admins/admin_dashboard.dart';
import '../authentication/login.dart';
import '../authentication/register.dart';
import 'auth_middleware.dart';
import 'splash_screen.dart';
// TODO: partner ki customer screen ka import (lib/screens/customer/new.dart)
// import '../customer/new.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String adminDashboard = '/admin-dashboard';
  static const String userHome = '/user-home';

  static List<GetPage> pages = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    // Sirf admin
    GetPage(
      name: adminDashboard,
      page: () => const AdminDashboard(),
      middlewares: [AdminMiddleware()],
    ),
    // TODO: partner ki screen ka class name likh kar uncomment karein
    // GetPage(
    //   name: userHome,
    //   page: () => const YourCustomerScreen(),
    //   middlewares: [AuthMiddleware()],
    // ),
  ];
}
