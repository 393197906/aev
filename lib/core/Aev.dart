import 'package:aev/Toast/index.dart';
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
  ThemeData _aevTheme;
  String _aevTitle = "flutter应用";

  Aev._();

  factory Aev() {
    if (instance != null) return instance;
    instance = Aev._();
    return instance;
  }

  Aev useModal() {
    return this;
  }

  Aev useTitle(String title) {
    this._aevTitle = title;
    return this;
  }

  Aev useTheme(ThemeData themeData) {
    this._aevTheme = themeData;
    return this;
  }

  Aev useRouter(AevRouter aevRouter) {
    this._aevRouter = aevRouter;
    Ioc.providerLazy<AevRouter>(() => aevRouter);
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
      theme: this._aevTheme,
      title: this._aevTitle,
    ));
    return this;
  }
}
