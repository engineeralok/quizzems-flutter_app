import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzems/configs/themes/app_colors.dart';
import 'package:quizzems/configs/themes/custome_text_style.dart';
import 'package:quizzems/configs/themes/ui_parameters.dart';
import 'package:quizzems/controllers/questions_controller.dart';
import 'package:quizzems/firebase_ref/loading_status.dart';
import 'package:quizzems/screens/question/test_overview_screen.dart';
import 'package:quizzems/widgets/common/background_decoration.dart';
import 'package:quizzems/widgets/common/custom_appbar.dart';
import 'package:quizzems/widgets/common/main_button.dart';
import 'package:quizzems/widgets/common/question_place_holder.dart';
import 'package:quizzems/widgets/content_area.dart';
import 'package:quizzems/widgets/questions/answer_card.dart';
import 'package:quizzems/widgets/questions/countdown_time.dart';

class QuestionScreen extends GetView<QuestionsController> {
  const QuestionScreen({super.key});

  static const String routeName = "/questionsScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: const ShapeDecoration(
            shape: StadiumBorder(
              side: BorderSide(
                color: onSurfaceTextColor,
                width: 2,
              ),
            ),
          ),
          child: Obx(() => CountDownTimer(
                time: controller.time.value,
                color: onSurfaceTextColor,
              )),
        ),
        showActionIcon: true,
        titleWidget: Obx(
          () => Text(
            "Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, "0")}",
            style: appBarTS,
          ),
        ),
      ),
      body: BackgroundDecoration(
        child: Center(
          child: Obx(
            () => Column(
              children: [
                if (controller.loadingStatus.value == LoadingStatus.loading)
                  const Expanded(
                      child: Center(
                          child: ContentArea(
                    child: QuestionScreenHolder(),
                  ))),
                if (controller.loadingStatus.value == LoadingStatus.completed)
                  Expanded(
                      child: ContentArea(
                    child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 25),
                        child: Column(
                          children: [
                            Text(
                              controller.currentQuestion.value!.question,
                              style: questionTS,
                            ),
                            GetBuilder<QuestionsController>(
                              id: 'answers_list',
                              builder: (controller) {
                                return ListView.separated(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(top: 25),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final answer = controller.currentQuestion
                                          .value!.answers![index];
                                      return AnswerCard(
                                        answer:
                                            "${answer.identifier}. ${answer.answer}",
                                        onTap: () {
                                          controller.selectedAnswer(
                                              answer.identifier);
                                        },
                                        isSelected: answer.identifier ==
                                            controller.currentQuestion.value!
                                                .selectedAnswer,
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 10,
                                      );
                                    },
                                    itemCount: controller.currentQuestion.value!
                                        .answers!.length);
                              },
                            ),
                          ],
                        )),
                  )),
                ColoredBox(
                  color: customScaffoldColor(context),
                  child: Padding(
                    padding: UIParameters.mobileScreenPadding,
                    child: Row(
                      children: [
                        Visibility(
                          visible: controller.isFirstQuestion,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: SizedBox(
                              width: 55,
                              height: 55,
                              child: MainButton(
                                onTap: () {
                                  controller.preQuestion();
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Get.isDarkMode
                                      ? onSurfaceTextColor
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Visibility(
                            visible: controller.loadingStatus.value ==
                                LoadingStatus.completed,
                            child: MainButton(
                              onTap: () {
                                controller.isLastQuestion
                                    ? Get.toNamed(TestOverviewScreen.routeName)
                                    : controller.nextQuestion();
                              },
                              title: controller.isLastQuestion
                                  ? "Complete"
                                  : "Next",
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
        ),
      ),
    );
  }
}
