import 'package:flutter/material.dart';
import 'package:flutter_avancado/presentation/controllers/theme_controller.dart';

final ThemeController themeController = ThemeController();

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
            ValueListenableBuilder(
              valueListenable: themeController,
              builder: (context, value, child) {
                return Switch(
                  value: value,
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