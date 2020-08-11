import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../login_page.dart';
import '../../splash.dart';

class Router {
  final RouteObserver<PageRoute> routeObserver;

  Router() : routeObserver = RouteObserver<PageRoute>();

  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _buildRoute(settings, SplashScreen());
      case '/login':
        return _buildRoute(settings, LoginPage());
      default:
        return null;
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }
}
