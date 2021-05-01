import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_central/UI/animation.dart';
import 'package:inventory_central/UI/decoration.dart';
import 'package:inventory_central/home/home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _otpController = TextEditingController();
  TextEditingController pwdInputController;
  FirebaseUser _firebaseUser;

  bool loader = false;

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
        barrierDismissible: false,
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
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/login_bg.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            WavyHeaderImage(
              color1: Color(0xff57c89f),
              color2: Color(0xff57c89f),
              color3: Color(0xff8df0a9),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: AnimatedWave(
                height: 160,
                speed: 0.8,
              ),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: AnimatedWave(
                height: 100,
                speed: 0.8,
                offset: pi,
              ),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: AnimatedWave(
                height: 200,
                speed: 0.8,
                offset: pi / 2,
              ),
            ),
            Positioned(
              left: ((w * 0.15) / 2),
              top: h * 0.31,
              child: FadeAnimation(
                1.0,
                Container(
                  height: h / 2,
                  width: w * 0.85,
                  decoration: new BoxDecoration(
                    boxShadow: [
                      //background color of box
                      BoxShadow(
                        color: Colors.blueGrey[200],
                        blurRadius: 15.0, // soften the shadow
                        spreadRadius: 5.0, //extend the shadow
                        offset: Offset(
                          0.0, // Move to right 10  horizontally
                          10.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                      bottomRight: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                      bottomLeft: const Radius.circular(40.0),
                      topLeft: const Radius.circular(40.0),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        loader
                            ? SizedBox(
                                height: 25,
                              )
                            : SizedBox(
                                height: 65,
                              ),
                        loader
                            ? Image.asset(
                                'assets/images/loader.gif',
                                height: 90,
                                width: 90,
                              )
                            : Container(),
                        Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 34,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: w * 0.7,
                          child: TextFormField(
                            // key: widget.key,
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            controller: _otpController,
                            // validator: widget.validator,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(color: Colors.grey[400]),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(color: Colors.grey[400]),
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              labelText: 'Passcode',
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 13.0, horizontal: 20.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 45,
                          width: w / 3,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(23.0),
                                side: BorderSide(color: Colors.white)),
                            //color: Color(0xff57c89f),
                            color: Colors.black87,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {
                              setState(() {
                                loader = true;
                              });
                              registerUser('2121212121', context);
                              if (_firebaseUser != null) {
                                _otpController = TextEditingController();
                              }
                            },
                            child: Text('Login'),
                          ),
                        ),
                        SizedBox(
                          height: 120,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
