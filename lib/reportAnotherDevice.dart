import 'package:flutter/material.dart';
import 'constants.dart';

class ReportAnotherDevice extends StatefulWidget {
  ReportAnotherDevice({Key? key}) : super(key: key);

  @override
  State<ReportAnotherDevice> createState() => _ReportAnotherDeviceState();
}

class _ReportAnotherDeviceState extends State<ReportAnotherDevice> {
  //form key
  final _formKey = GlobalKey<FormFieldState>();

  //editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController uniqueCodeController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //email Field
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
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

    //secret code field
    final secretCodeField = TextFormField(
      autofocus: false,
      controller: uniqueCodeController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onSaved: (value) {
        uniqueCodeController.text = value!;
      },
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.mail),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.fromLTRB(15, 20, 5, 20),
        hintText: "Secret/Unique Code...",
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );

    //login button
    final externalReportButton = Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      color: kSecondaryColor,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {},
        child: Text(
          "Report!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
        padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/icon.png",
                  height: 100,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Get Lost Phone!",
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
                  "Enter the Lost Device Registered email address \n and Device Unique Security Code to help us recognize your device. \n \n NOTE: Code is case sensitive",
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
                secretCodeField,
                SizedBox(
                  height: 20,
                ),
                externalReportButton,
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
