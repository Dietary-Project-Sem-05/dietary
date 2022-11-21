import 'package:dietary_project/screens/login_page.dart';
import 'package:dietary_project/screens/profile.dart';
import 'package:dietary_project/screens/settings.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            constraints: BoxConstraints.expand(),
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("lib/assets/images/drawer_img.jpg"),
              repeat: ImageRepeat.repeat,
            )),
            child: Container(
              color: Colors.black.withOpacity(0.9),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const DrawerHeader(
                    margin: EdgeInsets.only(top: 62.3),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: AssetImage('lib/assets/images/goal.png')),
                    ),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.verified_user),
                    title: const Text('Profile'),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage())),
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage())),
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Logout'),
                    onTap: () async => {
                      // SharedPreferences preferences = await SharedPreferences.getInstance();
                      // await preferences.clear();

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LogInPage())),
                    },
                  ),
                ],
              ),
            )));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> tips = [
    "You are what you eat, so don’t be fast, cheap, easy, or fake.",
    "If you keep good food in your fridge, you will eat good food.",
    "By choosing healthy over skinny you are choosing self-love over self-judgement.",
    "Eat breakfast like a king, lunch like a prince, and dinner like a pauper.",
    "Let food be thy medicine, thy medicine shall be thy food.",
  ];

  final _random = new Random();
  int element = 0;
  String text = "You are what you eat, so don’t be fast, cheap, easy, or fake.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.black38,
      ),
      body: Container(
          constraints: BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("lib/assets/images/home_bg.jpg"),
            repeat: ImageRepeat.repeat,
          )),
          child: Container(
            color: Colors.black.withOpacity(0.7),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Have a Healthy Day",
                    style: TextStyle(fontSize: 32),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Icon(
                  Icons.health_and_safety,
                  size: 100,
                  color: Colors.green,
                ),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                      bottom: 0,
                    ),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      color: Colors.black.withOpacity(0.7),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Title(
                          color: Colors.blue,
                          child: const Text(
                            "Tip of the day!!!\n",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 17,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        // TODO: This is the place where you should upload the daily tip
                        Text(
                          text,
                          textAlign: TextAlign.justify,
                          style: TextStyle(letterSpacing: 2),
                        ),
                      ],
                    )),
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                        ),
                        onPressed: () {
                          element = _random.nextInt(tips.length);
                          text = tips[element];
                          // TODO: THis is where previous tip should added
                          print("Clicked previous tip");
                        },
                        highlightColor: Colors.black12,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                        ),
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                        onPressed: () {
                          // TODO: THis is where previous tip should added
                          print("Clicked next tip");
                        },
                        highlightColor: Colors.black12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
