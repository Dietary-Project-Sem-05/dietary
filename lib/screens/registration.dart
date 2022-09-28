import 'package:dietary_project/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:dietary_project/DatabaseHandler/DbHelper.dart';
import 'package:dietary_project/Model/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _firstName;
  var _lastName;
  var _password;
  var _email;
  var _username;
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  signUp() async{
    UserModel userMd = UserModel(_firstName, _lastName, _username, _email, _password);

    await dbHelper.checkUserName(_username).then((userData) {
      if (userData != null){
        return Fluttertoast.showToast(
            msg: "Username exist!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.black87,
            fontSize: 16.0
        );
      }
    });

    await dbHelper.saveData(userMd).then((userData) {
      Fluttertoast.showToast(
          msg: "Successfully Saved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black87,
          fontSize: 16.0
      );

       Navigator.push(
           context, MaterialPageRoute(builder: (_) => LogInPage()));
    }).catchError((error) {
      print(error);
      Fluttertoast.showToast(
          msg: "Not Saved "+ error,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.black87,
          fontSize: 16.0
      );
    });
  }

  //TextController to read text entered in text field
  TextEditingController passwordEntered = TextEditingController();
  TextEditingController confirmPasswordEntered = TextEditingController();

  Widget _buildFirstNameField() {
    return TextFormField(
      maxLength: 30,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          hintText: "First Name",
          hintStyle: TextStyle(
            color: Colors.white,
          )),
      maxLines: 1,
      style: const TextStyle(
        color: Colors.white,
      ),
      validator: (firstName) {
        return HelpValidator.validateFirstName(firstName!);
      },
      onSaved: (firstName) {
        _firstName = firstName;
      },
    );
  }

  Widget _buildLastNameField() {
    return TextFormField(
      maxLength: 30,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          hintText: "Last Name",
          hintStyle: TextStyle(
            color: Colors.white,
          )),
      maxLines: 1,
      style: const TextStyle(
        color: Colors.white,
      ),
      validator: (lastName) {
        return HelpValidator.validateLastName(lastName!);
      },
      onSaved: (lastName) {
        _lastName = lastName;
      },
    );
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

  Widget _buildEmailField() {
    return TextFormField(
      maxLength: 50,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          hintText: "Email",
          hintStyle: TextStyle(
            color: Colors.white,
          )),
      maxLines: 1,
      style: const TextStyle(
        color: Colors.white,
      ),
      validator: (email) {
        return HelpValidator.validateEmail(email!);
      },
      onSaved: (email) {
        _email = email;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      maxLength: 30,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: const InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(
            color: Colors.white,
          )),
      maxLines: 1,
      style: const TextStyle(
        color: Colors.white,
      ),
      validator: (password) {
        return HelpValidator.validatePassword(password!);
      },
      onChanged: (password) {
        _password = password;
      },
    );
  }

  Widget _buildAgainPasswordField() {
    return TextFormField(
      maxLength: 30,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: const InputDecoration(
          hintText: "Re-enter Password",
          hintStyle: TextStyle(
            color: Colors.white,
          )),
      maxLines: 1,
      style: const TextStyle(
        color: Colors.white,
      ),
      validator: (confirmPassword) {
        return HelpValidator.validateAgainPassword(_password, confirmPassword!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Sign Up",
          ),
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, LogInPage());
            },
          )),
      body: SingleChildScrollView(
        child: Container(
          height: 600.0,
          width: 300.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage("lib/assets/images/back.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 40.0),
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: _buildFirstNameField(),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: _buildLastNameField(),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: _buildEmailField(),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: _buildUserNameField(),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: _buildPasswordField(),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: _buildAgainPasswordField(),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        print(_username);
                        print(_password);
                        print(_firstName);
                        print(_lastName);
                        print(_email);
                        signUp();
                      } else {
                        print("Not Saved");
                      }
                    },
                    child: const Text("Sign In"),
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
    if (value.length < 8) {
      return "Length must be more than 8 characters";
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Password cannot be empty";
    }
    if (value.length < 8) {
      return "Length must be more than 8 characters";
    }
    if (!RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)").hasMatch(value)) {
      return "Password is not strong";
    }
    return null;
  }

  static String? validateAgainPassword(
      String passwordEntered, String againPasswordEntered) {
    // print(passwordEntered);
    if (againPasswordEntered.isEmpty) {
      return "Password cannot be empty";
    }
    if (passwordEntered != againPasswordEntered) {
      return "Password does not match";
    }
    return null;
  }

  static String? validateFirstName(String value) {
    if (value.isEmpty) {
      return "First Name cannot be empty";
    }
    return null;
  }

  static String? validateLastName(String value) {
    if (value.isEmpty) {
      return "Last Name cannot be empty";
    }
    return null;
  }

  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return "Email cannot be empty";
    }
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
      return 'Invalid Email';
    }
    return null;
  }
}
