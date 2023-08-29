import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzems/configs/themes/app_colors.dart';
import 'package:quizzems/configs/themes/custome_text_style.dart';
import 'package:quizzems/configs/themes/ui_parameters.dart';
import 'package:quizzems/controllers/questions_controller.dart';
import 'package:quizzems/widgets/common/background_decoration.dart';
import 'package:quizzems/widgets/common/custom_appbar.dart';
import 'package:quizzems/widgets/common/main_button.dart';
import 'package:quizzems/widgets/content_area.dart';
import 'package:quizzems/widgets/questions/answer_card.dart';
import 'package:quizzems/widgets/questions/countdown_time.dart';
import 'package:quizzems/widgets/questions/question_number_card.dart';

class TestOverviewScreen extends GetView<QuestionsController> {
  const TestOverviewScreen({super.key});

  static const String routeName = "/testoverview";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: controller.completedTest,
      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
              child: ContentArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CountDownTimer(
                          time: '',
                          color: UIParameters.isDarkMode()
                              ? Theme.of(context).textTheme.bodyMedium!.color
                              : Theme.of(context).primaryColor,
                        ),
                        Obx(
                          () => Text(
                            '${controller.time} Remaining',
                            style: countDownTimeTS(),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: GridView.builder(
                        itemCount: controller.allQuestions.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Get.width ~/ 75,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (_, index) {
                          AnswerStatus? _answerStatus;

                          if (controller.allQuestions[index].selectedAnswer !=
                              null) {
                            _answerStatus = AnswerStatus.answered;
                          }

                          return QuestionNumberCard(
                            index: index + 1,
                            status: _answerStatus,
                            onTap: () {
                              controller.jumpToQuestion(index);
                            },
                          );
                        },
                      ),
                    ),
                    ColoredBox(
                      color: customScaffoldColor(context),
                      child: Padding(
                        padding: UIParameters.mobileScreenPadding,
                        child: MainButton(
                          onTap: () {
                            controller.complete();
                          },
                          title: 'Complete',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
