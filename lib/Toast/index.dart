import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as Ftoast;

enum ToastLength { LENGTH_SHORT, LENGTH_LONG }

class Toast {
  Color _successColor;
  Color _primaryColor;
  Color _dangerColor;
  Color _infoColor;
  Color _warningColor;

  Toast(
      {primaryColor = Colors.blue,
      infoColor = Colors.grey,
      warningColor = Colors.yellow,
      successColor = Colors.green,
      dangerColor = Colors.red}) {
    this._successColor = successColor;
    this._primaryColor = primaryColor;
    this._dangerColor = dangerColor;
    this._infoColor = infoColor;
    this._warningColor = warningColor;
  }

  Future<bool> show(
      {String msg = "",
      ToastLength toastLength = ToastLength.LENGTH_SHORT,
      Ftoast.ToastGravity gravity = Ftoast.ToastGravity.BOTTOM,
      int timeInSecForIos = 1,
      Color backgroundColor = Colors.blueGrey,
      Color textColor = Colors.white,
      double fontSize = 16.0}) {
    return Ftoast.Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength == ToastLength.LENGTH_LONG
            ? Ftoast.Toast.LENGTH_LONG
            : Ftoast.Toast.LENGTH_SHORT,
        gravity: gravity,
        timeInSecForIos: timeInSecForIos,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: fontSize);
  }

  Future<bool> primary(String msg) {
    return show(msg: msg, backgroundColor: _primaryColor);
  }

  Future<bool> success(String msg) {
    return show(msg: msg, backgroundColor: _successColor);
  }

  Future<bool> info(String msg) {
    return show(msg: msg, backgroundColor: _infoColor);
  }

  Future<bool> warning(String msg) {
    return show(msg: msg, backgroundColor: _warningColor);
  }

  Future<bool> danger(String msg) {
    return show(msg: msg, backgroundColor: _dangerColor);
  }
}
