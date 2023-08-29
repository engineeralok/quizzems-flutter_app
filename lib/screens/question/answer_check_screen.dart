import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzems/configs/themes/app_colors.dart';
import 'package:quizzems/configs/themes/custome_text_style.dart';
import 'package:quizzems/configs/themes/ui_parameters.dart';
import 'package:quizzems/controllers/questions_controller.dart';
import 'package:quizzems/screens/question/result_screen.dart';
import 'package:quizzems/widgets/common/background_decoration.dart';
import 'package:quizzems/widgets/common/custom_appbar.dart';
import 'package:quizzems/widgets/content_area.dart';
import 'package:quizzems/widgets/questions/answer_card.dart';

class AnswerCheckScreen extends GetView<QuestionsController> {
  const AnswerCheckScreen({super.key});

  static const String rounteName = "/answerCheckScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(
          () => Text(
            'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, "0")}',
            style: appBarTS,
          ),
        ),
        showActionIcon: true,
        onMenuActionTap: () {
          Get.toNamed(ResulteScreen.routeName);
        },
      ),
      body: BackgroundDecoration(
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: ContentArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          controller.currentQuestion.value!.question,
                        ),
                        GetBuilder<QuestionsController>(
                          id: 'answer_review_list',
                          builder: (_) {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (_, index) {
                                final answer = controller
                                    .currentQuestion.value!.answers![index];

                                final selectedAnswer = controller
                                    .currentQuestion.value!.selectedAnswer;
                                final correctAnswer = controller
                                    .currentQuestion.value!.correctAnswer;
                                final String answerText =
                                    '${answer.identifier}. ${answer.answer}';

                                if (correctAnswer == selectedAnswer &&
                                    answer.identifier == selectedAnswer) {
                                  //correct answer
                                  return CorrectAnswer(answer: answerText);
                                  // return Container();
                                } else if (selectedAnswer == null) {
                                  // not selected answer
                                  return NotAnswered(answer: answerText);
                                  // return Container();
                                } else if (correctAnswer != selectedAnswer &&
                                    answer.identifier == selectedAnswer) {
                                  //wrong answer
                                  return WrongAnswer(answer: answerText);
                                  // return Container();
                                } else if (correctAnswer == answer.identifier) {
                                  //correct answer
                                  return CorrectAnswer(answer: answerText);
                                  // return Container();
                                } else {
                                  return AnswerCard(
                                    answer: answerText,
                                    onTap: () {},
                                    isSelected: false,
                                  );
                                }
                              },
                              separatorBuilder: (_, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: controller
                                  .currentQuestion.value!.answers!.length,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CorrectAnswer extends StatelessWidget {
  final String answer;
  const CorrectAnswer({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: correctAnswerColor.withOpacity(0.1),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        answer,
        style: const TextStyle(
          color: correctAnswerColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class WrongAnswer extends StatelessWidget {
  final String answer;
  const WrongAnswer({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: wrongAnswerColor.withOpacity(0.1),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        answer,
        style: const TextStyle(
          color: wrongAnswerColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class NotAnswered extends StatelessWidget {
  final String answer;
  const NotAnswered({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: notAnsweredColor.withOpacity(0.1),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        answer,
        style: const TextStyle(
          color: notAnsweredColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
