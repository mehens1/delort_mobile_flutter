import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delorts/constants.dart';
import 'package:delorts/portal/quickReport.dart';
import 'package:delorts/termsandcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //formkey
  final _formKey = GlobalKey<FormState>();

  CollectionReference users = FirebaseFirestore.instance.collection("users");

  //auth
  final _auth = FirebaseAuth.instance;

  bool signupBtnState = true;

  //password visibility
  bool passVisibility = true;
  bool confirmPassVisibility = true;

  bool checkedValue = false;

  List<String> statesLive = [];

  //selected state
  String? _selectedState = "Select State First";
  var stateSelect, stateLGA;
  var setDefaultState = true, setDefaultStateLGA = true;

  //firstname
  final TextEditingController firstNameController = new TextEditingController();

  //lastname
  final TextEditingController lastNameController = new TextEditingController();

  //email
  final TextEditingController emailController = new TextEditingController();

  //phone
  final TextEditingController phoneController = new TextEditingController();

  //password
  final TextEditingController passwordController = new TextEditingController();

  //confirm password
  final TextEditingController confirmPasswordController =
      new TextEditingController();

  //date of birth
  final TextEditingController dateOfBirth = new TextEditingController();

  //date of birth
  final TextEditingController addressController = new TextEditingController();

  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dateOfBirth.dispose();
    addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///firstname
    final fname = TextFormField(
      controller: firstNameController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return "Firstname can't be empty!";
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.account_circle),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        hintText: "Firstname...",
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );

    ///lastname
    final lname = TextFormField(
      controller: lastNameController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return "Last Name can't be empty!";
        }

        return null;
      },
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.account_circle),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        hintText: "Last Name...",
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );

    //email
    final email = TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.email),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        hintText: "Email Address...",
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your Email Address!");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please enter a Valid Email Address");
        }
        return null;
      },
    );

    //phone
    final phone = TextFormField(
      controller: phoneController,
      textInputAction: TextInputAction.next,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.phone),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        hintText: "Phone Number...",
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Phone Number can't be empty";
        }

        if (value.length < 11) {
          return "Phone number not complete!";
        }
        ;

        return null;
      },
    );

    //password
    final password = TextFormField(
      obscureText: passVisibility,
      controller: passwordController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              passVisibility = !passVisibility;
            });
          },
          icon: Icon(passVisibility ? Icons.visibility : Icons.visibility_off),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        hintText: "Password...",
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      validator: (value) {
        RegExp regExp = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password required!");
        }
        if (!regExp.hasMatch(value)) {
          return ("Please enter a valid password  (Min. of 6 Character)");
        }
        return null;
      },
    );

    //confirm password
    final confirmPassword = TextFormField(
      obscureText: confirmPassVisibility,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              confirmPassVisibility = !confirmPassVisibility;
            });
          },
          icon: Icon(
              confirmPassVisibility ? Icons.visibility : Icons.visibility_off),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        hintText: "Confirm Password...",
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Confirm Password can't be empty!";
        }

        if (value != passwordController.text) {
          return "Password does not match!";
        }

        return null;
      },
    );

    //date of birth
    final dob = TextFormField(
      textInputAction: TextInputAction.next,
      readOnly: true,
      controller: dateOfBirth,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1940),
                lastDate: DateTime.now());

            if (pickedDate != null) {
              setState(() {
                dateOfBirth.text = DateFormat("dd-MM-yyyy").format(pickedDate);
              });
            }
          },
          icon: Icon(Icons.calendar_month),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        hintText: "Date of Birth...",
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return ("Date of Birth Needed!");
        }
        return null;
      },
    );

    var listOfStates = FirebaseFirestore.instance
        .collection('states')
        .orderBy("state")
        .snapshots();

    //liveStates drop down
    final states = StreamBuilder<QuerySnapshot>(
      stream: listOfStates,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) if (setDefaultState) {
          stateSelect = snapshot.data?.docs[0].get('state');
          debugPrint('setDefault state: $stateSelect');
        }
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: DropdownButton(
            hint: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Select State",
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ),
            isExpanded: true,
            value: stateSelect,
            items: snapshot.data?.docs.map((value) {
              return DropdownMenuItem(
                value: value.get('state'),
                child: Text('${value.get('state')}'),
              );
            }).toList(),
            onChanged: (value) {
              setState(
                () {
                  debugPrint('state selected: $value');
                  stateSelect = value;
                  setDefaultState = false;
                  setDefaultStateLGA = true;
                },
              );
            },
          ),
        );
      },
    );

    //lga selection
    final liveStatesLGA = stateSelect != null
        ? StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('lga')
                .where('state', isEqualTo: stateSelect)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                debugPrint('snapshot status: ${snapshot.error}');
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Text(
                    'State Not Selected Yet',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                );
              }

              if (setDefaultStateLGA) {
                var stateLGA_check = snapshot.data?.docs[0].get('lga');

                stateLGA_check != null
                    ? stateLGA = snapshot.data?.docs[0].get('lga')
                    : stateLGA = "";
              }
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: DropdownButton(
                  isExpanded: true,
                  value: stateLGA,
                  items: snapshot.data?.docs.map((value) {
                    //debugPrint('state select: ${value.get('lga')}');
                    return DropdownMenuItem(
                      value: value.get('lga'),
                      child: Text(
                        '${value.get('lga')}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    debugPrint('L.G.A. selected: $value');
                    setState(
                      () {
                        // Selected value will be stored
                        stateLGA = value;
                        // Default dropdown value won't be displayed anymore
                        setDefaultStateLGA = false;
                      },
                    );
                  },
                ),
              );
            },
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              "For LGA Options, Select State First",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );

    ///Residential Address
    final address = TextFormField(
      controller: addressController,
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return "Residential Contact Address!";
        }

        return null;
      },
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.location_city),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.fromLTRB(15, 20, 5, 20),
        hintText: "Residencial Address...",
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5),
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

    //terms and condition checkbox
    final tandc = Checkbox(
        tristate: false,
        shape: CircleBorder(),
        side: BorderSide(
          color: Colors.white,
          width: 2,
        ),
        checkColor: Colors.white,
        value: checkedValue,
        onChanged: (newValue) {
          setState(() {
            checkedValue = !checkedValue;
          });
        });

    //signup button
    final signUpButton = Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      color: kSecondaryColor,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          if (stateSelect == null) {}
          //signIn(emailController.text, passwordController.text);
          //Fluttertoast.showToast(msg: internetStatus);
          //print(ietms);
          signUp();
        },
        child: Text(
          "Register",
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
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
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
                    height: 30,
                  ),
                  Text(
                    "Sign Up!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 30),
                  fname,
                  SizedBox(height: 10),
                  lname,
                  SizedBox(height: 10),
                  email,
                  SizedBox(height: 10),
                  phone,
                  SizedBox(height: 10),
                  password,
                  SizedBox(height: 10),
                  confirmPassword,
                  SizedBox(height: 10),
                  dob,
                  SizedBox(height: 10),
                  states,
                  SizedBox(height: 10),
                  liveStatesLGA,
                  SizedBox(height: 10),
                  address,
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      tandc,
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TermsAndCondition(),
                            ),
                          );
                        },
                        child: Text(
                          "Terms & Condition Apply",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  signupBtnState ? signUpButton : loadingProcessBar,
                  SizedBox(height: 30)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //signUp function
  Future signUp() async {
    if (_formKey.currentState!.validate()) {
      if (stateSelect == null) {
        Fluttertoast.showToast(msg: "State of Residence needed!");
      } else if (stateLGA == null) {
        Fluttertoast.showToast(msg: "Atleast 1 LGA needed!");
      } else {
        if (checkedValue != false) {
          setState(() {
            signupBtnState = !signupBtnState;
          });

          try {
            await _auth
                .createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text)
                .then((uid) {
              addNewUserData(
                firstNameController.text.trim(),
                lastNameController.text.trim(),
                emailController.text.trim(),
                phoneController.text.trim(),
                dateOfBirth.text.trim(),
                stateSelect.trim(),
                stateLGA.trim(),
                addressController.text.trim(),
              );

              Fluttertoast.showToast(msg: "Sign Up Successful!");

              if (FirebaseAuth.instance.currentUser == null) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              } else {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => QuickReport()),
                );
              }
            });
          } catch (e) {
            setState(() {
              signupBtnState = !signupBtnState;
            });

            var errorMsg = e.toString();
            errorMsg = errorMsg.substring(errorMsg.indexOf(' ') + 1);

            Fluttertoast.showToast(
                msg: errorMsg,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.SNACKBAR);
          }
        } else {
          Fluttertoast.showToast(msg: "Accept Terms and Condition to proceed!");
        }
      }
    }
  }

  //adding new signed up user
  Future addNewUserData(
    String _firstname,
    String _lastname,
    String _email,
    String _phoneNumber,
    String _dob,
    String _state,
    String _lga,
    String _address,
  ) async {
    await FirebaseFirestore.instance.collection("users").add({
      'first name': _firstname,
      'last name': _lastname,
      'email name': _email,
      'phone number': _phoneNumber,
      'date of birth': _dob,
      'state': _state,
      'local government': _lga,
      'address': _address,
    });
  }
}
