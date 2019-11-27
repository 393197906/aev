import 'package:aev/core/AevRouter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Aev {
  Aev start(Function(RouteFactory router) factory);

  Aev router(String path, RegisterAevRouterFactory factory);

  Aev modal();
}

class _Aev implements Aev {
  final aevRouter = AevRouter();

  static Aev instance;

  _Aev._();

  factory _Aev() {
    if (instance != null) return instance;
    instance = _Aev._();
    return instance;
  }

  @override
  Aev modal() {
    // TODO: implement modal
    return null;
  }

  @override
  Aev router(String path, RegisterAevRouterFactory factory) {
    aevRouter.define(path, factory);
    return this;
  }

  @override
  Aev start(Function(RouteFactory router) factory) {
    runApp(factory(aevRouter.generator));
    return null;
  }
}
