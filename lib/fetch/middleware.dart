import 'dart:convert';

import 'package:dio/dio.dart';

import 'Fetch.dart';
import 'YcError.dart';

typedef ErrorHandler = Function(YcError error);

Middleware ycFilter([ErrorHandler errorHandler]) {
  return (next) {
    return (FetchOptions options) {
      return next(options).then((Response res) {
        final data = res.data is String ? jsonDecode(res.data) : res.data;
        final statusCode = data['status'] ?? data['state'] ?? data['code'];
        if (statusCode != 200 && statusCode != true) {
          final message =
              data['message'] ?? data['msg'] ?? data['info'] ?? "未知错误";
          throw YcError(message: message, statusCode: statusCode);
        }
        return data['data'] ?? null;
      }).catchError((e) {
        var error;
        if (e is DioError) {
          error = YcError(message: e.error.toString(), statusCode: 500);
        }
        if (e is Exception) {
          error = YcError(message: e.toString(), statusCode: 500);
        }
        if (e is YcError) {
          error = e;
        }
        if (errorHandler != null) {
          errorHandler(error);
        }
      });
    };
  };
}
