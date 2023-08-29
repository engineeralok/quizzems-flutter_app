import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzems/configs/themes/app_colors.dart';
import 'package:quizzems/configs/themes/ui_parameters.dart';

TextStyle cardTitles(context) => (TextStyle(
      color: UIParameters.isDarkMode()
          ? Theme.of(context).textTheme.bodyLarge!.color
          : Theme.of(context).primaryColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ));

const questionTS = TextStyle(fontSize: 16, fontWeight: FontWeight.w800);

const detailText = TextStyle(fontSize: 12);
const headerText = TextStyle(
    fontSize: 22, fontWeight: FontWeight.w700, color: onSurfaceTextColor);

const appBarTS = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 16, color: onSurfaceTextColor);
TextStyle countDownTimeTS() => TextStyle(
      letterSpacing: 2,
      color: UIParameters.isDarkMode() ? Theme.of(Get.context!).textTheme.bodyMedium!.color
   :  Theme.of(Get.context!).primaryColor)  ;
