import 'package:flutter/material.dart';

class AppColor {
  ///This class is where all the app colors will be added
  ///This is a private class and as so all its fields must be made static
  AppColor._();

  static const kPrimaryColor = MaterialColor(0XFF093E76, {});
  static const kSecondaryColor = MaterialColor(
    0XFF2FB087,
    {
      100: Color(0XFFD5EFE7),
      200: Color(0XFF97D7C3),
      300: Color(0XFF74CAAF),
      400: Color(0XFF2FB087),
      500: Color(0XFF279371),
      600: Color(0XFF185844),
      700: Color(0XFF09231B),
      800: Color(0xFF2FB087),
    },
  );
  static const kGrayscaleColor = MaterialColor(
    0XFF393939,
    {
      100: Color(0XFFD7D7D7),
      200: Color(0XFF9C9C9C),
      300: Color(0XFF5A5A5A),
      400: Color(0XFF393939),
      500: Color(0XFF303030),
      600: Color(0XFF262626),
      700: Color(0XFF0B0B0B),
      800: Color(0XF7F7F7F7),
    },
  );
  static const kGrayErrorColor = MaterialColor(
    0XFFEC1B1B,
    {
      100: Color(0XFFFBD1D1),
      200: Color(0XFFF9B3B3),
      300: Color(0XFFF26767),
      400: Color(0XFFEC1B1B),
      500: Color(0XFFC51717),
      600: Color(0XFF9D1212),
      700: Color(0XFF760E0E),
      800: Color(0XFFEC1B1B),
    },
  );
  static const kGrayNeutralColor = MaterialColor(
    0XFFD4D4D4,
    {
      100: Color(0XFFFFFFFF),
      200: Color(0XFFF6F6F6),
      300: Color(0XFFEEEEEE),
      400: Color(0XFFD4D4D4),
      500: Color(0xFF0B303E),
      600: Color(0xFFD0D3D5),
      700: Color(0xFFF3F4F5)
    },
  );
}
