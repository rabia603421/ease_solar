import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';

import 'core/services/auth_controller.dart';
import 'screens/routes/app_routes.dart';

void main() {
  // Middleware se pehle controller register hona zaroori hai
  Get.put(AuthController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SolarEase',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.pages,
    );
  }
}
