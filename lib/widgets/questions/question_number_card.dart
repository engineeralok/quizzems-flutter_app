import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:quizzems/configs/themes/app_colors.dart';
import 'package:quizzems/configs/themes/ui_parameters.dart';
import 'package:quizzems/widgets/questions/answer_card.dart';

class QuestionNumberCard extends StatelessWidget {
  final int index;
  final AnswerStatus? status;
  final VoidCallback onTap;
  const QuestionNumberCard(
      {super.key,
      required this.index,
      required this.status,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).primaryColor;
    switch (status) {
      case AnswerStatus.answered:
        Get.isDarkMode
            ? backgroundColor = Theme.of(context).cardColor
            : backgroundColor = Theme.of(context).primaryColor;
        break;
      case AnswerStatus.correct:
        backgroundColor = correctAnswerColor;
        break;
      case AnswerStatus.worng:
        backgroundColor = wrongAnswerColor;
        break;
      case AnswerStatus.notAnswered:
        backgroundColor = Get.isDarkMode
            ? Colors.red.withOpacity(0.5)
            : Theme.of(context).primaryColor.withOpacity(0.1);
        break;

      default:
        backgroundColor = Theme.of(context).primaryColor.withOpacity(0.1);
    }

    return InkWell(
      onTap: onTap,
      borderRadius: UIParameters.cardBorderRadius,
      child: Ink(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: UIParameters.cardBorderRadius,
        ),
        child: Center(
          child: Text(
            '$index',
            style: TextStyle(
              color: status == AnswerStatus.notAnswered
                  ? Theme.of(context).primaryColor
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
