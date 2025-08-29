import 'package:flutter/cupertino.dart';
import 'package:flutter_avancado/controllers/state_observable.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Should test StateObservable", () {
    test("Should update state correctly when we increment counter", () {
      //Arrange
      final counterState = StateObservable(0);
      //act

      counterState.state++;

      //Assert

      expect(counterState, 1);
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

abstract class BaseState {}

class InitialState extends BaseState {}

class LoadingState extends BaseState {}

class SuccessState<T extends Object> extends BaseState {
  final T data;

  SuccessState({required this.data});
}

class ErrorState extends BaseState {
  final String message;

  ErrorState({required this.message});
}

class Product {
  final int id;
  final String name;

  Product({required this.id, required this.name});
}

class ProductController extends StateObservable<BaseState> {
  ProductController() : super(InitialState());

  void getProducts() {
    state = LoadingState();

    state = SuccessState(
      data: [
        Product(id: 1, name: "Primeiro produto"),
        Product(id: 2, name: "Segundo produto"),
      ],
    );
  }

  void generateError() {
    state = LoadingState();

    try {
      throw Exception();
      state = SuccessState(
        data: [
          Product(id: 1, name: "Primeiro produto"),
          Product(id: 2, name: "Segundo produto"),
        ],
      );
    } catch (e) {
      state = ErrorState(message: e.toString());
    }
  }
}
