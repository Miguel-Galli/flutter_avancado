import 'package:flutter_avancado/contracts/observable.dart';

class ChangeState implements Observable {
  final List<void Function()> _callBacks = [];

  @override
  void addListener(void Function() callback) {
    if (!_callBacks.contains(callback)) _callBacks.add(callback);
  }

  @override
  void removeListener(void Function() callback) {
    if (!_callBacks.contains(callback)) _callBacks.remove(callback);
  }

  void notifyCallback() {
    for (var callback in _callBacks) {
      callback();
    }
  }
}
