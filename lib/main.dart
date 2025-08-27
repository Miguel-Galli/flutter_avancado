import 'package:flutter/material.dart';
import 'package:flutter_avancado/builders/change_state_builder.dart';
import 'package:flutter_avancado/controllers/state_observable.dart';
import 'package:flutter_avancado/counter_state.dart';

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

  @override
  void initState() {
    observableCounter.addListener(callback);
    super.initState();
  }

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
            ObservableBuilder(
              observable: counterState,
              child: Text("Child Widget"),
              builder: (BuildContext context, child) {
                return Column(
                  children: [
                    Text('valor do estado ChangeState: ${counterState.counter}'),
                    child!
                  ],
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                counterState.increment();
              },
              child: const Text('Mudar Estado'),
            ),

            Text('valor do StateObservable : ${observableCounter.state}'),
            ElevatedButton(
              onPressed: () {
                observableCounter.state++;
              },
              child: const Text('Mudar Estado'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    observableCounter.removeListener(callback);
    super.dispose();
  }
}
