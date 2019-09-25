import 'package:flutter/cupertino.dart';

class YcError implements Exception {
  final int statusCode;
  final String message;

  YcError({@required this.statusCode, @required this.message});

  @override
  String toString() {
    return "statusCode:$statusCode message:$message";
  }
}
