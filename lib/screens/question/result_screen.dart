import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quizzems/configs/themes/app_colors.dart';
import 'package:quizzems/configs/themes/custome_text_style.dart';
import 'package:quizzems/configs/themes/ui_parameters.dart';
import 'package:quizzems/controllers/question_paper/questions_controller_extension.dart';
import 'package:quizzems/controllers/questions_controller.dart';
import 'package:quizzems/models/question_paper_model.dart';
import 'package:quizzems/screens/question/answer_check_screen.dart';
import 'package:quizzems/screens/question/questions_screen.dart';
import 'package:quizzems/widgets/common/background_decoration.dart';
import 'package:quizzems/widgets/common/custom_appbar.dart';
import 'package:quizzems/widgets/common/main_button.dart';
import 'package:quizzems/widgets/content_area.dart';
import 'package:quizzems/widgets/questions/answer_card.dart';
import 'package:quizzems/widgets/questions/question_number_card.dart';

class ResulteScreen extends GetView<QuestionsController> {
  const ResulteScreen({super.key});

  static const String routeName = "/resultScreen";

  @override
  Widget build(BuildContext context) {
    Color textColor =
        Get.isDarkMode ? onSurfaceTextColor : Theme.of(context).primaryColor;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: controller.correctAnsweredQuestions,
      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
              child: ContentArea(
                child: Column(
                  children: [
                    SvgPicture.asset('assets/images/bulb.svg'),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Text(
                        'Congratulations!',
                        style: headerText.copyWith(color: textColor),
                      ),
                    ),
                    Text(
                      'You have ${controller.points} points!',
                      style: TextStyle(color: textColor),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Tap below question numbers to view correct answers',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Expanded(
                      child: GridView.builder(
                        itemCount: controller.allQuestions.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Get.width ~/ 75,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (_, index) {
                          final question = controller.allQuestions[index];
                          AnswerStatus status = AnswerStatus.notAnswered;
                          final selectedAnswer = question.selectedAnswer;
                          final correctAnswer = question.correctAnswer;
                          if (selectedAnswer == correctAnswer) {
                            status = AnswerStatus.correct;
                          } else if (question.selectedAnswer == null) {
                            status = AnswerStatus.worng;
                          } else {
                            status = AnswerStatus.worng;
                          }

                          return QuestionNumberCard(
                            index: index + 1,
                            status: status,
                            onTap: () {
                              controller.jumpToQuestion(
                                index,
                                isGoBack: false,
                              );
                              Get.toNamed(AnswerCheckScreen.rounteName);
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            ColoredBox(
              color: customScaffoldColor(context),
              child: Padding(
                padding: UIParameters.mobileScreenPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: MainButton(
                        onTap: () {
                          controller.tryAgain();
                        },
                        color: Colors.blueGrey,
                        title: 'Try Again',
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: MainButton(
                        onTap: () {
                          controller.saveTestRestult();
                        },
                        color: onSurfaceTextColor,
                        title: 'Go Home',
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
