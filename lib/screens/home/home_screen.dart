import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:quizzems/configs/themes/app_colors.dart';
import 'package:quizzems/configs/themes/custome_text_style.dart';
import 'package:quizzems/configs/themes/ui_parameters.dart';
import 'package:quizzems/controllers/question_paper/question_paper_controller.dart';
import 'package:quizzems/controllers/zoom_drawer_controller.dart';
import 'package:quizzems/screens/home/menu_screen.dart';
import 'package:quizzems/screens/home/question_card.dart';
import 'package:quizzems/services/firebase_storage_service.dart';
import 'package:quizzems/widgets/app_circle_button.dart';
import 'package:quizzems/widgets/app_icons.dart';
import 'package:quizzems/widgets/content_area.dart';

class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({super.key});

  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FirebaseStorageService());
    QuestionPaperController questionPaperController = Get.find();
    return Scaffold(body: GetBuilder<MyZoomDrawerController>(builder: (_) {
      return Container(
        decoration: BoxDecoration(
          gradient: mainGradient(),
        ),
        child: ZoomDrawer(
          borderRadius: 50.0,
          controller: _.zoomDrawerController,
          showShadow: true,
          angle: 0.0,
          style: DrawerStyle.defaultStyle,
          menuScreenWidth: MediaQuery.of(context).size.width,

          // menuBackgroundColor: Color.fromARGB(255, 25, 168, 176),
          // menuBackgroundColor: Colors.transparent,
          slideWidth: MediaQuery.of(context).size.width * 0.75,
          menuScreen: const MyMenuScreen(),
          mainScreen: Container(
            decoration: BoxDecoration(gradient: mainGradient()),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(mobileScreenPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: controller.toogleDrawer,
                          child: const Icon(AppIcons.menuLeft),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              const Icon(AppIcons.peace),
                              Text(
                                "Hello friend!",
                                style: detailText.copyWith(
                                  color: onSurfaceTextColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Text(
                          "What do you think about this app?",
                          style: headerText,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ContentArea(
                        addPadding: false,
                        child: Obx(() => ListView.separated(
                            padding: UIParameters.mobileScreenPadding,
                            itemBuilder: (context, index) {
                              return QuestionCard(
                                model: questionPaperController.allPapers[index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 20);
                            },
                            itemCount:
                                questionPaperController.allPapers.length)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }));
  }
}
