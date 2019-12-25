import 'package:aev/Toast/index.dart';
import 'package:aev/color/AevColor.dart';
import 'package:aev/core/AevBaseWidget.dart';
import 'package:aev/fetch/Fetch.dart';
import 'package:aev/ioc/Ioc.dart';
import 'package:aev/router/AevRouter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Aev {
  static Aev instance;
  AevRouter _aevRouter;
  AevColor _aevColor;
  bool _aevColorReverse = false;
  String _aevTitle = "flutter应用";

  Aev._();

  factory Aev() {
    if (instance != null) return instance;
    instance = Aev._();
    return instance;
  }

  Aev modal() {
    return null;
  }

  Aev useTitle(String title) {
    this._aevTitle = title;
    return this;
  }

  Aev useRouter(AevRouter aevRouter) {
    this._aevRouter = aevRouter;
    Ioc.providerLazy<AevRouter>(() => aevRouter);
    return this;
  }

  Aev useColor(AevColor aevColor, {bool reverse = false}) {
    this._aevColor = aevColor;
    this._aevColorReverse = reverse;
    return this;
  }

  Aev useFetchWithMiddlewares({List<Middleware> middlewares = const []}) {
    // 注册fetch
    Ioc.providerLazy<Fetch>(() {
      return Fetch(enableLog: false, middlewares: middlewares);
    });
    return this;
  }

  _iocHelper() {
    // 注册Toast
    Ioc.provider<Toast>(Toast());

    // 注册持久化
    Ioc.provider<Future<SharedPreferences>>(SharedPreferences.getInstance());
  }

  Aev start() {
    _iocHelper();
    runApp(AevBaseWidget(
      aevRouter: this._aevRouter,
      aevColor: this._aevColor,
      aevColorReverse: this._aevColorReverse,
      title: this._aevTitle,
    ));
    return this;
  }
}
