import 'package:dietary_project/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:dietary_project/Model/general_user_model.dart';
import 'package:intl/intl.dart';
import 'package:dietary_project/DatabaseHandler/AccountDBHandler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GeneralInfoPage extends StatefulWidget {
  final int account_no;

  const GeneralInfoPage({Key? key, required this.account_no}) : super(key: key);

  @override
  State<GeneralInfoPage> createState() => _GeneralInfoPageState();
}

class _GeneralInfoPageState extends State<GeneralInfoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var dbHandler;

  TextEditingController dateinput = TextEditingController();

  var _dob;
  var _height;
  var _weight;
  var _gender;
  var _activityType;
  var _exerciseType;
  var _preferenceType;
  var _medicalCondition;
  var _notificationDay;
  var _startingDay;

  saveData() async {
    GeneralUserModel gModel = GeneralUserModel(
        _dob,
        _gender,
        int.parse(_weight),
        int.parse(_height),
        _activityType,
        _exerciseType,
        _preferenceType,
        _medicalCondition,
        _notificationDay,
        _startingDay);

    await dbHandler
        .saveGeneralInfoData(gModel, widget.account_no)
        .then((userData) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LogInPage()));

      return Fluttertoast.showToast(
          msg: "Successfully Added!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black87,
          fontSize: 16.0);
    });
  }

  List<DropdownMenuItem<String>> menuItemsActivity = [
    const DropdownMenuItem(
        value: "None", enabled: false, child: Text("Activity Type")),
    const DropdownMenuItem(
        value: "Sedentary", child: Text("Sedentary: little or no exercise")),
    const DropdownMenuItem(
        value: "Light", child: Text("Light: exercise 1-3 times a week")),
    const DropdownMenuItem(
        value: "Moderate", child: Text("Moderate: exercise 4-5 times a week")),
    const DropdownMenuItem(
        value: "Active",
        child: Text("Active: intense exercise 3-4 times a week")),
    const DropdownMenuItem(
        value: "Extra Active",
        child: Text("Extra Active: intense exercise everyday")),
  ];

  List<DropdownMenuItem<String>> menuItemsGender = [
    const DropdownMenuItem(
        value: "None", enabled: false, child: Text("Gender")),
    const DropdownMenuItem(value: "MALE", child: Text("Male")),
    const DropdownMenuItem(value: "FEMALE", child: Text("Female")),
    const DropdownMenuItem(value: "OTHER", child: Text("Other")),
  ];

  List<DropdownMenuItem<String>> menuItemsExercise = [
    const DropdownMenuItem(
        value: "None", enabled: false, child: Text("Exercise Type")),
    const DropdownMenuItem(value: "Gain", child: Text("Weight Gain")),
    const DropdownMenuItem(value: "Loss", child: Text("Weight Loss")),
  ];

  List<DropdownMenuItem<String>> menuItemsNotification = [
    const DropdownMenuItem(
        value: "None", enabled: false, child: Text("Notification day")),
    const DropdownMenuItem(value: "Monday", child: Text("Monday")),
    const DropdownMenuItem(value: "Tuesday", child: Text("Tuesday")),
    const DropdownMenuItem(value: "Wednesday", child: Text("Wednesday")),
    const DropdownMenuItem(value: "Thursday", child: Text("Thursday")),
    const DropdownMenuItem(value: "Friday", child: Text("Friday")),
    const DropdownMenuItem(value: "Saturday", child: Text("Saturday")),
    const DropdownMenuItem(value: "Sunday", child: Text("Sunday")),
  ];

  List<DropdownMenuItem<String>> menuItemsMealPreference = [
    const DropdownMenuItem(
        value: "None", enabled: false, child: Text("Meal Preference Type")),
    const DropdownMenuItem(
        value: "GlutenFree", child: Text("Gluten free and coeliac")),
    const DropdownMenuItem(
        value: "DairyFree", child: Text("Dairy free and lactose free")),
    const DropdownMenuItem(value: "Vegi", child: Text("Vegetarian")),
    const DropdownMenuItem(value: "Vegan", child: Text("Vegan")),
    const DropdownMenuItem(value: "Paleo", child: Text("Paleo")),
    const DropdownMenuItem(value: "Other", child: Text("Other")),
  ];

  List<DropdownMenuItem<String>> menuItemsStarting = [
    const DropdownMenuItem(
        value: "None", enabled: false, child: Text("Starting day")),
    const DropdownMenuItem(value: "Monday", child: Text("Monday")),
    const DropdownMenuItem(value: "Tuesday", child: Text("Tuesday")),
    const DropdownMenuItem(value: "Wednesday", child: Text("Wednesday")),
    const DropdownMenuItem(value: "Thursday", child: Text("Thursday")),
    const DropdownMenuItem(value: "Friday", child: Text("Friday")),
    const DropdownMenuItem(value: "Saturday", child: Text("Saturday")),
    const DropdownMenuItem(value: "Sunday", child: Text("Sunday")),
  ];

  String selectedValueStarting = "None";
  String selectedValueMealPreference = "None";
  String selectedValueNotification = "None";
  String selectedValueExercise = "None";
  String selectedValueGender = "None";
  String selectedValueActivity = "None";

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();

    dbHandler = AccountDBHandler();
    dbHandler.initDatabaseConnection();
  }

  Widget _buildDobField(BuildContext context) {
    return TextFormField(
      key: Key("dob"),
      controller: dateinput,
      //editing controller of this TextField
      decoration: const InputDecoration(
        labelText: "Date of Birth",
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
            initialDate: DateTime(1950),
            firstDate: DateTime(1950),
            lastDate: DateTime(2025));

        if (pickedDate != null) {
          //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          //formatted date output using intl package =>  2021-03-16

          setState(() {
            dateinput.text =
                formattedDate; //set output date to TextField value.
          });
        } else {
          print("Date is not selected");
        }
      },
      validator: (date) {
        return HelpValidator.validateDate(date);
      },
      onSaved: (date) {
        _dob = date;
      },
    );
  }

  Widget _buildWeightField() {
    return TextFormField(
      key: Key("weight"),
      maxLength: 30,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          counterText: "",
          labelText: "Weight(kg)",
          labelStyle: TextStyle(
            color: Colors.white,
          )),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12.5,
      ),
      validator: (text) {
        return HelpValidator.validateWeight(text!);
      },
      onSaved: (text) {
        _weight = text!;
      },
    );
  }

  Widget _buildHeightField() {
    return TextFormField(
      key: Key("height"),
      maxLength: 30,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          counterText: "",
          labelText: "Height(cm)",
          labelStyle: TextStyle(
            color: Colors.white,
          )),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12.5,
      ),
      validator: (text) {
        return HelpValidator.validateHeight(text);
      },
      onSaved: (text) {
        _height = text!;
      },
    );
  }

  Widget _buildActivityType() {
    return DropdownButtonFormField(
      key: Key("activityType"),
      value: selectedValueActivity,
      onChanged: (String? newValue) {
        setState(() {
          selectedValueActivity = newValue!;
          _activityType = newValue;
        });
      },
      items: menuItemsActivity,
      isExpanded: true,
      dropdownColor: Colors.black54,
      style: const TextStyle(
        fontSize: 12.5,
        color: Colors.white,
      ),
      validator: (text) {
        return HelpValidator.validateActivity(_activityType);
      },
      onSaved: (text) {
        _activityType = text;
      },
    );
  }

  Widget _buildGenderType() {
    return DropdownButtonFormField(
      key: Key("genderType"),
      value: selectedValueGender,
      onChanged: (String? newValue) {
        setState(() {
          selectedValueGender = newValue!;
          _gender = newValue;
        });
      },
      items: menuItemsGender,
      isExpanded: true,
      dropdownColor: Colors.black38,
      style: const TextStyle(
        fontSize: 12.5,
        color: Colors.white,
      ),
      validator: (text) {
        return HelpValidator.validateGender(_gender);
      },
      onSaved: (text) {
        _gender = text;
      },
    );
  }

  Widget _buildExerciseType() {
    return DropdownButtonFormField(
      key: Key("exerciseType"),
      value: selectedValueExercise,
      onChanged: (String? newValue) {
        setState(() {
          selectedValueExercise = newValue!;
          _exerciseType = newValue;
        });
      },
      items: menuItemsExercise,
      isExpanded: true,
      dropdownColor: Colors.black38,
      style: const TextStyle(
        fontSize: 12.5,
        color: Colors.white,
      ),
      validator: (text) {
        return HelpValidator.validateExerciseType(_exerciseType);
      },
      onSaved: (text) {
        _exerciseType = text;
      },
    );
  }

  Widget _buildMealPreferenceType() {
    return DropdownButtonFormField(
      key: Key("mealPreferenceType"),
      value: selectedValueMealPreference,
      onChanged: (String? newValue) {
        setState(() {
          selectedValueMealPreference = newValue!;
          _preferenceType = newValue;
        });
      },
      items: menuItemsMealPreference,
      isExpanded: true,
      dropdownColor: Colors.black38,
      style: const TextStyle(
        fontSize: 12.5,
        color: Colors.white,
      ),
      validator: (text) {
        return HelpValidator.validateMealPreference(_preferenceType);
      },
      onSaved: (text) {
        _preferenceType = text;
      },
    );
  }

  Widget _buildMedicalField() {
    return TextFormField(
      key: Key("medicalField"),
      maxLength: 30,
      maxLines: 2,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          counterText: "",
          labelText: "Medical Conditions",
          labelStyle: TextStyle(
            color: Colors.white,
          )),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12.5,
      ),
      validator: (text) {
        return HelpValidator.validateMedicalConditions(text);
      },
      onSaved: (text) {
        _medicalCondition = text!;
      },
    );
  }

  Widget _buildStartingDayType() {
    return DropdownButtonFormField(
      key: Key("startingDayType"),
      value: selectedValueStarting,
      onChanged: (String? newValue) {
        setState(() {
          selectedValueStarting = newValue!;
          _startingDay = newValue;
        });
      },
      items: menuItemsStarting,
      isExpanded: true,
      dropdownColor: Colors.black38,
      style: const TextStyle(
        fontSize: 12.5,
        color: Colors.white,
      ),
      validator: (text) {
        return HelpValidator.validateStartingDay(_startingDay);
      },
      onSaved: (text) {
        _startingDay = text;
      },
    );
  }

  Widget _buildNotificationDayType() {
    return DropdownButtonFormField(
      key: Key("notificationDayType"),
      value: selectedValueNotification,
      onChanged: (String? newValue) {
        setState(() {
          selectedValueNotification = newValue!;
          _notificationDay = newValue;
        });
      },
      items: menuItemsNotification,
      isExpanded: true,
      dropdownColor: Colors.black38,
      style: const TextStyle(
        fontSize: 12.5,
        color: Colors.white,
      ),
      validator: (text) {
        return HelpValidator.validateNotificationDay(_notificationDay);
      },
      onSaved: (text) {
        _notificationDay = text;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "General Information",
        ),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage("lib/assets/images/food_bg.jpg"),
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              height: 600.0,
              width: 300.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black87,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 45.0,
                vertical: 40.0,
              ),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Expanded(flex: 1, child: _buildHeightField()),
                      Expanded(flex: 1, child: _buildWeightField()),
                    ],
                  ),
                  _buildDobField(context),
                  _buildActivityType(),
                  Row(
                    children: [
                      Expanded(flex: 1, child: _buildGenderType()),
                      Expanded(flex: 1, child: _buildExerciseType()),
                    ],
                  ),
                  _buildMealPreferenceType(),
                  _buildMedicalField(),
                  Row(
                    children: [
                      Expanded(flex: 1, child: _buildNotificationDayType()),
                      Expanded(flex: 1, child: _buildStartingDayType()),
                    ],
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // print(_dob);
                          // print(_height);
                          // print(_weight);
                          // print(_gender);
                          // print(_activityType);
                          // print(_exerciseType);
                          // print(_preferenceType);
                          // print(_medicalCondition);
                          // print(_notificationDay);
                          // print(_startingDay);
                          saveData();
                        } else {
                          print("Not Saved");
                        }
                      },
                      child: const Text("Save"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HelpValidator {
  static String? validateDate(value) {
    if (value.isEmpty) {
      return "Date of Birth cannot be empty";
    }
    return null;
  }

  static String? validateWeight(value) {
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

  static String? validateActivity(value) {
    //print("activity "+value);
    if (value == null) {
      return "Cannot be empty";
    }
    return null;
  }

  static String? validateGender(value) {
    if (value == null) {
      return "Cannot be empty";
    }
    return null;
  }

  static String? validateExerciseType(value) {
    if (value == null) {
      return "Cannot be empty";
    }
    return null;
  }

  static String? validateMealPreference(value) {
    if (value == null) {
      return "Cannot be empty";
    }
    return null;
  }

  static String? validateStartingDay(value) {
    if (value == null) {
      return "Cannot be empty";
    }
    return null;
  }

  static String? validateNotificationDay(value) {
    if (value == null) {
      return "Cannot be empty";
    }
    return null;
  }

  static String? validateMedicalConditions(value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
  }
}
