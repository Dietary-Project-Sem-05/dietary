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
  }

  saveData() async {
    dbHandler = await GoalDBHandler();
    await dbHandler.initDatabaseConnection();
    UserGoalModel ugModel = await UserGoalModel.withoutGoalId(
        _accountNo,
        _startingDate,
        int.parse(_currentWeight),
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

  Widget _buildCurrentWeightField() {
    return TextFormField(
      key: Key("currentWeight"),
      maxLength: 5,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          counterText: "",
          labelText: "Current Weight(kg)",
          labelStyle: TextStyle(
            color: Colors.white,
          )),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12.5,
      ),
      validator: (text) {
        return HelpValidator.validateStartingWeight(text);
      },
      onSaved: (text) {
        _currentWeight = text!;
      },
    );
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

  Widget _buildCurrentDateField(BuildContext context) {
    return TextFormField(
      key: Key("currentDate"),
      controller: startingDateInput,
      //editing controller of this TextField
      decoration: const InputDecoration(
        labelText: "Starting Date",
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
            lastDate: DateTime(2035));

        if (pickedDate != null) {
          //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          //formatted date output using intl package =>  2021-03-16

          setState(() {
            startingDateInput.text =
                formattedDate; //set output date to TextField value.
            _startingDate = pickedDate;
            // print(_startingDate);
          });
        } else {
          print("Date is not selected");
        }
      },
      validator: (date) {
        return HelpValidator.validateStartingDate(date);
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
        return HelpValidator.validateExpectedDate(date, _startingDate);
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
                  image: AssetImage("lib/assets/images/home_bg.jpg"),
                  repeat: ImageRepeat.repeat,
                )),
            child: SingleChildScrollView(
              child: Container(
                height: 400.0,
                width: 350.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.8),
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 45.0,
                  vertical: 145.0,
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
                            child: _buildCurrentWeightField(),
                          ),
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
                            child: _buildCurrentDateField(context),
                          ),
                          Expanded(
                            flex: 1,
                            child: _buildExpectedDateField(context),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50.0,
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

  static String? validateExpectedDate(expDate, _startingDate) {
    if (expDate.isEmpty) {
      return "Expected date cannot be empty";
    } else if (_startingDate == null) {
      return "Starting date cannot be empty";
    } else {
      // print(_startingDate);
      final startingDate = _startingDate;
      final expirationDate = DateTime.parse(expDate);
      final bool isExpired = expirationDate.isAfter(startingDate);

      if ((_startingDate != null) && !isExpired) {
        return "Invalid Date";
      }
      if (expirationDate.difference(startingDate).inDays > 30) {
        return "More than 30 days diff";
      }
      return null;
    }
  }
}
