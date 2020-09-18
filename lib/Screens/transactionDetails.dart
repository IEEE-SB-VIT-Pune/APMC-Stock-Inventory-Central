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

  getItems(List<Map> item) {}

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
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                text: "   Customer Name:   ",
                children: <TextSpan>[
                  TextSpan(
                    text: widget._transaction.customerName,
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                text: "   Payment Mode:    ",
                children: <TextSpan>[
                  TextSpan(
                    text: widget._transaction.paymentMode,
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                text: "   Phone Number:    ",
                children: <TextSpan>[
                  TextSpan(
                    text: widget._transaction.phoneNumber,
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                text: "   Time:    ",
                children: <TextSpan>[
                  TextSpan(
                    text: DateTime.fromMicrosecondsSinceEpoch(
                            widget._transaction.time.microsecondsSinceEpoch)
                        .toString(),
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text('Item', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text('Quantity',  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            color: Colors.black,
            height: 3,
          ),
          (widget._transaction.items['1'] != null)
              ? Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text('Item 1'),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(widget._transaction.items['1'] ?? '0'),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          (widget._transaction.items['2'] != null)
              ? Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text('Item 2'),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(widget._transaction.items['2'] ?? '0'),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          (widget._transaction.items['3'] != null)
              ? Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text('Item 3'),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(widget._transaction.items['3'] ?? '0'),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          (widget._transaction.items['4'] != null)
              ? Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text('Item 4'),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(widget._transaction.items['4'] ?? '0'),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          // Text(widget._transaction.items['1'] ?? '0'),
          // Text(widget._transaction.items['2'] ?? '0'),
          // Text(widget._transaction.items['3'] ?? '0'),
          // Text(widget._transaction.items['4'] ?? '0'),
        ],
      ),
    );
  }
}
