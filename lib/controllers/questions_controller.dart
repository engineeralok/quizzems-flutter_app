import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quizzems/controllers/auth_controller.dart';
import 'package:quizzems/controllers/question_paper/questions_controller_extension.dart';
import 'package:quizzems/firebase_ref/loading_status.dart';
import 'package:quizzems/firebase_ref/references.dart';
import 'package:quizzems/models/question_paper_model.dart';
import 'package:quizzems/screens/home/home_screen.dart';
import 'package:quizzems/screens/question/result_screen.dart';

import 'question_paper/question_paper_controller.dart';

class QuestionsController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  late QuestionPaperModel questionPaperModel;
  final allQuestions = <Question>[];
  final questionIndex = 0.obs;
  bool get isFirstQuestion => questionIndex.value > 0;
  bool get isLastQuestion => questionIndex.value >= allQuestions.length - 1;

  Rxn<Question> currentQuestion = Rxn<Question>();

  Timer? _timer;
  int remainSeconds = 1;
  final time = '00.00'.obs;

  @override
  void onReady() {
    final questionPaper = Get.arguments as QuestionPaperModel;

    // print('_questionPaper.title : ${questionPaper.title}');
    print('_questionPaper. on ready timer : ${questionPaper.title}');

    loadData(questionPaper);
    super.onReady();
  }

  Future<void> loadData(QuestionPaperModel questionPaper) async {
    questionPaperModel = questionPaper;
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionQuery =
          await questionPaperRF
              .doc(questionPaper.id)
              .collection("questions")
              .get();

      final questions = questionQuery.docs
          .map((snapshot) => Question.fromSnapshot(snapshot))
          .toList();

      questionPaper.questions = questions;

      for (Question question in questionPaper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answersQuery =
            await questionPaperRF
                .doc(questionPaper.id)
                .collection("questions")
                .doc(question.id)
                .collection("answers")
                .get();

        final answers = answersQuery.docs
            .map((answer) => Answer.fromSnapshot(answer))
            .toList();
        question.answers = answers;
      }
    } catch (e) {
      if (kDebugMode) {
        print('error (e) : ${e.toString()}');
      }
    }

    if (questionPaper.questions != null &&
        questionPaper.questions!.isNotEmpty) {
      allQuestions.assignAll(questionPaper.questions!);
      currentQuestion.value = questionPaper.questions![0];
      _startTime(questionPaper.timeSeconds);
      print("....strat timer .....");
      if (kDebugMode) {
        print(
            'questionPaper.questions![0] : ${questionPaper.questions![0].question}');
      }
      loadingStatus.value = LoadingStatus.completed;
    } else {
      loadingStatus.value = LoadingStatus.error;
    }
  }

  void selectedAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list', 'answer_review_list']);
  }

  String get completedTest {
    final answered = allQuestions
        .where((element) => element.selectedAnswer != null)
        .toList()
        .length;
    return "$answered out of ${allQuestions.length} answered";
  }

  void jumpToQuestion(int index, {bool isGoBack = true}) {
    questionIndex.value = index;
    currentQuestion.value = allQuestions[index];

    if (isGoBack) {
      Get.back();
    }
  }

  void nextQuestion() {
    if (questionIndex.value < allQuestions.length - 1) {
      questionIndex.value++;
      currentQuestion.value = allQuestions[questionIndex.value];
    }
  }

  void preQuestion() {
    if (questionIndex.value > 0) {
      questionIndex.value--;
      currentQuestion.value = allQuestions[questionIndex.value];
    }
  }

  _startTime(int seconds) {
    const duration = Duration(seconds: 1);

    remainSeconds = seconds;

    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainSeconds ~/ 60;
        int seconds = remainSeconds % 60;
        time.value = minutes.toString().padLeft(2, "0") +
            ":" +
            seconds.toString().padLeft(2, "0");
        remainSeconds--;
      }
    });
  }

  void complete() {
    _timer!.cancel();
    Get.offAndToNamed(ResulteScreen.routeName);
  }

  void tryAgain() {
    Get.find<QuestionPaperController>().navigateToQuestions(
      paper: questionPaperModel,
      tryAgain: true,
    );
  }

  void navigateToHome() {
    _timer!.cancel();
    Get.offNamedUntil(HomeScreen.routeName, (route) => false);
  }
}
