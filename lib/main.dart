import 'package:flutter/material.dart';
import 'package:flutter_avancado/presentation/controllers/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

final ThemeController themeController = ThemeController();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeController,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: themeController.isDarkTheme ? ThemeData.dark() : ThemeData.light(),
          home: const MyHomePage(title: 'ChangeNotifier'),
        );
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Trocar tema do aplicativo'),
            ListenableBuilder(
              listenable: themeController,
              builder: (context, child) {
                return Switch(
                  value: themeController.isDarkTheme,
                  onChanged: (value) {
                    themeController.toggleTheme();
                  },
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
