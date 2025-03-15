import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomFlutterToast {
  static void showToast({
    required String message,
    Toast? toastLength,
    ToastGravity? gravity,
    Color? backgroundColor,
    Color? textColor,
    double? fontSized,
  }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor ?? Colors.black,
        textColor: textColor ?? Colors.white,
        fontSize: fontSized);
  }
}
