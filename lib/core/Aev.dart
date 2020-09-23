import 'dart:async';

import 'package:aev/Toast/index.dart';
import 'package:aev/core/AevBaseWidget.dart';
import 'package:aev/fetch/Fetch.dart';
import 'package:aev/ioc/Ioc.dart';
import 'package:aev/router/AevRouter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef Widget UseModelHandel(Widget child);
typedef ExceptionHandler(dynamic error, dynamic stackTrace);

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

class Aev {
  static Aev instance;
  AevRouter _aevRouter;
  ThemeData _aevTheme;
  String _aevTitle = "flutter应用";
  UseModelHandel _useModelHandel;
  ExceptionHandler _exceptionHandler;

  Aev._();

  factory Aev() {
    if (instance != null) return instance;
    instance = Aev._();
    return instance;
  }

  Aev useExceptionHandler(ExceptionHandler exceptionHandler) {
    this._exceptionHandler = exceptionHandler;
    return this;
  }

  Aev useModel(UseModelHandel useModelHandel) {
    this._useModelHandel = useModelHandel;
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
    Ioc.provider<AevRouter>(aevRouter);
    return this;
  }

  Aev useFetchWithMiddlewares({List<Middleware> middlewares = const []}) {
    // 注册fetch
    Ioc.providerLazy<Fetch>(() {
      return Fetch(enableLog: false, middlewares: middlewares);
    });
    return this;
  }

  // ioc 初始化
  _iocHelper() {
    // 注册Toast
    Ioc.provider<Toast>(Toast());

    // 注册持久化
    Ioc.provider<Future<SharedPreferences>>(SharedPreferences.getInstance());
  }

  Aev start() {
    _iocHelper();
    // This captures errors reported by the Flutter framework.
    // flutter 异常
    FlutterError.onError = (FlutterErrorDetails details) async {
      if (isInDebugMode) {
        // In development mode simply print to console.
        FlutterError.dumpErrorToConsole(details);
      } else {
        // In production mode report to the application zone to report to
        // Sentry.
        Zone.current.handleUncaughtError(details.exception, details.stack);
      }
    };

    final aevBaseWidget = AevBaseWidget(
      aevRouter: this._aevRouter,
      theme: this._aevTheme,
      title: this._aevTitle,
    );

    runZonedGuarded<Future<Null>>(() async {
      this._useModelHandel != null
          ? runApp(this._useModelHandel(aevBaseWidget))
          : runApp(aevBaseWidget);
    }, (error, stackTrace) async {
      // 捕获异常
      print('Aev Caught error: $error');
      if (isInDebugMode) {
        print(stackTrace);
        return;
      }
      if (this._exceptionHandler != null) {
        await this._exceptionHandler(error, stackTrace);
      }
    });

    return this;
  }
}
