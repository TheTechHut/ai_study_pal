import 'package:flutter/material.dart';
import 'package:summarize_app/const/app_constant_imports.dart';

ThemeData themeLight = ThemeData(
  primarySwatch: const MaterialColor(0XFF093E76, {
    50: Colors.blueAccent,
    100: Colors.black,
    200: Colors.black,
    300: Colors.black,
    400: Colors.black,
    500: Colors.black,
    600: Colors.white,
    700: Colors.black,
    800: Colors.black,
    900: Colors.black,
  }),
  scaffoldBackgroundColor: AppColor.kGrayNeutralColor.shade100,
  dialogTheme: DialogTheme(
      contentTextStyle: TextStyle(
    color: AppColor.kGrayscaleColor.shade200,
  )),
  dialogBackgroundColor: AppColor.kGrayNeutralColor.shade100,
  cardColor: AppColor.kGrayNeutralColor.shade100,
  focusColor: AppColor.kGrayscaleColor.shade200,
  canvasColor: Colors.black,
  hintColor: AppColor.kGrayscaleColor.shade200,
);

ThemeData themeDark = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  dialogBackgroundColor: AppColor.kGrayscaleColor.shade200,
  dialogTheme: DialogTheme(
      contentTextStyle: TextStyle(
    color: AppColor.kGrayNeutralColor.shade100,
  )),
  cardColor: Colors.black,
  focusColor: AppColor.kGrayscaleColor.shade200,
  canvasColor: AppColor.kGrayNeutralColor.shade200,
  hintColor: AppColor.kGrayscaleColor.shade200,
);
