import 'dart:convert';

import 'package:final_mobile/model/config.dart';
import 'package:final_mobile/model/user.dart';
import 'package:final_mobile/view/aftersplashpage.dart';
import 'package:final_mobile/view/mainpage.dart';
import 'package:final_mobile/view/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isChecked = false;
  bool _passwordVisible = true;

  late double screenHeight, screenWidth, resWidth;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadPref();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [upperHalf(context), lowerHalf(context)],
          ),
        ),
      ),
    );
  }

  Widget upperHalf(BuildContext context) {
    return SizedBox(
      height: screenHeight / 3,
      width: screenWidth,
      child: Image.asset('assets/images/login.png', fit: BoxFit.cover),
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Container(
        height: 600,
        width: resWidth,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Card(
                elevation: 10,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(25, 10, 20, 25),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Hindu',
                                decoration: TextDecoration.underline),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _emailditingController,
                            decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter valid email';
                              }
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value);

                              if (!emailValid) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _passEditingController,
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          Row(children: [
                            Checkbox(
                              value: _isChecked,
                              onChanged: (bool? value) {
                                _onRememberMeChanged(value!);
                              },
                            ),
                            const Flexible(
                              child: Text('Remember me',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MaterialButton(
                                color: const Color.fromARGB(255, 190, 222, 230),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                minWidth: 115,
                                height: 50,
                                elevation: 10,
                                onPressed: _loginUser,
                                child: const Text('Login'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Register new account? ",
                    style: TextStyle(fontSize: 15)),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const RegisterPage()))
                  },
                  child: const Text(
                    " Click here",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const AfterSplash()))
              },
              child: const Text(
                "Back",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
            ),
          ],
        )));
  }

  void saveremovepref(bool value) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String email = _emailditingController.text;
      String password = _passEditingController.text;
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (value) {
        await prefs.setString('email', email);
        await prefs.setString('pass', password);
        await prefs.setBool('remmeber', true);

        Fluttertoast.showToast(
            msg: "Preference Stored",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
      } else {
        await prefs.setString('email', '');
        await prefs.setString('pass', '');
        await prefs.setBool('remmeber', false);
        setState(() {
          _emailditingController.text = '';
          _passEditingController.text = '';
          _isChecked = false;
        });
        Fluttertoast.showToast(
            msg: "Preference Removed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Preference Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      _isChecked = false;
    }
  }

  void _onRememberMeChanged(bool newValue) => setState(() {
        _isChecked = newValue;
        if (_isChecked) {
          saveremovepref(true);
        } else {
          saveremovepref(false);
        }
      });

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    _isChecked = (prefs.getBool('remember')) ?? false;

    if (email.length > 1 && password.length > 1) {
      setState(() {
        _emailditingController.text = email;
        _passEditingController.text = password;
        _isChecked = true;
      });
    }
  }

  void _loginUser() {
    String _email = _emailditingController.text;
    String _pass = _passEditingController.text;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ProgressDialog pd = ProgressDialog(context: context);
      pd.show(msg: 'Logging in..', max: 100);
      http.post(Uri.parse(Config.server + "/mobile_mytutor/php/login_user.php"),
          body: {"email": _email, "password": _pass}).then((response) {
        print(response.body);
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] == 'success') {
          Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          pd.update(value: 100, msg: "Completed");
          pd.close();
          var extractdata = data['data'];
          User user = User.fromJson(extractdata);
          print(user.email);
          Navigator.pop(context);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content) => MainPage(user: user)));
        } else {
          Fluttertoast.showToast(
              msg: "Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          pd.update(value: 100, msg: "Failed");
          pd.close();
        }
      });
    }
  }
}
