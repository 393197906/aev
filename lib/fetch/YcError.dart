import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'Fetch.dart';

class YcError implements Exception {
  final int statusCode;
  final String message;
  FetchOptions fetchOptions;
  Response response;


  YcError({@required this.statusCode, @required this.message,this.fetchOptions,this.response});

  @override
  String toString() {
    return "statusCode:$statusCode message:$message Request:${this.fetchOptions.toString()} Response:${response.toString()}";
  }
}
