import 'package:flutter/widgets.dart';
import 'package:flutter_avancado/controllers/change_state.dart';

@visibleForTesting
class CounterChangeState extends ChangeState {
  int counter = 0;

  void increment() {
    counter++;
    notifyCallback();
  }
}