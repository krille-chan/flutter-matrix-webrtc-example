import 'package:flutter/material.dart';
import 'package:flutter_easy_template/pages/home/home_controller.dart';
import 'package:flutter_easy_template/pages/info/info_controller.dart';

abstract class AppRoutes {
  /// Define your routes here. Use {} for
  static const Map<String, List<Page>> _routes = {
    '/': [MaterialPage(child: HomePage())],
    '/info': [
      MaterialPage(child: HomePage()),
      MaterialPage(child: InfoPage()),
    ],
  };

  /// Define your routes here.
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    final route = routeSettings.name ?? '';
    final pages = _routes[route];
    if (pages == null) {
      return MaterialPageRoute(
        builder: (_) => const Text('Route not found...'),
      );
    }
    return MaterialPageRoute(
      builder: (_) => Navigator(
        pages: pages,
      ),
    );
  }
}
