import 'package:dietary_project/DatabaseHandler/GoalDBHandler.dart';
import 'package:dietary_project/Model/user_goal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SetGoalsEditPage extends StatefulWidget {
  const SetGoalsEditPage({Key? key}) : super(key: key);

  @override
  State<SetGoalsEditPage> createState() => _SetGoalsEditPageState();
}

class _SetGoalsEditPageState extends State<SetGoalsEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final box = GetStorage();

  late GoalDBHandler dbHandler;

  var _accountNo;
  var _currentWeight;
  var _expectedWeight;
  var _startingDate;
  var _expectedDate;

  TextEditingController startingDateInput = TextEditingController();
  TextEditingController expectedDateInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    _accountNo = box.read("user_no");
    _currentWeight = box.read("cWeight");
    _startingDate = DateTime.now();
  }

  saveData() async {
    dbHandler = await GoalDBHandler();
    await dbHandler.initDatabaseConnection();
    UserGoalModel ugModel = await UserGoalModel.withoutGoalId(
        _accountNo,
        _startingDate,
        _currentWeight,
        _expectedDate,
        int.parse(_expectedWeight),
        0);

    await dbHandler.saveGoalDetails(ugModel);
    Fluttertoast.showToast(
      msg: "Successfully Added!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.black87,
      fontSize: 16.0,
    );
    Navigator.pop(context);
    // print(goalId);
  }

  Widget _buildExpectedWeightField() {
    return TextFormField(
      key: Key("expectedWeight"),
      maxLength: 5,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          counterText: "",
          labelText: "Expected Weight(kg)",
          labelStyle: TextStyle(
            color: Colors.white,
          )),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12.5,
      ),
      validator: (text) {
        return HelpValidator.validateExpectedWeight(text);
      },
      onSaved: (text) {
        _expectedWeight = text!;
      },
    );
  }



  Widget _buildExpectedDateField(BuildContext context) {
    return TextFormField(
      key: Key("expectedDate"),
      controller: expectedDateInput,
      //editing controller of this TextField
      decoration: const InputDecoration(
        labelText: "Expected Date",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      readOnly: true,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12.5,
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2035),
        );

        if (pickedDate != null) {
          //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          //formatted date output using intl package =>  2021-03-16

          setState(() {
            expectedDateInput.text =
                formattedDate; //set output date to TextField value.
            _expectedDate = pickedDate;
          });
        } else {
          print("Date is not selected");
        }
      },
      validator: (date) {
        return HelpValidator.validateExpectedDate(date);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Goal'),
          backgroundColor: Colors.black38,
        ),
        body: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("lib/assets/images/food_colored.jpg"),
              repeat: ImageRepeat.repeat,
            )),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black87.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          "Note",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        Title(
                          color: Colors.blue,
                          child: const Text(
                            "Set Your Goals and be the best among the best in life 😁",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              letterSpacing: 2,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 400.0,
                    width: 350.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black87.withOpacity(0.7),
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 45.0,
                      vertical: 50.0,
                    ),
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [

                              Expanded(
                                flex: 1,
                                child: _buildExpectedWeightField(),
                              ),
                            ],
                          ),
                          Row(
                            children: [

                              Expanded(
                                flex: 1,
                                child: _buildExpectedDateField(context),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(100, 20),
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Row(
                                      children: const [
                                        Text(
                                          "Back",
                                          style: TextStyle(letterSpacing: 3),
                                        ),
                                        Icon(Icons.exit_to_app),
                                      ],
                                    ),
                                  )),
                              ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      saveData();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(100, 20),
                                  ),
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}

class HelpValidator {
  static String? validateStartingWeight(value) {
    if (value.isEmpty) {
      return "Weight cannot be empty";
    }
    if (int.parse(value) <= 0) {
      return "Weight must be positive";
    }
    if (int.parse(value) > 600) {
      return "Weight is not in range";
    }
    return null;
  }

  static String? validateExpectedWeight(value) {
    if (value.isEmpty) {
      return "Weight cannot be empty";
    }
    if (int.parse(value) <= 0) {
      return "Weight must be positive";
    }
    if (int.parse(value) > 600) {
      return "Weight is not in range";
    }
    return null;
  }

  static String? validateStartingDate(value) {
    if (value.isEmpty) {
      return "Date cannot be empty";
    }
    return null;
  }

  static String? validateExpectedDate(expDate) {
    if (expDate.isEmpty) {
      return "Expected date cannot be empty";
    } else {
      // print(_startingDate);
      final startingDate = DateTime.now();
      final expirationDate = DateTime.parse(expDate);
      final bool isExpired = expirationDate.isAfter(startingDate);

      if (!isExpired) {
        return "Invalid Date";
      }
      if (expirationDate.difference(startingDate).inDays > 30) {
        return "More than 30 days diff";
      }
      return null;
    }
  }
}
