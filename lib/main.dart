import 'package:dietary_project/screens/dashboard.dart';
import 'package:dietary_project/screens/food_prefferences.dart';
import 'package:dietary_project/screens/general_info_page.dart';
import 'package:dietary_project/screens/login_page.dart';
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
      // remove the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),


      home: LogInPage(),

      routes: <String, WidgetBuilder>{
        "/register": (context)=>RegisterPage(),
        "/general_info": (context)=>GeneralInfoPage(),
      },
    );
  }
}
