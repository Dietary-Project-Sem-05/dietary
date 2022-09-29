import "package:flutter/material.dart";

class PrefPage extends StatefulWidget{

  const PrefPage({Key? key}) : super(key: key);

  @override
  State<PrefPage> createState() => _PrefPageState();
}

class _PrefPageState extends State<PrefPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Preferences'),
        backgroundColor: Colors.black38,
      ),

      body: Column(
        children: [
          Container(

            width: double.infinity,

            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Title(
                    color: Colors.blue,
                    child: const Text(
                        "Preferred food",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 38,
                      ),
                      textAlign: TextAlign.left,
                    ),
                ),
              ],
            ),
          )
        ],

      )
    );
  }
}