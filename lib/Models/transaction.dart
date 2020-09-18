import 'package:flutter/cupertino.dart';

class Transactions{
  String customerName, phoneNumber, paymentMode;
  var time, items;

  Transactions(this.customerName, @required this.paymentMode, this.phoneNumber, this.time, this.items);
}