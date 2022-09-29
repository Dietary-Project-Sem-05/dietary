import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SetGoalsPage extends StatefulWidget {
  const SetGoalsPage({Key? key}) : super(key: key);

  @override
  State<SetGoalsPage> createState() => _SetGoalsPageState();
}

class _SetGoalsPageState extends State<SetGoalsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController startingDateInput = TextEditingController();
  TextEditingController expectedDateInput = TextEditingController();

  var _currentWeight;
  var _expectedWeight;
  var _startingDate;
  var _expectedDate;

  Widget _buildCurrentWeightField() {
    return TextFormField(
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
            _startingDate = formattedDate;
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
            _expectedDate = formattedDate;
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
        title: Text('Set Goal'),
        backgroundColor: Colors.black38,
      ),
      body: Container(
        height: 400.0,
        width: 350.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage("assets/back.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 145.0),
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // print(_startingDate);
                        // print(_expectedDate);
                        // print(_expectedWeight);
                        // print(_currentWeight);
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
    );
  }
}

class HelpValidator {
  static String? validateStartingWeight(value) {
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

  static String? validateExpectedWeight(value) {
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

  static String? validateStartingDate(value) {
    if (value.isEmpty) {
      return "Date cannot be empty";
    }
    return null;
  }

  static String? validateExpectedDate(
      value, _startingDate) {
    final startingDate = DateTime.parse(_startingDate);
    final expirationDate = DateTime.parse(value);
    final bool isExpired = expirationDate.isAfter(startingDate);

    if (value.isEmpty) {
      return "Date cannot be empty";
    }
    if ((_startingDate != null) && !isExpired) {
      return "Invalid Date";
    }
    if(expirationDate.difference(startingDate).inDays > 30){
      return "More than 30 days";
    }
    return null;
  }
}
