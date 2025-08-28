import 'package:flutter/material.dart';
import 'package:flutter_avancado/controllers/state_observable.dart';
import 'package:flutter_avancado/counter_state.dart';
import 'package:flutter_avancado/mixins/change_state_mixin.dart';

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

class _MyHomePageState extends State<MyHomePage> with ChangeStateMixin {
  final counterState = CounterState();
  final observableCounter = StateObservable(0);
  late StateObservable<int> newMixinCounter;

  @override
  void initState() {
    useChangeState(counterState);
    useChangeState(observableCounter);
    newMixinCounter = useStateObservable(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Contador CounterState: ${counterState.counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () {
                counterState.increment();
              },
              child: const Text('Incrementar counter'),
            ),
            Text(
              'Contador Observable: ${observableCounter.state}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () {
                observableCounter.state++;
              },
              child: const Text('Incrementar Observable'),
            ),
            Text(
              'Contador newMixinStateObservable: ${newMixinCounter.state}',
            ),
            ElevatedButton(
              onPressed: () {
                newMixinCounter.state++;
              },
              child: const Text('Incrementar Observable'),
            ),
          ],
        ),
      ),
    );
  }
}
