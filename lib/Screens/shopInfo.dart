import 'package:central/Models/transaction.dart';
import 'package:central/Screens/authorize.dart';
import 'package:central/Screens/transactionDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShopInfo extends StatefulWidget {
  @override
  _ShopInfoState createState() => _ShopInfoState();
}

class _ShopInfoState extends State<ShopInfo> {
  Transactions _transaction;

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          bottom: PreferredSize(
            preferredSize: Size(40, 40),
            child: TabBar(
              indicatorWeight: 5,
              indicatorColor: Color(0xFFAF2323),
              tabs: [
                Container(
                  height: 30,
                  child: Text(
                    'Stocks',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  height: 30,
                  child: Text(
                    'Transactions',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Text('Stocks'),
            Center(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('s1' + '_Transactions')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Text('Loading....');
                      default:
                        return ListView(
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            print(document.data);
                            return Container(
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: Color(0xFFE9E9E9),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: InkWell(
                                child: ListTile(
                                  title: Text(document['Name']),
                                  trailing: Container(
                                    width: 100,
                                    child: Text(
                                      DateTime.fromMicrosecondsSinceEpoch(
                                              document['time']
                                                  .microsecondsSinceEpoch)
                                          .toString(),
                                    ),
                                  ),
                                  onLongPress: () {
                                    print('Delete');
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        content: Text('Delete the transactions'),
                                        actions: [
                                          FlatButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                             Navigator.of(context).pop();
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('Delete'),
                                            onPressed: () {
                                            print('Deleting');
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  onTap: () {
                                    print(document.data);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                              TransactionDetails(
                                          Transactions(
                                            document['Name'] ?? 'Name',
                                            document['Payment Option'] ??
                                                'Payment Mode',
                                            document['Phone Number'] ??
                                                'Phone Number',
                                            document['time'] ?? 'Time',
                                            document['items'] ?? 'items',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                        );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
