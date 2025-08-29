import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_avancado/controllers/state_observable.dart';



extension ObservableStream<T> on StateObservable<T> {
  @visibleForTesting
  Stream<T> asStream() {
    StreamController<T> streamController = StreamController<T>();

    streamController.add(state); //initialState

    void callback() {
      streamController.add(state); //Loading -> SuccessState
    }

    addListener(callback);

    return streamController.stream;
  }
}

extension ObservableValueNotifier<T> on ValueNotifier<T> {
  @visibleForTesting
  Stream<T> asStream() {
    StreamController<T> streamController = StreamController<T>();

    streamController.add(value);

    void callback() {
      streamController.add(value);
    }

    addListener(callback);

    return streamController.stream;
  }
}
