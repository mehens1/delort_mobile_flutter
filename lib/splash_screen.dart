import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delorts/checkVersion.dart';
import 'package:delorts/constants.dart';
import 'package:delorts/login.dart';
import 'package:delorts/portal/quickReport.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //
  final Uri _url = Uri.parse('https://flutter.dev');

  @override
  void initState() {
    //
    checkVersion();
    super.initState();

    FirebaseFirestore.instance
        .collection("info")
        .doc("DELORT_INFORMATION")
        .get()
        .then((value) {
      //
      if (buildNumber < value["Build"]) {
        _forceUpdate(context);
      } else {
        if (FirebaseAuth.instance.currentUser == null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => LoginPage()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => QuickReport()),
          );
        }
      }
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(), toastLength: Toast.LENGTH_LONG);
    });

    //
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/mainbg.png"),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 200,
              ),
              SizedBox(height: 200),
              CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 50),
              Text(
                "Version ${delortVersion}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _forceUpdate(BuildContext context) {
    // set up the button
    Widget closeButton = TextButton(
      child: Text("Exit"),
      onPressed: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
    );

    Widget updateButton = TextButton(
      child: Text("UPDATE"),
      onPressed: () {
        if (Platform.isAndroid || Platform.isIOS) {
          // final appId = Platform.isAndroid ? androidPackageID : iosPackageID;
          final url = Uri.parse(
            Platform.isAndroid
                ? "https://delorts.com/#download"
                : "https://delorts.com/#download",
          );
          launchUrl(
            url,
            mode: LaunchMode.externalApplication,
          );
        }

        // if (Platform.isAndroid || Platform.isIOS) {
        //   final appId = Platform.isAndroid ? androidPackageID : iosPackageID;
        //   final url = Uri.parse(
        //     Platform.isAndroid
        //         ? "market://details?id=$appId"
        //         : "https://apps.apple.com/app/id$appId",
        //   );
        //   launchUrl(
        //     url,
        //     mode: LaunchMode.externalApplication,
        //   );
        // }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Update App."),
      content: Text(
          "Your app is out of date\n\nYou need to update your DELoRT System to continue using the services!\n\nThank you for choosing DELoRTs"),
      actions: <Widget>[closeButton, updateButton],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async =>
            false, // <-- Prevents dialog dismiss on press of back button.
        child: alert,
      ),
    );
  }
}
