import "package:flutter/material.dart";
import 'package:get_storage/get_storage.dart';
import '../DatabaseHandler/AccountDBHandler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late int _accountNo;
  late String _weight;
  late String _height;

  late AccountDBHandler dbHandler;

  final box = GetStorage();

  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    _accountNo = box.read("user_no");
  }

  updateProfile() async{
    dbHandler = await AccountDBHandler();
    await dbHandler.initDatabaseConnection();

    await dbHandler.updateProfileInfo(int.parse(_weight), int.parse(_height), _accountNo);

    return Fluttertoast.showToast(
      msg: "Successfully Added!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.black87,
      fontSize: 16.0,
    );
  }

  Widget _returnWeight() {
    return TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      style: const TextStyle(
        fontSize: 12,
      ),
      onSaved: (text) {
        _weight = text!;
      },
      validator: (weight){
        return HelpValidator.validateWeight(weight);
      },
    );
  }

  Widget _returnHeight() {
    return TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      style: const TextStyle(
        fontSize: 12,
      ),
      onSaved: (text) {
        _height = text!;
      },
      validator: (height){
        return HelpValidator.validateHeight(height);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Weight",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: _returnWeight(),
                                ),
                                const SizedBox(
                                  width: 25,
                                  child: Text(
                                    "kg",
                                    style: TextStyle(
                                      fontSize: 13,
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
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Expanded(
                                  child: _returnHeight(),
                                ),
                                const SizedBox(
                                  width: 25,
                                  child: Text(
                                    "cm",
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      print(_height);
                                      print(_weight);
                                      updateProfile();
                                    } else {
                                      print("Not Saved");
                                    }
                                  },
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Row(
                                      children: const [
                                        Text(
                                          "Update",
                                          style: TextStyle(letterSpacing: 3),
                                        ),
                                        Icon(Icons.update),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          )),
    );
  }
}

class HelpValidator {
  static String? validateWeight(value) {
    // print(value.runtimeType);
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    if (int.parse(value) <= 0) {
      return "Value must be positive";
    }
    if (int.parse(value) > 600) {
      return "Value is not in range";
    }
    return null;
  }

  static String? validateHeight(value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    if (int.parse(value) <= 0) {
      return "Value must be positive";
    }
    if (int.parse(value) > 300) {
      return "Value is not in range";
    }
    return null;
  }
}
