import 'package:flutter/material.dart';
import 'package:flutter_easy_template/model/app_storage.dart';

/// Represents the ViewModel of your application and is accessible everywhere
/// via `AppState.of(context)`. The AppState holds a couple of ValueNotifier
/// and can be extended with **actions**. It is also connected to the
/// persistent AppStorage.
class AppState extends InheritedWidget {
  // ignore: unused_field
  final AppStorage _appStorage;

  AppState({
    required AppStorage storage,
    required super.child,
    super.key,
  }) : _appStorage = storage;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static AppState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppState>()!;

  /// Example state value using a ValueNotifier.
  final ValueNotifier<int> counter = ValueNotifier(0);
}
