import 'package:flutter/material.dart';
import 'registration.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _username;
  var _password;

  Widget _buildUserNameField() {
    return TextFormField(
      maxLength: 30,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: "Username",
          hintStyle: TextStyle(
            color: Colors.white,
          )),
      maxLines: 1,
      style: TextStyle(
        color: Colors.white,
      ),
      validator: (username) {
        return HelpValidator.validateUsername(username!);
      },
      onSaved: (username) {
        _username = username;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      maxLength: 30,
      decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(
            color: Colors.white,
          )),
      maxLines: 1,
      obscureText: true,
      style: TextStyle(
        color: Colors.white,
      ),
      validator: (password) {
        return HelpValidator.validatePassword(password!);
      },
      onSaved: (text) {
        _password = text!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Log In",
        ),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(

        child: Container(
          height: 300.0,
          width: 300.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage("assets/back.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 150.0),
          padding: const EdgeInsets.all(10.0),
          // alignment: Alignment.center,
          // color: Colors.black87,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: _buildUserNameField(),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: _buildPasswordField(),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        print(_username);
                        print(_password);
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
    );
  }
}

class HelpValidator {
  static String? validateUsername(String value) {
    if (value.isEmpty) {
      return "Name cannot be empty";
    }
    if (value.length < 5) {
      return "Length must be more than 5 characators";
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Name cannot be empty";
    }
    if (value.length < 5) {
      return "Length must be more than 5 characators";
    }
    return null;
  }
}
