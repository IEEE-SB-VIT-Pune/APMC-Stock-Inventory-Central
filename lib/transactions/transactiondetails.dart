import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_central/authorize.dart';
import 'package:inventory_central/transactions/transaction.dart';

class TransactionDetails extends StatefulWidget {
  Transactions _transaction;

  TransactionDetails(this._transaction);

  @override
  _TransactionDetailsState createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  getItems(List<Map> item) {}
  String month;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    switch (widget._transaction.time.toDate().toString().substring(5, 7)) {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff57c89f),
        title: Text('Transaction Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(
                color: Colors.green[100],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text: "Customer Name: ",
                    children: <TextSpan>[
                      TextSpan(
                        text: widget._transaction.customerName == ''
                            ? 'None'
                            : widget._transaction.customerName,
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.green[100],
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text: "Phone Number: ",
                    children: <TextSpan>[
                      TextSpan(
                        text: widget._transaction.phoneNumber == ''
                            ? 'None'
                            : widget._transaction.phoneNumber,
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.green[100],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text: "Payment Mode: ",
                    children: <TextSpan>[
                      TextSpan(
                        text: widget._transaction.paymentMode == ''
                            ? 'None'
                            : widget._transaction.paymentMode,
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.green[100],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text: "Occupation: ",
                    children: <TextSpan>[
                      TextSpan(
                        text: widget._transaction.occupation == ''
                            ? 'None'
                            : widget._transaction.occupation,
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.green[100],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text: "Date: ",
                    children: <TextSpan>[
                      TextSpan(
                        text: widget._transaction.time
                                    .toDate()
                                    .toString()
                                    .substring(8, 9) ==
                                '0'
                            ? '${widget._transaction.time.toDate().toString().substring(9, 10)} '
                            : '${widget._transaction.time.toDate().toString().substring(8, 10)} ',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: '$month, ',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text:
                            '${widget._transaction.time.toDate().toString().substring(0, 4)}',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.green[100],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    text: "Time: ",
                    children: <TextSpan>[
                      TextSpan(
                        text: DateFormat.jm()
                            .format(DateTime.parse(
                                widget._transaction.time.toDate().toString()))
                            .toString(),
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),

              Divider(
                color: Colors.green[100],
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    //fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Divider(
              //   color: Colors.black,
              //   height: 16,
              // ),

              Table(
                border: TableBorder.symmetric(
                    inside: BorderSide(
                      color: Colors.grey[300],
                    ),
                    outside: BorderSide(color: Colors.grey, width: 2)),
                children: [
                  TableRow(children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Item',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Quantity',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ]),
                  (widget._transaction.items['Potato (बटाटा)'] != null)
                      ? TableRow(
                          children: [
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Potato (बटाटा)'),
                            )),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    '${widget._transaction.items['Potato (बटाटा)']} kg' ??
                                        '0'),
                              ),
                            ),
                          ],
                        )
                      : TableRow(children: [Container(), Container()]),
                  (widget._transaction.items['Garlic (लसूण)'] != null)
                      ? TableRow(
                          children: [
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Garlic (लसूण)'),
                            )),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    '${widget._transaction.items['Garlic (लसूण)']} kg' ??
                                        '0'),
                              ),
                            ),
                          ],
                        )
                      : TableRow(children: [Container(), Container()]),
                  (widget._transaction.items['Onion (कांदा)'] != null)
                      ? TableRow(
                          children: [
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Onion (कांदा)'),
                            )),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    '${widget._transaction.items['Onion (कांदा)']} kg' ??
                                        '0'),
                              ),
                            ),
                          ],
                        )
                      : TableRow(children: [Container(), Container()]),
                  (widget._transaction.items['Ginger (आले)'] != null)
                      ? TableRow(
                          children: [
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Ginger (आले)'),
                            )),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    '${widget._transaction.items['Ginger (आले)']} kg' ??
                                        '0'),
                              ),
                            ),
                          ],
                        )
                      : TableRow(children: [Container(), Container()]),
                ],
              ),

              // (widget._transaction.items['Potato (बटाटा)'] != null)
              //     ? Container(
              //         margin: const EdgeInsets.all(8.0),
              //         child: Row(
              //           children: [
              //             Text('Potato (बटाटा)'),
              //             Text(
              //                 '${widget._transaction.items['Potato (बटाटा)']}' ??
              //                     '0'),
              //           ],
              //         ),
              //       )
              //     : Container(),
              // (widget._transaction.items['Garlic (लसूण)'] != null)
              //     ? Container(
              //         margin: const EdgeInsets.all(8.0),
              //         child: Row(
              //           children: [
              //             Text('Garlic (लसूण)'),
              //             Text(
              //                 '${widget._transaction.items['Garlic (लसूण)']}' ??
              //                     '0'),
              //           ],
              //         ),
              //       )
              //     : Container(),
              // (widget._transaction.items['2'] != null)
              //     ? Container(
              //         margin: const EdgeInsets.all(8.0),
              //         child: Row(
              //           children: [
              //             Expanded(
              //               child: Center(
              //                 child: Text('Item 2'),
              //               ),
              //             ),
              //             Expanded(
              //               child: Center(
              //                 child:
              //                     Text(widget._transaction.items['2'] ?? '0'),
              //               ),
              //             ),
              //           ],
              //         ),
              //       )
              //     : Container(),
              // (widget._transaction.items['3'] != null)
              //     ? Container(
              //         margin: const EdgeInsets.all(8.0),
              //         child: Row(
              //           children: [
              //             Expanded(
              //               child: Center(
              //                 child: Text('Item 3'),
              //               ),
              //             ),
              //             Expanded(
              //               child: Center(
              //                 child:
              //                     Text(widget._transaction.items['3'] ?? '0'),
              //               ),
              //             ),
              //           ],
              //         ),
              //       )
              //     : Container(),
              // (widget._transaction.items['4'] != null)
              //     ? Container(
              //         margin: const EdgeInsets.all(8.0),
              //         child: Row(
              //           children: [
              //             Expanded(
              //               child: Center(
              //                 child: Text('Item 4'),
              //               ),
              //             ),
              //             Expanded(
              //               child: Center(
              //                 child:
              //                     Text(widget._transaction.items['4'] ?? '0'),
              //               ),
              //             ),
              //           ],
              //         ),
              //       )
              //     : Container(),
              // Text(widget._transaction.items['1'] ?? '0'),
              // Text(widget._transaction.items['2'] ?? '0'),
              // Text(widget._transaction.items['3'] ?? '0'),
              // Text(widget._transaction.items['4'] ?? '0'),
            ],
          ),
        ),
      ),
    );
  }
}
