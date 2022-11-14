import "package:flutter/material.dart";

class FaqPage extends StatefulWidget{
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage>{

  bool isSwitched = false;

  void toggleSwitch(bool value){
    if(isSwitched == false){
      setState(() {
        isSwitched = true;
      });
    }
    else{
      setState(() {
        isSwitched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
        backgroundColor: Colors.black38,
      ),
      body: Container(

      ),

    );
  }
}