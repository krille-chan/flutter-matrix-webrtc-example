import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:webrtc_flutter_matrix/pages/chat/chat_controller.dart';
import 'package:webrtc_flutter_matrix/pages/home/home_controller.dart';
import 'package:webrtc_flutter_matrix/pages/info/info_controller.dart';
import 'package:webrtc_flutter_matrix/pages/login/info_controller.dart';

class AppRoutes {
  final Client client;

  /// Define your routes here. Use {} for
  static const Map<String, Widget> _routes = {
    '/': HomePage(),
    '/login': LoginPage(),
    '/info': InfoPage(),
  };

  AppRoutes(this.client);

  /// Define your routes here.
  Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    final route = !client.isLogged() ? '/login' : routeSettings.name ?? '';
    final page = _routes[route];
    if (page == null) {
      if (route.startsWith('/chat/')) {
        final roomId = route.split('/')[2];
        return MaterialPageRoute(
            builder: (_) => ChatPage(room: client.getRoomById(roomId)!));
      }
      return MaterialPageRoute(
        builder: (_) => const Text('Route not found...'),
      );
    }
    return MaterialPageRoute(builder: (_) => page);
  }
}
