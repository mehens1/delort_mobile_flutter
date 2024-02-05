import 'package:delorts/login.dart';
import 'package:delorts/portal/quickReport.dart';
import 'package:firebase_auth/firebase_auth.dart';

checkUserLoggedin() {
  FirebaseAuth.instance.currentUser == null ? LoginPage() : QuickReport();
}
