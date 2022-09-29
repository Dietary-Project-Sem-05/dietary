import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

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
      decoration: const InputDecoration(
          hintText: "Username",
          hintStyle: TextStyle(
            color: Colors.grey,
            letterSpacing: 1,
          )),
      maxLines: 1,
      style: const TextStyle(
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
      maxLength: 15,
      decoration: const InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(
            color: Colors.grey,
            letterSpacing: 1,
          )),
      maxLines: 1,
      obscureText: true,
      style: const TextStyle(
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
          "Sign In",
          style: TextStyle(
            color: Colors.blue,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: Colors.black38,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        height: 100,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/food_bg.jpg"),
            repeat: ImageRepeat.repeat,
          ),
        ),

        child: SingleChildScrollView(
          child: Container(
            height: 400.0,
            width: 300.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black87

            ),
            margin: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 150.0),
            padding: const EdgeInsets.all(10.0),
            // alignment: Alignment.center,
            // color: Colors.black87,
            child : Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1,
                      ),),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(color: Colors.white),
                          children: [
                            TextSpan(
                                text: "Click Here!",
                                style: TextStyle(color: Colors.blueAccent),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushNamed("/register");
                                    print("Tapped!");
                                  }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )

    );
  }
}

class HelpValidator {
  static String? validateUsername(String value) {
    if (value.isEmpty) {
      return "Name cannot be empty";
    }
    if (value.length < 5) {
      return "Length must be more than 5 charactors";
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Password cannot be empty";
    }
    if (value.length < 5) {
      return "Length must be more than 5 charactors";
    }
    return null;
  }
}
