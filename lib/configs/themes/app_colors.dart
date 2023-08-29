import 'package:get/get.dart';
import 'package:quizzems/configs/themes/app_dark_theme.dart';
import 'package:quizzems/configs/themes/app_light_theme.dart';
import 'package:flutter/material.dart';
import 'package:quizzems/configs/themes/ui_parameters.dart';

const Color onSurfaceTextColor = Colors.white;
const Color correctAnswerColor = Color(0xFF3ac3cb);
const Color wrongAnswerColor = Color(0xFFf85187);
const Color notAnsweredColor = Color(0xFF2a3c65);

const mainGradientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryFirstColorLight,
      primaryColorLight,
    ]);
const mainMenuGradientLight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryFirstColorLight,
      primaryColorLight,
    ]);

LinearGradient mainGradientDark = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryFirstColorDark,
      primaryColorDark,
    ]);

LinearGradient mainGradient() =>
    UIParameters.isDarkMode() ? mainGradientDark : mainGradientLight;

Color customScaffoldColor(BuildContext context) => UIParameters.isDarkMode()
    ? const Color(0xFF2e3c62)
    : const Color.fromARGB(255, 240, 237, 255);

Color answerSelectedColor() => UIParameters.isDarkMode()
    ? Theme.of(Get.context!).cardColor.withOpacity(0.5)
    : Theme.of(Get.context!).primaryColor;

Color answerBorderColor() => UIParameters.isDarkMode()
    ? const Color.fromRGBO(255, 20, 46, 150)
    : const Color.fromRGBO(255, 221, 221, 221);
