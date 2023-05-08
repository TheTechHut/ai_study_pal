import 'package:flutter/material.dart';
import 'package:summarize_app/shared/app_constant_imports.dart';

ThemeData themeLight = ThemeData(
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
