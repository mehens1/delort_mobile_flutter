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
  int _currentIndex = 0;

  final screens = [
    //0 index screen settings
    Center(
      child: Column(
        children: [
          SizedBox(height: 100),
          Image.asset(
            "assets/images/icon.png",
            height: 100,
          ),
          SizedBox(height: 20),
          Text(
            "All Types of Report",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: kGreyColor,
                child: GestureDetector(
                  onTap: () {
                    print("Report Accident Pressed!");
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        height: 100,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Text(
                            "Report Accident!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            color: kGreyColor,
                          ),
                          Text(
                            "Click here to report accident type \n to Federal Road Safety Corp '('FRSC') \n with ease.'",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    ),

    //1 index screen design
    Center(
      child: Text("Quick Report"),
    ),

    //2 index screen design
    Center(
      child: Text("Profile"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(
          "Quick Report",
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
