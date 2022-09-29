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

      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/food_colored.jpg"),
            repeat: ImageRepeat.repeat,
          )
        ),
        child: Column(
          children: [
            Container(

              width: double.infinity,

              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black54,
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
            ),
            Row(
              children: [
                Card(
                  margin: EdgeInsets.only(
                      left: 10,
                      top: 20
                  ),
                  elevation: 5,
                  shadowColor: Colors.black,
                  color: Colors.blue.withOpacity(0.8),
                  child: Container(
                      height: 100,
                      padding: const EdgeInsets.all(20),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("+",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 50,
                          ),
                        ),
                      )


                  ),
                )
              ],
            ),

            // Not preferred food
            Container(

              width: double.infinity,

              margin: EdgeInsets.only(
                  top: 50,
                  left: 10,
                  bottom: 10,
                  right: 10
              ),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Title(
                    color: Colors.red,
                    child: const Text(
                      "Preferred food",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 38,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),

                ],
              ),
            ),
            Row(
              children: [
                Card(
                  margin: EdgeInsets.only(
                      left: 10,
                      top: 20
                  ),
                  elevation: 5,
                  shadowColor: Colors.black,
                  color: Colors.red.withOpacity(0.8),
                  child: Container(
                      height: 100,
                      padding: const EdgeInsets.all(20),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("+",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 50,
                          ),
                        ),
                      )


                  ),
                )
              ],
            )

          ],

        ),
      ),

    );
  }
}