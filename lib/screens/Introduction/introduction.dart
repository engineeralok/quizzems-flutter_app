import 'package:flutter/material.dart';
import 'package:quizzems/configs/themes/app_colors.dart';
import 'package:quizzems/widgets/app_circle_button.dart';
import 'package:get/get.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: mainGradient()),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, size: 65
                  // color: Colors.amber,
                  ),
              const SizedBox(height: 40),
              const Text(
                'This is a quizz app. You can use it as you like. If you understand how it works, you would be able to scale it. With this I have mastered firebase backend and flutter front-end.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: onSurfaceTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              AppCircleButton(
                  onTap: () => Get.offAllNamed("/home"),
                  // () {
                  //   Get.offAllNamed("/home");
                  // },
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 35,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
