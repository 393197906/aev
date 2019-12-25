import 'dart:convert';

import 'package:aev/fetch/YcData.dart';
import 'package:dio/dio.dart';

import 'Fetch.dart';
import 'YcError.dart';

typedef ErrorHandler = Function(YcError error);

// 阻断
final Middleware fuse = (next) {
  return (FetchOptions options) async {
    final YcData ycdata = await next(options);
    if (ycdata.error != null) throw ycdata.error;
    return ycdata;
  };
};

// 设置token
Middleware token({String token, Future<String> tokenFactory()}) {
  return (next) {
    return (FetchOptions options) async {
      options.headers =
      {
        "Authorization": (tokenFactory != null)
            ? await tokenFactory()
            : token ?? ""
      };
      return next(options);
    };
  };
}


Middleware ycFilter([ErrorHandler errorHandler]) {
  return (next) {
    return (FetchOptions options) {
      return next(options).then((Response res) {
        print("@start----------options-------------@start");
        print(options);
        print("@end-----------options------------@end");
        print("@start----------response-------------@start");
        print(res);
        print("@end-----------response------------@end");
        final data = res.data is String ? jsonDecode(res.data) : res.data;
        final status = data['status'] ?? data['state'] ?? data['code'];
        if (status != 200 && status != "200" && status != true) {
          final message = data['error'] ??
              data['message'] ??
              data['msg'] ??
              data['info'] ??
              "未知错误";

          final statusCode = int.parse(status.toString());
          throw YcError(message: message, statusCode: statusCode);
        }
        return YcData(
            data: data['data'] ?? data['result'] ?? null,
            response: res,
            completeData: data);
      }).catchError((e) {
        var error;
        if (e is DioError) {
          error = YcError(message: e.error.toString(), statusCode: 500);
        }
        if (e is Exception) {
          error = YcError(message: e.toString(), statusCode: 500);
        }
        if (e is Error) {
          error = YcError(message: e.toString(), statusCode: 500);
        }
        if (e is YcError) {
          error = e;
        }
        if (errorHandler != null) {
          errorHandler(error);
        }
        return YcData(error: error);
      });
    };
  };
}
