import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_avancado/contracts/observable_state.dart';
import 'package:flutter_avancado/controllers/change_state.dart';

class StateObservable<T> extends ChangeState implements ObservableState {
  T _state;

  @override
  T get state => _state;

  set state(T newState) {
    if (newState == _state) return;
    _state = newState;
    notifyCallback();
  }

  StateObservable(this._state);
}

extension ObservableStream<T> on StateObservable<T> {
  Stream<T> asStream() {
    StreamController<T> streamController = StreamController<T>();

    streamController.add(state); //initialState

    void _callback() {
      streamController.add(state); //Loading -> SuccessState
    }

    addListener(_callback);

    return streamController.stream;
  }
}

extension ObservableValueNotifier<T> on ValueNotifier<T> {
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
