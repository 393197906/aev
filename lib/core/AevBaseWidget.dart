import 'package:aev/aev.dart';
import 'package:aev/color/AevColor.dart';
import 'package:flutter/material.dart';

import '_Localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AevBaseWidget extends StatelessWidget {
  final AevRouter aevRouter;
  final AevColor aevColor;
  final bool aevColorReverse;
  final String title;

  AevBaseWidget(
      {@required this.title,
      @required this.aevRouter,
      @required this.aevColor,
      @required this.aevColorReverse});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('zh', 'CH'),
      localizationsDelegates: [
        ChineseCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      navigatorObservers: [this.aevRouter?.observe],
      onGenerateRoute: this.aevRouter?.generator,
      title: this.title,
      theme: ThemeData(
          primaryColor: this.aevColorReverse
              ? this.aevColor?.subColor
              : this.aevColor?.mainColor),
    );
  }
}
