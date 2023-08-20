import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:quizzems/controllers/question_paper/question_paper_controller.dart';
import 'package:quizzems/controllers/zoom_drawer_controller.dart';
import 'package:quizzems/models/question_paper_model.dart';
import 'package:quizzems/screens/Introduction/introduction.dart';
import 'package:quizzems/screens/home/home_screen.dart';
import 'package:quizzems/screens/login/login_screen.dart';
import 'package:quizzems/services/firebase_storage_service.dart';
import '../screens/splash/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => const SpalashScreen()),
        GetPage(
            name: "/introduction", page: () => const AppIntroductionScreen()),
        GetPage(
          name: "/home",
          page: () => const HomeScreen(),
          binding: BindingsBuilder(() {
            Get.put(QuestionPaperController());
            Get.put(FirebaseStorageService());
            Get.put(MyZoomDrawerController());
          }),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
        )
      ];
}
