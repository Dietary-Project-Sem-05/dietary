import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RealIntakePage extends StatefulWidget {
  const RealIntakePage({Key? key}) : super(key: key);

  @override
  State<RealIntakePage> createState() => _RealIntakeState();

}

class _RealIntakeState extends State<RealIntakePage>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Real Food Intake"),
        backgroundColor: Colors.black38,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assert/images/home_bg.jpg"),
            repeat: ImageRepeat.repeat,
          )
        ),

        child: Container(
          color: Colors.black.withOpacity(0.6),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 100,
                child: Text(
                  "Enter foods you have taken today"
                ),
              )
            ],
          ),
        ),
      ),
    );

    throw UnimplementedError();
  }

}