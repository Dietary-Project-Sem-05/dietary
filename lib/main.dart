import 'package:dietary_project/screens/general_info_page.dart';
import 'package:flutter/material.dart';
import 'screens/general_info_page.dart';
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
        primarySwatch: Colors.blue,
      ),
      home: GeneralInfoPage(),
      routes: <String, WidgetBuilder>{
        "/register": (context)=>RegisterPage(),
        "/general_info": (context)=>GeneralInfoPage(),
      },
    );
  }
}
