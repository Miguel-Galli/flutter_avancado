import 'package:flutter/material.dart';
import 'package:flutter_avancado/builders/observable_state_builder.dart';
import 'package:flutter_avancado/controllers/state_observable.dart';
import 'package:flutter_avancado/counter_state.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Gerenciamento de Estado'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counterState = CounterState();
  final observableCounter = StateObservable(0);

  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ObservableStateBuilder(
              stateObservable: observableCounter,
              listener: (context, state) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Valor do counter: $state")),
                );
              },
              buildWhen: (oldState, newState) {
                return (newState as int) % 2 == 0;
              },
              builder: (context, state, child) {
                return Text(
                  'Contador Observable: $state',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                observableCounter.state++;
              },
              child: const Text('Incrementar Observable'),
            ),
          ],
        ),
      ),
    );
  }
}
