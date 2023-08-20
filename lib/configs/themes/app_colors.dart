import 'package:quizzems/configs/themes/app_dark_theme.dart';
import 'package:quizzems/configs/themes/app_light_theme.dart';
import 'package:flutter/material.dart';
import 'package:quizzems/configs/themes/ui_parameters.dart';

const Color onSurfaceTextColor = Colors.white;

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

customScaffoldColor(BuildContext context) => UIParameters.isDarkMode()
    ? const Color(0xFF2e3c62)
    : const Color.fromARGB(255, 240, 237, 255);
