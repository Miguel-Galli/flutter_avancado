import 'package:flutter_avancado/controllers/state_observable.dart';

import '../entities/product_entitie.dart';
import '../states/base_state.dart';

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
    } catch (e) {
      state = ErrorState(message: e.toString());
    }
  }
}