import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quizzems/controllers/auth_controller.dart';
import 'package:quizzems/firebase_ref/references.dart';
import 'package:quizzems/models/question_paper_model.dart';
import 'package:quizzems/services/firebase_storage_service.dart';

class QuestionPaperController extends GetxController {
  final allPaperImages = <String>[].obs;
  final allPapers = <QuesitonPaperModel>[].obs;

  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    List<String> imgName = ["biology", "chemistry", "maths", "physics"];
    try {
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();
      final paperList = data.docs
          .map((paper) => QuesitonPaperModel.fromSnapshot(paper))
          .toList();
      allPapers.assignAll(paperList);

      // for (var img in imgName) {
      //   final imgUrl = await Get.find<FirebaseStorageService>().getImage(img);
      //   allPaperImages.add(imgUrl.toString());
      // }
      for (var paper in paperList) {
        final imgUrl =
            await Get.find<FirebaseStorageService>().getImage(paper.title);
        paper.imageUrl = imgUrl;
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      print(e);
    }
  }

  void navigateToQuestions(
      {required QuesitonPaperModel paper, bool tryAgain = false}) {
    AuthController _authController = Get.find();
    if (_authController.isLogged()) {
      if (tryAgain) {
        Get.back();
        // Get.offNamed(page);
      } else {
        print("Logged In");
        //Get,toNamed()
      }
    } else {
      print('The title is : ${paper.title}');
      _authController.showLoginAlertDialogue();
    }
  }
}
