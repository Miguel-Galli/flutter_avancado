import 'package:flutter_test/flutter_test.dart';

import 'testable/controllers/counter_change_state.dart';

void main() {
  group("Should test ChangeState", () {
    test("Should increment counter", () {
      //arrange
      final CounterChangeState changeState = CounterChangeState();
      //act
      changeState.increment();
      //Assert
      expect(changeState.counter, 1);
    });

    test("Should execute callback", () {
      //arrange
      bool callbackExecuted = false;
      final CounterChangeState changeState = CounterChangeState();
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


