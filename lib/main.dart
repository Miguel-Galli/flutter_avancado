import 'package:flutter/material.dart';
import 'package:flutter_avancado/presentation/pages/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeController,
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: value ? ThemeData.dark() : ThemeData.light(),
          home: const MyHomePage(title: 'ChangeNotifier'),
        );
      }
    );
  }
}

