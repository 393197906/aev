import 'package:aev/aev.dart';
import 'package:dio/dio.dart';

class YcData {
  final dynamic data;
  final YcError error;
  final Response response;
  final dynamic completeData;

  YcData({this.data, this.error, this.response, this.completeData});

  @override
  String toString() {
    return "data:${data.toString()};error:${error.toString()}";
  }
}
