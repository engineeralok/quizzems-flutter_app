// To parse this JSON data, do
//
//     final quesitonPaperModel = quesitonPaperModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

QuestionPaperModel quesitonPaperModelFromJson(String str) =>
    QuestionPaperModel.fromJson(json.decode(str));

String quesitonPaperModelToJson(QuestionPaperModel data) =>
    json.encode(data.toJson());

class QuestionPaperModel {
  String? id;
  String? title;
  String? imageUrl;
  String? description;
  int timeSeconds;
  List<Question>? questions;
  int questionCount;

  QuestionPaperModel({
    this.id,
    this.title,
    this.imageUrl,
    this.description,
    required this.timeSeconds,
    this.questions,
    required this.questionCount,
  });

  factory QuestionPaperModel.fromJson(Map<String, dynamic> json) =>
      QuestionPaperModel(
        id: json["id"],
        title: json["title"],
        imageUrl: json["image_url"],
        description: json["Description"],
        timeSeconds: json["time_seconds"],
        questionCount: 0,
        questions: json["questions"] == null
            ? []
            : List<Question>.from(
                json["questions"]!.map((x) => Question.fromJson(x))),
      );

  factory QuestionPaperModel.fromSnapshot(
          DocumentSnapshot<Map<String, dynamic>> json) =>
      QuestionPaperModel(
        id: json.id,
        title: json["title"],
        imageUrl: json["imageUrl"] as String,
        description: json["description"],
        timeSeconds: json["timeSeconds"],
        questionCount: json["questionCount"] as int,
        questions: [],
      );

  String timeInMinutes() => "${(timeSeconds / 60).ceil()} mins";

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image_url": imageUrl,
        "Description": description,
        "time_seconds": timeSeconds,
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
      };
}

class Question {
  String? id;
  String question;
  List<Answer>? answers;
  String correctAnswer; // Change the type to String
  String? selectedAnswer; // Change the type to String

  Question({
    this.id,
    required this.question,
    this.answers,
    required this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        question: json["question"],
        answers: json["answers"] == null
            ? []
            : List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
        correctAnswer: json["correct_answer"], // Keep it as a string
      );

  Question.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        question = snapshot['question'],
        answers = [],
        correctAnswer = snapshot['correctAnswer'];

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answers": answers == null
            ? []
            : List<dynamic>.from(answers!.map((x) => x.toJson())),
        "correct_answer": correctAnswer,
      };
}

class Answer {
  String? identifier; // Change the type to String
  String? answer;

  Answer({
    this.identifier,
    this.answer,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        identifier: json["identifier"], // No need to map to enum here
        answer: json["Answer"],
      );

  Answer.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : identifier =
            snapshot["identifier"] as String?, // No need to map to enum here
        answer = snapshot["answer"] as String?;

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "Answer": answer,
      };
}

enum CorrectAnswer { A, B, C, D }

final correctAnswerValues = EnumValues({
  "A": CorrectAnswer.A,
  "B": CorrectAnswer.B,
  "C": CorrectAnswer.C,
  "D": CorrectAnswer.D
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
