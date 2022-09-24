import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: LogInPage(),
      routes: <String, WidgetBuilder>{
        "/register": (context)=>RegisterPage()
      },
    );
  }
}
