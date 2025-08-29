import 'package:flutter/foundation.dart';
import 'package:flutter_avancado/controllers/change_state.dart';

@visibleForTesting
class ObservableCounter extends ChangeState {
  int count = 0;

  void increment() {
    count++;
    notifyCallback();
  }
}