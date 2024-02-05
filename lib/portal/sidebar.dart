import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delorts/constants.dart';
import 'package:delorts/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Sidebar extends StatefulWidget {
  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  var userDetails = FirebaseAuth.instance.currentUser;

  CollectionReference userRefData =
      FirebaseFirestore.instance.collection("users");
  List<String> docIDs = [];

  Future getDocID() async {
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              Fluttertoast.showToast(msg: element.toString());
              print(element);
            }));
  }

  void iniState() {
    getDocID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var string = userDetails?.email.toString();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/background.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            accountName: Text(
              "Mehens Samson",
              style: TextStyle(fontSize: 24),
            ),
            accountEmail: Text(string!),
            currentAccountPicture: CircleAvatar(
              backgroundColor: kSecondaryColor,
              backgroundImage: AssetImage("assets/images/icon.png"),
              child: ClipOval(
                child: Image.network(
                    "https://delorts.com/assets/img/team/samson-mehens.jpg"),
                //Image.asset("assets/images/icon.png"),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "REPORTS",
                    style: TextStyle(
                      color: kGreyColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      letterSpacing: 8,
                    ),
                  ),
                  ListTile(
                    leading: Image.asset(
                      "assets/images/accident_icon.png",
                      height: 40,
                    ),
                    title: Text(
                      "Accident",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Fluttertoast.showToast(msg: "Accident pressed");
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      "assets/images/fire_icon.png",
                      height: 40,
                    ),
                    title: Text(
                      "Fire-OutBreaks",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Fluttertoast.showToast(msg: "Fire-Outbreak pressed");
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      "assets/images/quick_reported.png",
                      height: 40,
                    ),
                    title: Text(
                      "Quick Report",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Fluttertoast.showToast(msg: "Quick Report pressed");
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "PERSONAL",
                    style: TextStyle(
                      color: kGreyColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      letterSpacing: 8,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: Colors.black,
                    ),
                    title: Text(
                      "S.O.S.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Fluttertoast.showToast(msg: "Profile pressed");
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Fluttertoast.showToast(msg: "Profile pressed");
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Settings",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Fluttertoast.showToast(msg: "Settings pressed");
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Divider(
                    thickness: 0.5,
                    color: kGreyColor,
                  ),
                  ListTile(
                    leading: Icon(Icons.logout_rounded),
                    title: Text(
                      "Logout",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Fluttertoast.showToast(msg: "Logout Sucessful!");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                  ),
                  Divider(
                    thickness: 0.5,
                    color: kGreyColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Follow us on:",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Fluttertoast.showToast(msg: "Facebook icon pressed");
                        },
                        icon: Icon(Icons.facebook),
                        color: Colors.blue[900],
                      )
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
