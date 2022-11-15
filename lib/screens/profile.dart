import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _userId;
  String? _userNo;

  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();

    _userId = await prefs.getString("first_name");
    _userNo = await prefs.getString("last_name");

  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  // SharedPreferences prefs = await SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.black38,
      ),
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/assets/images/drawer_img.jpg"),
                  repeat: ImageRepeat.repeat)),
          child: SingleChildScrollView(
            child: Container(
                height: 670,
                width: double.infinity,
                color: Colors.black.withOpacity(0.95),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.blue,
                                  Colors.indigo,
                                ],
                              ),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              )),
                        ),
                        Column(
                          children: [
                            SizedBox(height: 40),
                            Container(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  backgroundColor: Colors.indigo,
                                  radius: 60,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "lib/assets/images/avatar.png"),
                                    backgroundColor: Colors.white,
                                    radius: 58,
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                          top: 100, bottom: 100, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                "First Name ",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: TextFormField(
                                initialValue: _userId,
                                autofocus: false,
                                enabled: false,
                                style: TextStyle(fontSize: 20),
                              ))
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Last Name ",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: TextFormField(
                                initialValue: _userNo,
                                enabled: false,
                                autofocus: false,
                                style: TextStyle(fontSize: 20),
                              ))
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "Age",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                width: 45,
                              ),
                              Expanded(
                                  child: TextFormField(
                                initialValue: "22",
                                enabled: false,
                                autofocus: false,
                                style: TextStyle(fontSize: 20),
                              ))
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "Weight",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: TextFormField(
                                initialValue: "76",
                                autofocus: false,
                                style: TextStyle(fontSize: 20),
                              )),
                              const SizedBox(
                                width: 25,
                                child: Text(
                                  "kg",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "Height",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                  child: TextFormField(
                                initialValue: "1.72",
                                autofocus: false,
                                style: TextStyle(fontSize: 20),
                              )),
                              const SizedBox(
                                width: 25,
                                child: Text(
                                  "cm",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          )),
    );
  }
}
