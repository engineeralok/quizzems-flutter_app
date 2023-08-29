import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzems/bindings/initial_bindings.dart';
import 'package:quizzems/controllers/theme_controller.dart';
import 'package:quizzems/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Get.find<ThemeController>().lightTheme,
      getPages: AppRoutes.routes(),
    );
  }
}
