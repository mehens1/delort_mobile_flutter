import 'package:cloud_firestore/cloud_firestore.dart';

String appName = "DELoRTS";
String packageName = "com.example.delorts";
String androidPackageID = "com.example.delorts";
String iosPackageID = "com.example.delorts";
String version = "1.0.1";
String delortVersion = version.split(".")[0] + "." + version.split(".")[1];
num buildNumber = 1;

num? activeBuildVersion;

void checkVersion() async {
  DocumentSnapshot appVersion = await FirebaseFirestore.instance
      .collection("info")
      .doc("DELORT_INFORMATION")
      .get();
  activeBuildVersion = appVersion["Build"];
}
