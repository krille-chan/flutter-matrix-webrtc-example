import 'package:flutter/material.dart';

import 'package:matrix/matrix.dart';

import 'package:webrtc_flutter_matrix/model/voip_delegate.dart';

/// Represents the ViewModel of your application and is accessible everywhere
/// via `AppState.of(context)`. The AppState holds a couple of ValueNotifier
/// and can be extended with **actions**. It is also connected to the
/// persistent AppStorage.
class AppState extends InheritedWidget {
  final Client client;
  final VoIP voip;

  AppState({
    required this.client,
    required super.child,
    super.key,
  }) : voip = VoIP(client, VoipDelegate());

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static AppState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppState>()!;
}
