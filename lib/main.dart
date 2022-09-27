import 'package:dietary_project/screens/meal_plan_page.dart';
import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(),
        // primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
