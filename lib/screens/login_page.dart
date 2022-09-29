import 'package:dietary_project/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dietary_project/DatabaseHandler/AccountDbHelper.dart';
import 'package:dietary_project/Model/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _username;
  var _password;
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = AccountDbHelper();
  }

  logIn() async{
    await dbHelper.getLoginUser(_username, _password).then((userData) {
      if (userData != null) {
        Fluttertoast.showToast(
            msg: "Welcome",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.black87,
            fontSize: 16.0
        );

        setSP(userData).whenComplete(() {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => DashBoardPage()),
                  (Route<dynamic> route) => false);
        });
      } else {
        Fluttertoast.showToast(
            msg: "User not found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.black87,
            fontSize: 16.0
        );
      }
    }).catchError((error) {
      print(error);
      Fluttertoast.showToast(
          msg: "Erro123r: "+error,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.black87,
          fontSize: 16.0
      );
    });
  }

  Future setSP(AccountModel user) async {
    final SharedPreferences sp = await _pref;

    // sp.setString("user_id", user.user_id!);
    sp.setString("user_name", user.user_name!);
    sp.setString("first_name", user.first_name!);
    sp.setString("last_name", user.last_name!);
    sp.setString("email", user.email!);
    sp.setString("password", user.password!);
  }

  Widget _buildUserNameField() {
    return TextFormField(
      maxLength: 30,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          hintText: "Username",
          hintStyle: TextStyle(
            color: Colors.white,
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
      maxLength: 30,
      decoration: const InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(
            color: Colors.white,
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
        ),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 400.0,
          width: 300.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage("lib/assets/images/back.jpg"),
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

                        logIn();
                      } else {
                        print("Not Saved");
                      }
                    },
                    child: const Text("Sign In"),
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
    );
  }
}

class HelpValidator {
  static String? validateUsername(String value) {
    if (value.isEmpty) {
      return "Username cannot be empty";
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Password cannot be empty";
    }
    return null;
  }
}
