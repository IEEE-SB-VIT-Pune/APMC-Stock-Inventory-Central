import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:central/Screens/home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  // TextEditingController emailInputController;

  // TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  TextEditingController pwdInputController;
  FirebaseUser _firebaseUser;

  Future registerUser(
    String phone,
    BuildContext context,
  ) async {
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + phone,
        timeout: Duration(seconds: 120),
        verificationCompleted: (AuthCredential credential) {
          //Navigator.pop(context);
          print('In verificationCompleted');
          FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((result) async {
            print('Uid: ' + result.uid);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }).catchError((e) => print(e));
        },
        verificationFailed: (AuthException exception) {
          print('In verificationFailed');
          print(exception.message);
        },
        codeSent: codesent,
        codeAutoRetrievalTimeout: (String verificationId) {
          print('In codeAutoRetrievalTimeout');
          verificationId = verificationId;
          print(verificationId);
          print('TimeOut');
        });
  }

  codesent(String verificationId, [int forceResendingToken]) async {
    print('In codeSent');
    var _credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: _otpController.text.trim());
    FirebaseAuth.instance
        .signInWithCredential(_credential)
        .then((result) async {
      print('Uid:' + result.uid);
      _firebaseUser = result;

      // Navigator.of(context).pop();

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }).catchError((e) {
      print(e);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter Correct Passcode!'),
          );
        },
      );
      Timer(
          Duration(seconds: 1),
          () => {
                Navigator.of(context).pop(),
              });
    });
  }

  @override
  initState() {
    // emailInputController = new TextEditingController();
    _otpController = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            TextFormField(
              controller: _otpController,
              decoration: InputDecoration(labelText: 'passcode'),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
                child: Text('Login'),
                onPressed: () {
                  registerUser('1515151515', context);
                  if (_firebaseUser != null) {
                    _otpController = TextEditingController();
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //   builder: (BuildContext context) => HomePage(),
                    // ));
                  }
                })
          ],
        ),
      ),
    );
  }
}
