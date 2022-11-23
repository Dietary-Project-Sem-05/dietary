import 'package:dietary_project/screens/login_page.dart';
import 'package:dietary_project/screens/profile.dart';
import 'package:dietary_project/screens/settings.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get_storage/get_storage.dart';
import '../DatabaseHandler/AccountDBHandler.dart';

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
  String motivationQuoteString = "You are what you eat, so don’t be fast, cheap, easy, or fake.";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late int _accountNo;
  late int _weight;
  late int _height;

  late AccountDBHandler dbHandler;

  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    showPopup();
  }

  getData() {
    _accountNo = box.read("user_no");
  }

  updateProfile() async {
    await getData();

    dbHandler = await AccountDBHandler();
    await dbHandler.initDatabaseConnection();

    await dbHandler.updateProfileInfo(_weight, _height, _accountNo);

    Navigator.pop(context);
  }

  showPopup() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var weightCtrl = TextEditingController();
      var heightCtrl = TextEditingController();

      showDialog(
        context: context,
        builder: (context) => Form(
          key: _formKey,
          child: AlertDialog(
            content: const Text('Update Your Details'),
            actions: [
              TextFormField(
                keyboardType: TextInputType.number,
                controller: weightCtrl,
                decoration: const InputDecoration(
                  icon: Icon(Icons.numbers),
                  hintText: 'Enter your current weight',
                  labelText: 'Weight (kg)*',
                ),
                onSaved: (value) {
                  print(_weight);
                  _weight = int.parse(value!);
                },
                validator: (value) {
                  return HelpValidator.validateWeight(value!);
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: heightCtrl,
                decoration: const InputDecoration(
                  icon: Icon(Icons.numbers),
                  hintText: 'Enter your current weight',
                  labelText: 'Height (cm)*',
                ),
                onSaved: (value) {
                  _height = int.parse(value!);
                },
                validator: (value) {
                  return HelpValidator.validateHeight(value!);
                },
              ),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 20),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Exit'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 20),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _weight = int.parse(weightCtrl.text);
                        _height = int.parse(heightCtrl.text);

                        updateProfile();
                      }
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController tipCtrl = TextEditingController(text: motivationQuoteString);

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
            color: Colors.black87.withOpacity(0.7),
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
                      borderRadius: const BorderRadius.only(
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
                        TextFormField(
                          controller: tipCtrl,
                          enabled: false,
                          maxLines: 3,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(letterSpacing: 2),
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
                          motivationQuoteString = tips[element];
                          tipCtrl.text = motivationQuoteString;
                          print("Clicked previous tip");
                        },
                        highlightColor: Colors.black12,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10),
                        ),
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                        onPressed: () {
                          element = _random.nextInt(tips.length);
                          motivationQuoteString = tips[element];
                          tipCtrl.text = motivationQuoteString;
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

class HelpValidator {
  static String? validateHeight(heightString) {

    if (heightString.isEmpty) {
      return "Height cannot be empty";
    } else if (int.parse(heightString) > 200) {
      return "Height is out of range";
    } else if (int.parse(heightString) < 0) {
      return "Height cannot be negative";
    } else if (int.parse(heightString) == 0) {
      return "Height cannot be 0";
    } else {
      return null;
    }
  }

  static String? validateWeight(weightString) {

    if (weightString.isEmpty) {
      return "Weight cannot be empty";
    } else if (int.parse(weightString) > 300) {
      return "Weight is out of range";
    } else if (int.parse(weightString) < 0) {
      return "Weight cannot be negative";
    } else if (int.parse(weightString) == 0) {
      return "Weight cannot be 0";
    } else {
      return null;
    }
  }
}
