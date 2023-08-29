import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quizzems/firebase_ref/loading_status.dart';
import 'package:quizzems/firebase_ref/references.dart';
import 'package:quizzems/models/question_paper_model.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs; //loading status is obs type

  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading; //0

    final fireStore = FirebaseFirestore.instance;
    print("Data is uploading...");
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // loading json file and printing path
    final papersInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/DB/papers") && path.contains(".json"))
        .toList();
    List<QuestionPaperModel> questionPapers = [];
    // print(papersInAssets);
    for (var paper in papersInAssets) {
      String stringPaperContent = await rootBundle.loadString(paper);
      questionPapers
          .add(QuestionPaperModel.fromJson(json.decode(stringPaperContent)));
      // print(stringPaperContent);
    }
    // print("items number: ${questionPapers[0].id}");
    var batch = fireStore.batch();

    for (var paper in questionPapers) {
      batch.set(questionPaperRF.doc(paper.id), {
        "title": paper.title,
        "imageUrl": paper.imageUrl,
        "description": paper.description,
        "timeSeconds": paper.timeSeconds,
        "questionCount": paper.questions == null ? 0 : paper.questions!.length,
      });
      for (var questions in paper.questions!) {
        final questionPath =
            questionRF(paperId: paper.id!, questionId: questions.id!);
        batch.set(questionPath, {
          "question": questions.question,
          "correctAnswer": questions.correctAnswer
        });

        for (var answer in questions.answers!) {
          batch.set(questionPath.collection("answers").doc(answer.identifier), {
            "identifier": answer.identifier,
            "answer": answer.answer,
          });
        }
      }
    }
    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;
  }
}
