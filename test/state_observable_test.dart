import 'package:flutter/cupertino.dart';
import 'package:flutter_avancado/controllers/state_observable.dart';
import 'package:flutter_avancado/extensions/state_observable_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

import 'testable/controllers/product_controller.dart';
import 'testable/states/base_state.dart';

void main() {
  group("Should test StateObservable", () {
    test("Should update state correctly when we increment counter", () {
      //Arrange
      final counterState = StateObservable(0);
      //act

      counterState.state++;

      //Assert

      expect(counterState.state, 1);
    });

    test(
      "Should execute StateObservable Callback when we incrementCounter",
      () {
        //arrange
        bool isCallbackExecuted = false;
        final counterState = StateObservable(0);

        //act

        void callback() {
          isCallbackExecuted = true;
        }

        counterState.addListener(callback);

        counterState.state++;

        //Assert

        expect(counterState.state, 1);
        expect(isCallbackExecuted, true);
      },
    );
  });

  test("Should generate SuccessState when we call (getProducts)", () {
    //Arrange
    final ProductController productController = ProductController();
    expect(productController.state, isA<InitialState>());
    //act
    productController.getProducts();
    //Assert

    expect(productController.state, isA<SuccessState>());
  });

  test("Should generate states in sequence when we get error", () {
    final ProductController productController = ProductController();

    expect(
      productController.asStream(),
      emitsInOrder([
        isInstanceOf<InitialState>(),
        isInstanceOf<LoadingState>(),
        isInstanceOf<SuccessState>(),
        isInstanceOf<LoadingState>(),
        isInstanceOf<ErrorState>(),
      ]),
    );

    productController.getProducts();
    productController.generateError();
  });

  test("TestingValueNotifier", () {
    final valueNotifier = ValueNotifier(0);

    expect(valueNotifier.asStream(), emitsInOrder([0, 1, 2]));

    valueNotifier.value++;
    valueNotifier.value++;

  });
}


