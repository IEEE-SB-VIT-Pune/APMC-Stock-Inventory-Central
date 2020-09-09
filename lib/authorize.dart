import 'package:flutter/material.dart';
import 'package:central/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  String _status = '';

  AuthCredential _phoneAuthCredential;
  String _verificationId;
  int _code;

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
        codeSent: (String verificationId, [int forceResendingToken]) {
          print('In codeSent');
          print(phone);

          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (contextDialog) => Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Container(
                    height: 250,
                    width: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter Passcode',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            // autofocus: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[100],
                              hintText: '* * * * * *',
                              contentPadding:
                                  new EdgeInsets.symmetric(horizontal: 20.0),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            controller: _otpController,
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: 300.0,
                            child: RaisedButton(
                              onPressed: () async {
                                var _credential =
                                    PhoneAuthProvider.getCredential(
                                        verificationId: verificationId,
                                        smsCode: _otpController.text.trim());
                                FirebaseAuth.instance
                                    .signInWithCredential(_credential)
                                    .then((result) async {
                                  print('Uid:' + result.uid);
                                  _firebaseUser = result;

                                  Navigator.of(contextDialog).pop();

                                  // Navigator.of(context).pop();

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                }).catchError((e) {
                                  print(e);
                                });
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Color(0xff57c89f),
                            ),
                          )
                        ],
                      ),
                    ),
                  )));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('In codeAutoRetrievalTimeout');
          verificationId = verificationId;
          print(verificationId);
          print('TimeOut');
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
            // TextFormField(
            //   controller: _otpController,
            //   decoration: InputDecoration(labelText: 'passcode'),
            // ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
                child: Text('Login'),
                onPressed: () {
                  registerUser('1212121212', context);
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
