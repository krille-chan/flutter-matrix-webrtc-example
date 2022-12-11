import 'package:flutter/material.dart';
import 'package:flutter_easy_template/pages/home/home_controller.dart';
import 'package:flutter_easy_template/pages/info/info_controller.dart';

abstract class AppRoutes {
  /// Define your routes here. Use {} for
  static const Map<String, Widget> _routes = {
    '/': HomePage(),
    '/info': InfoPage(),
  };

  /// Define your routes here.
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    final route = routeSettings.name ?? '';
    final page = _routes[route];
    if (page == null) {
      return MaterialPageRoute(
        builder: (_) => const Text('Route not found...'),
      );
    }
    return MaterialPageRoute(builder: (_) => page);
  }
}
