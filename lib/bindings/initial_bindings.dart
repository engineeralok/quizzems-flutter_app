import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:quizzems/controllers/auth_controller.dart';
import 'package:quizzems/controllers/theme_controller.dart';
import 'package:quizzems/firebase_options.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() async {
    Get.put(ThemeController());
    Get.put(AuthController(), permanent: true);
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
}
