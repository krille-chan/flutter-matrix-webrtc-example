import 'package:flutter_easy_template/model/app_state.dart';

/// Adds actions to your AppState
extension CounterActions on AppState {
  void increaseCounter() {
    counter.value = counter.value + 1;
  }
}
