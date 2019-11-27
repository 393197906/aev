import 'package:flutter/material.dart';

import 'AevRouter.dart';


class AevRouterObserver extends NavigatorObserver {
  NavigatorState _navigatorState;
  final List<RouterHookHandler> _hooksList;

  NavigatorState get navigatorState => _navigatorState;

  AevRouterObserver(this._hooksList);

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    if (this._hooksList.every((fn) => fn(route, previousRoute))) {
      _navigatorState = (route)?.navigator;
      print('push');
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (this._hooksList.every((fn) => fn(route, previousRoute))) {
      _navigatorState = (route)?.navigator;
      print('pop');
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (this._hooksList.every((fn) => fn(newRoute, oldRoute))) {
      _navigatorState = (newRoute)?.navigator;
      print('replace');
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didRemove(route, previousRoute);
    if (this._hooksList.every((fn) => fn(route, previousRoute))) {
      _navigatorState = (route)?.navigator;
      print('remove');
    }
  }

}
