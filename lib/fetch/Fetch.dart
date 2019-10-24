import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class FetchOptions {
  String url;
  Map<String, dynamic> params;
  String method;
  String contentType;
  Map<String, dynamic> headers;
  ProgressCallback onSendProgress;
  ProgressCallback onReceiveProgress;
  int sendTimeout;
  int receiveTimeout;
  ValidateStatus validateStatus;

  FetchOptions(
      {@required this.url,
      @required this.params,
      @required this.method,
      this.onSendProgress,
      this.onReceiveProgress});

  @override
  String toString() {
    return {
      "url": url,
    }.toString();
  }
}

typedef RealFetch = Function(FetchOptions fetchOptions);
typedef Middleware = RealFetch Function(RealFetch fetch);

class Fetch {
  Dio _dio;
  final List<Middleware> middlewares;

  Fetch({this.middlewares = const [], enableLog = false}) {
    _dio = Dio();
    // 日志
    if (enableLog) {
      _dio.interceptors.add(LogInterceptor(responseBody: false));
    }
  }

  _fetch(FetchOptions fetchOptions) {
    return _dio.request(
      fetchOptions.url,
      options: Options(
          contentType: fetchOptions.contentType,
          headers: fetchOptions.headers,
          receiveTimeout: fetchOptions.receiveTimeout,
          sendTimeout: fetchOptions.sendTimeout,
          method: fetchOptions.method,
          validateStatus: (int status) => true),
      queryParameters:
          fetchOptions.method == "GET" ? fetchOptions.params : null,
      data: fetchOptions.method != "GET" ? fetchOptions.params : null,
    );
  }

  _compose(List<Middleware> items) {
    if (items.isEmpty) return (a) => a;
    if (items.length == 1) return items[0];
    return items.reduce((fl, fr) {
      return (fetch) {
        return fl(fr(fetch));
      };
    });
  }

  _generateFetch() => _compose(this.middlewares)(this._fetch);

  get(String url, [Map<String, dynamic> params = const {}]) async {
    return await _generateFetch()(FetchOptions(url: url, method: "GET"));
  }

  post(String url, [Map<String, dynamic> params = const {}]) async {
    return await _generateFetch()(
        FetchOptions(url: url, params: params, method: "POST"));
  }

  delete(String url, [Map<String, dynamic> params = const {}]) async {
    return await _generateFetch()(
        FetchOptions(url: url, params: params, method: "DELETE"));
  }

  put(String url, [Map<String, dynamic> params = const {}]) async {
    return await _generateFetch()(
        FetchOptions(url: url, params: params, method: "PUT"));
  }
}
