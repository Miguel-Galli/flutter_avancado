import 'package:flutter/material.dart';
import 'package:flutter_avancado/controllers/state_observable.dart';

class ObservableStateBuilder<T> extends StatefulWidget {
  final StateObservable stateObservable;
  final Widget Function(BuildContext context, T state, Widget? child) builder;
  final bool Function(T oldState, T newState)? buildWhen;
  final void Function(BuildContext context, T state)? listener;
  final Widget? child;

  const ObservableStateBuilder({
    super.key,
    required this.stateObservable,
    required this.builder,
    this.child,
    this.buildWhen,
    this.listener,
  });

  @override
  State<ObservableStateBuilder<T>> createState() =>
      _ObservableStateBuilderState<T>();
}

class _ObservableStateBuilderState<T> extends State<ObservableStateBuilder<T>> {
  late T state;

  @override
  void initState() {
    widget.stateObservable.addListener(callback);
    state = widget.stateObservable.state;
    super.initState();
  }

  void callback() {
    if (shouldRebuild()) {
      state = widget.stateObservable.state;
      if (widget.listener != null) {
        widget.listener!(context, state);
      }
      setState(() {});
    }
    state = widget.stateObservable.state;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, state, widget.child);
  }

  bool shouldRebuild() {
    if (widget.buildWhen != null) {
      return widget.buildWhen!(state, widget.stateObservable.state);
    }
    return true;
  }

  @override
  void dispose() {
    widget.stateObservable.removeListener(callback);
    super.dispose();
  }
}
