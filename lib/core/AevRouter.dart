import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AevRouterObserver.dart';

typedef bool RouterHookHandler(Route<dynamic> route, Route<dynamic> oldRouter);

typedef T RegisterAevRouterFactory<T>(
    Map<String, dynamic> params, BuildContext ctx);

class AevRouter {
  final Router _router = Router();
  final List<RouterHookHandler> _hooksList = [];
  AevRouterObserver _observe;
  static AevRouter instance;

  AevRouter._() {
    this._observe = AevRouterObserver(_hooksList);
  }

  factory AevRouter() {
    if (instance != null) return instance;
    instance = AevRouter._();
    return instance;
  }

  // 注册路由
  AevRouter define(String path, RegisterAevRouterFactory factory) {
    _router.define(path, handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return factory(params, context);
    }));
    return this;
  }

  // TODO
  // 跳转
  Future push(String path) {
    return _observe.navigatorState?.pushNamed(path);
  }

  // TODO
  // 返回
  bool back<T>([T result]) {
    return _observe.navigator.pop(result);
  }

  // TODO
  // 替换
  Future redirect(String path) {
    return _observe.navigator.pushNamed(path);
  }

  // TODO
  // 重建
  Future reLaunch(String path) {
    return _observe.navigator.pushNamed(path);
  }

  void use(RouterHookHandler routerHookHandler) {
    _hooksList.add(routerHookHandler);
  }

  get generator {
    return _router.generator;
  }

  NavigatorObserver get observe {
    return _observe;
  }
}
