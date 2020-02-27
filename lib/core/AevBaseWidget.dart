import 'package:aev/aev.dart';
import 'package:flutter/material.dart';

import '_Localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AevBaseWidget extends StatelessWidget {
  final AevRouter aevRouter;
  final String title;
  final ThemeData theme;

  AevBaseWidget({@required this.title, @required this.aevRouter, this.theme});

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
      theme: this.theme,
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(brightness: Brightness.light)
      ),
    );
  }
}
