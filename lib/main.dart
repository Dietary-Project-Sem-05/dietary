import 'package:dietary_project/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'screens/registration.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  await GetStorage.init();
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
      },
    );
  }
}
