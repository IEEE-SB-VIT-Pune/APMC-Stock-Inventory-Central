import 'package:central/Models/transaction.dart';
import 'package:central/Screens/authorize.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransactionDetails extends StatefulWidget {
  Transactions _transaction;

  TransactionDetails(this._transaction);

  @override
  _TransactionDetailsState createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  Future<void> _logout() async {
    /// Method to Logout the `FirebaseUser` (`_firebaseUser`)
    try {
      // signout code
      await FirebaseAuth.instance.signOut();

      setState(() {});
    } catch (e) {
      setState(() {});
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFFF7979),
          actions: [
            RaisedButton(
                color: Color(0xFFFF7979),
                child: Text(
                  'Logout',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                onPressed: () {
                  _logout();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage(),
                  ));
                }),
          ],
          title: Text('Admin App'),
        ),
        body: Column(
          children: [
            Text(widget._transaction.customerName),
            Text(widget._transaction.paymentMode),
            Text(widget._transaction.phoneNumber),
            Text(DateTime.fromMicrosecondsSinceEpoch(
                                            widget._transaction.time
                                                .microsecondsSinceEpoch)
                                        .toString()),
            Text(widget._transaction.items['1'] ?? '0'),
            Text(widget._transaction.items['2'] ?? '0'),
            Text(widget._transaction.items['3'] ?? '0'),
            Text(widget._transaction.items['4'] ?? '0'),
          ],
        ),
    );
  }
}
