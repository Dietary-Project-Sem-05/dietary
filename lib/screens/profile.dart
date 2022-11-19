import "package:flutter/material.dart";
import 'package:get_storage/get_storage.dart';
import 'package:postgres/postgres.dart';
import '../DatabaseHandler/AccountDBHandler.dart';
import 'package:age_calculator/age_calculator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late int _accountNo;
  late String _firstName;
  late String _lastName;
  late DateDuration _age;
  late int _weight;
  late int _height;
  late AccountDBHandler dbHandler;

  final box = GetStorage();

  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    _firstName = box.read('first_name');
    _lastName = box.read("last_name");
    _accountNo = box.read("user_no");
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: downloadData(), // function where you call your api
      builder: (
        BuildContext context,
        AsyncSnapshot<String> snapshot,
      ) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Material(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                SizedBox(height: 20),
                CircularProgressIndicator()
              ],
            ),
          );
        } else {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          } else {
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
                                    const SizedBox(height: 40),
                                    Container(
                                        alignment: Alignment.center,
                                        child: const CircleAvatar(
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
                              margin: const EdgeInsets.only(
                                  top: 100, bottom: 100, left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "First Name ",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        initialValue: _firstName,
                                        autofocus: false,
                                        enabled: false,
                                        style: const TextStyle(fontSize: 20),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Last Name",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        initialValue: _lastName,
                                        enabled: false,
                                        autofocus: false,
                                        style: const TextStyle(fontSize: 20),
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
                                        initialValue: "$_age",
                                        enabled: false,
                                        autofocus: false,
                                        style: const TextStyle(fontSize: 20),
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
                                        initialValue: _weight.toString(),
                                        autofocus: false,
                                        style: const TextStyle(fontSize: 20),
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
                                        initialValue: _height.toString(),
                                        autofocus: false,
                                        style: const TextStyle(fontSize: 20),
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
          } // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }

  Future<String> downloadData() async {
    //   var response =  await http.get('https://getProjectList');
    dbHandler = await AccountDBHandler();
    await dbHandler.initDatabaseConnection();
    List? data = await dbHandler.getProfilePageInfo(_accountNo);
    _age = data![0];
    _weight = data[1];
    _height = data[2];
    return Future.value("Data download successfully"); // return your response
  }
}
