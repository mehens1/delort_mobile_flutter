import 'package:delorts/constants.dart';
import 'package:delorts/portal/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuickReport extends StatefulWidget {
  QuickReport({Key? key}) : super(key: key);

  @override
  State<QuickReport> createState() => _QuickReportState();
}

class _QuickReportState extends State<QuickReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(
          "Accident Report",
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: GestureDetector(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Image.asset("assets/images/quick_reported.png"),
                )
              ],
            ),
            onTap: () {
              Fluttertoast.showToast(msg: "Reported!");
            },
          ),
        ),
      ),
    );
  }
}
