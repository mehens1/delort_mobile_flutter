import 'dart:async';
import 'package:delorts/constants.dart';
import 'package:delorts/forgotPassword.dart';
import 'package:delorts/portal/quickReport.dart';
import 'package:delorts/register.dart';
import 'package:delorts/reportAnotherDevice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // form key
  final _formKey = GlobalKey<FormState>();

  bool loginBtnState = false;

  //firebase auth
  final _auth = FirebaseAuth.instance;

  //editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,

      //email validator
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your Email Address!");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please enter a Valid Email Address");
        }
        return null;
      },

      textInputAction: TextInputAction.next,
      onSaved: (value) {
        emailController.text = value!;
      },
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.mail),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.fromLTRB(15, 20, 5, 20),
        hintText: "Email Address...",
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );

    //password Field
    final passwordField = TextFormField(
      obscureText: true,
      autofocus: false,
      controller: passwordController,

      //validator
      validator: (value) {
        RegExp regExp = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password required!");
        }
        if (!regExp.hasMatch(value)) {
          return ("Please enter a valid password (Min. of 6 Character)");
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      onSaved: (value) {
        passwordController.text = value!;
      },
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.key),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.fromLTRB(15, 20, 5, 20),
        hintText: "Password...",
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );

    final loadingProcessBar = Material(
      borderRadius: BorderRadius.circular(30),
      color: kSecondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: kSecondaryColor,
            ),
          ],
        ),
      ),
    );

    //login button
    final loginButton = Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      color: kSecondaryColor,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          signIn(emailController.text, passwordController.text);
          //Fluttertoast.showToast(msg: internetStatus);
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      floatingActionButton: Visibility(
        visible: !showFab,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReportAnotherDevice()),
            );
          },
          label: Text("Report Other Device"),
          backgroundColor: kSecondaryColor,
          icon: Icon(Icons.vibration),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/icon.png",
                    height: 100,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "LOG IN!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  emailField,
                  SizedBox(
                    height: 20,
                  ),
                  passwordField,
                  SizedBox(height: 30),
                  loginBtnState ? loadingProcessBar : loginButton,
                  Divider(
                    thickness: 1,
                    color: Colors.white,
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New User? ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Register(),
                            ),
                          );
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Forgot Password? ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPassword(),
                            ),
                          );
                        },
                        child: Text(
                          "Recover",
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //sign in function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          loginBtnState = !loginBtnState;
        });
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Sucessful"),
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuickReport(),
                    ),
                  )
                })
            .catchError((e) {
          setState(() {
            loginBtnState = !loginBtnState;
          });
          Fluttertoast.showToast(msg: e!.message);
        });
      } catch (e) {}
    }
  }
}
