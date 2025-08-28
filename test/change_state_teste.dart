import 'package:flutter_avancado/controllers/change_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Should test ChangeState", () {
    test("Should increment counter", () {
      //arrange
      final _CounterChangeState changeState = _CounterChangeState();
      //act
      changeState.increment();
      //Assert
      expect(changeState.counter, 1);
    });

    test("Should execute callback", () {
      //arrange
      bool callbackExecuted = false;
      final _CounterChangeState changeState = _CounterChangeState();
      //act
      changeState.addListener(() {
        callbackExecuted = true;
      });
      changeState.increment();
      //Assert
      expect(changeState.counter, 1);
      expect(callbackExecuted, true);
    });
  });
}

class _CounterChangeState extends ChangeState {
  int counter = 0;

  void increment() {
    counter++;
    notifyCallback();
  }
}
