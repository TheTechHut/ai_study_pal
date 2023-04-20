import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

showToast(String text,
    {bool shortToast = true,
    fromBottom = true,
    color = Colors.blueAccent,
    Color textColor = Colors.white,
    double fontSize = 16}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: shortToast ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
    gravity: fromBottom ? ToastGravity.BOTTOM : ToastGravity.TOP,
    backgroundColor: color,
    textColor: textColor,
    fontSize: fontSize,
  );
}
