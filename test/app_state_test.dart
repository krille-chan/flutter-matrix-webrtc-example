import 'package:flutter/widgets.dart';
import 'package:flutter_easy_template/model/app_state.dart';
import 'package:flutter_easy_template/model/actions/counter_actions.dart';
import 'package:flutter_easy_template/model/app_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppState', () {
    late AppStorage storage;
    late AppState appState;
    setUp(() async {
      storage = await AppStorage.init();
      appState = AppState(
        storage: storage,
        child: Container(),
      );
    });

    test('Increase counter', () {
      expect(appState.counter.value, 0);
      appState.increaseCounter();
      expect(appState.counter.value, 1);
    });
  });
}
