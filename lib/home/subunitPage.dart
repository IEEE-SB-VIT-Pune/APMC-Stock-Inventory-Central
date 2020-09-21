import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_central/authorize.dart';
import 'package:inventory_central/transactions/transaction.dart';
import 'package:inventory_central/transactions/transactiondetails.dart';
import 'package:inventory_central/stocks/add_stock.dart';
import 'package:inventory_central/stocks/stocks_card.dart';
import 'package:intl/intl.dart';

class subPage1 extends StatefulWidget {
  final id;
  final location;

  const subPage1({Key key, this.id, this.location}) : super(key: key);

  @override
  _subPageState createState() => _subPageState();
}

class _subPageState extends State<subPage1> {
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
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    String iid = widget.id + "_stocks";
    //print(iid);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.location,
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  size: 35,
                ),
                onPressed: () {
                  _logout();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage(),
                    ),
                  );
                },
              ),
            ),
          ],
          //backgroundColor: Color(0xFFFF7979),
          backgroundColor: Color(0xff57c89f),
          bottom: PreferredSize(
            preferredSize: Size(40, 40),
            child: TabBar(
              indicatorWeight: 5,
              //indicatorColor: Color(0xFFAF2323),
              indicatorColor: Color(0xff8df0a9),
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
            Column(
              children: <Widget>[
                Flexible(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection(iid).snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return new Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        default:
                          return new ListView(
                            //shrinkWrap: true,
                            children: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                              return new stockCard(
                                itemName: document['itemName'],
                                itemQuantity: document['itemCount'].toString(),
                              );
                            }).toList(),
                          );
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => addStock(
                                      id2: widget.id,
                                    )));
                      },
                      child: Icon(Icons.add),
                      //backgroundColor: Color(0xFFFF7979),
                      backgroundColor: Color(0xff57c89f),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection(widget.id + '_Transactions')
                      .orderBy("time", descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      default:
                        return ListView(
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            print(document.data);
                            String date_ = document['time'].toDate().toString();
                            String month = '';
                            switch (date_.substring(5, 7)) {
                              case '01':
                                month = 'January';
                                break;
                              case '02':
                                month = 'February';
                                break;
                              case '03':
                                month = 'March';
                                break;
                              case '04':
                                month = 'April';
                                break;
                              case '05':
                                month = 'May';
                                break;
                              case '06':
                                month = 'June';
                                break;
                              case '07':
                                month = 'July';
                                break;
                              case '08':
                                month = 'August';
                                break;
                              case '09':
                                month = 'September';
                                break;
                              case '10':
                                month = 'October';
                                break;
                              case '11':
                                month = 'November';
                                break;
                              case '12':
                                month = 'December';
                                break;
                            }
                            return Container(
                              height: h / 8,
                              margin: const EdgeInsets.all(8.0),
                              child: Material(
                                color: Color(0xFFE9E9E9),
                                borderRadius: BorderRadius.circular(15.0),
                                elevation: 2,
                                child: ListTile(
                                  title: Text(
                                    document['Name'] == ''
                                        ? 'Name: None'
                                        : 'Name: ${document['Name']}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          date_.substring(8, 9) == '0'
                                              ? Text(
                                                  '${date_.substring(9, 10)} ')
                                              : Text(
                                                  '${date_.substring(8, 10)} '),
                                          Text('$month, '),
                                          Text(date_.substring(0, 4)),
                                        ],
                                      ),
                                      Text(new DateFormat.jm()
                                          .format(DateTime.parse(date_))),
                                    ],
                                  ),
                                  onTap: () async {
                                    print(document.data);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            TransactionDetails(
                                          Transactions(
                                            document['Payment Option'] ??
                                                'None',
                                            document['Name'] ?? 'None',
                                            document['Phone Number'] ?? 'None',
                                            document['time'] ?? 'Time',
                                            document['items'] ?? 'items',
                                            document['occupation'] ?? 'None',
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
