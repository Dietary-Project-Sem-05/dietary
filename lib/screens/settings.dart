import "package:flutter/material.dart";

class SettingsPage extends StatefulWidget{
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{

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
        title: const Text('Settings'),
        backgroundColor: Colors.black38,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/drawer_img.jpg"),
            repeat: ImageRepeat.repeat
          )

        ),
        child: Container(
          color: Colors.black.withOpacity(0.95),
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                        "Meal plan notifications",
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                    Spacer(),
                    Switch(
                      value: isSwitched,
                      onChanged: toggleSwitch,
                      activeColor: Colors.green[900],
                      activeTrackColor: Colors.green,
                      inactiveThumbColor: Colors.white70,
                      inactiveTrackColor: Colors.white60,
                    )
                  ],
                )

              ],
            ),
          ),
        )


      ),

    );
  }
}