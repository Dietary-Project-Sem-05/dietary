import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddFoodItem extends StatefulWidget {
  const AddFoodItem({Key? key}) : super(key: key);

  @override
  State<AddFoodItem> createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddFoodItem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final box = GetStorage();

  var _accountNo;
  var _name;
  var _type;
  var _calory;
  var _state;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    _accountNo = box.read("user_no");
  }

  saveData() async {
    // dbHandler = await GoalDBHandler();
    // await dbHandler.initDatabaseConnection();
    //
    //
    // // await dbHandler.saveGoalDetails(ugModel);
    // return Fluttertoast.showToast(
    //   msg: "Successfully Added!",
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.TOP,
    //   timeInSecForIosWeb: 1,
    //   backgroundColor: Colors.green,
    //   textColor: Colors.black87,
    //   fontSize: 16.0,
    // );
    // print(goalId);
  }

  List<DropdownMenuItem<String>> menuItemsGender = [
    const DropdownMenuItem(
        value: "None", enabled: false, child: Text("Food Type")),
    const DropdownMenuItem(value: "MALE", child: Text("Main")),
    const DropdownMenuItem(value: "FEMALE", child: Text("Meat")),
    const DropdownMenuItem(value: "OTHER", child: Text("Dessert")),
  ];

  Widget _buildNameField() {
    return TextFormField(
      key: Key("name"),
      maxLength: 50,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
          counterText: "",
          labelText: "Name",
          labelStyle: TextStyle(
            color: Colors.white,
          )),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12.5,
      ),
      validator: (text) {
        return HelpValidator.validateName(text);
      },
      onSaved: (text) {
        _name = text!;
      },
    );
  }

  Widget _buildCalorie() {
    return TextFormField(
      key: Key("calorie"),
      maxLength: 5,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          counterText: "",
          labelText: "Calorie (mg)",
          labelStyle: TextStyle(
            color: Colors.white,
          )),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12.5,
      ),
      validator: (text) {
        return HelpValidator.validateWeight(text);
      },
      onSaved: (text) {
        _calory = text!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Food Item'),
          backgroundColor: Colors.black38,
        ),
        body: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/images/food_colored.jpg"),
                repeat: ImageRepeat.repeat,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    height: 300.0,
                    width: 350.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black87.withOpacity(0.7),
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 45.0, vertical: 145.0),
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(children: [
                              Expanded(
                                flex: 1,
                                child: _buildNameField(),
                              ),
                            ]),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: _buildCalorie(),
                                ),
                              ]
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                            Container(
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      saveData();
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
                                        Icon(Icons.flag),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}

class HelpValidator {
  static String? validateName(value) {
    if (value.isEmpty) {
      return "Weight cannot be empty";
    }
    return null;
  }

  static String? validateWeight(value) {
    if (value.isEmpty) {
      return "Weight cannot be empty";
    }
    if (int.parse(value) <= 0) {
      return "Weight must be positive";
    }
    return null;
  }

  static String? validateStartingDate(value) {
    if (value.isEmpty) {
      return "Date cannot be empty";
    }
    return null;
  }
}
