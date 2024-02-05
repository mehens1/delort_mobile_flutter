import 'package:delorts/constants.dart';
import 'package:delorts/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // formKey
  final _formKey = GlobalKey<FormState>();

  //
  bool loader = false;

  //editing controller
  final TextEditingController emailController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  //
  @override
  void dispose() {
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        emailController.text = value!;
      },

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

    //recover button
    final recoverPasswordButton = Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      color: kSecondaryColor,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          //print("Hello Mehens");
        },
        child: Text(
          "Recover Now!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
          children: const [
            CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: kSecondaryColor,
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/icon.png",
                    height: 100,
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Text(
                    "Recover Password!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 3.0,
                  ),
                  Text(
                    "Enter the email address you registered \n with on this app to help us recognize \nyou",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 3.0,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  emailField,
                  SizedBox(
                    height: 20,
                  ),
                  loader ? loadingProcessBar : recoverPasswordButton,
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signIn(String userEmail) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loader = true;
      });

      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: userEmail)
          .then((value) {
        Fluttertoast.showToast(
            msg: "Link has been sent to ${userEmail}, kindly check your email!",
            toastLength: Toast.LENGTH_LONG);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => LoginPage()),
        );
      }).catchError((e) {
        loader = false;
        Fluttertoast.showToast(
            msg: e.toString(), toastLength: Toast.LENGTH_LONG);
      });
    }

    //
  }
}
