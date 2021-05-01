import 'package:flutter/material.dart';

class stockCard extends StatefulWidget {
  final itemName;
  final itemQuantity;
  final int h;
  final int w;

  const stockCard({Key key, this.itemName, this.itemQuantity, this.h, this.w})
      : super(key: key);

  @override
  _stockCardState createState() => _stockCardState();
}

class _stockCardState extends State<stockCard> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: h / 8,
          margin: EdgeInsets.only(left: 10, right: 10),
          // decoration: BoxDecoration(
          //   color: Colors.lightGreen[50],
          //   borderRadius: BorderRadius.all(Radius.circular(20)),
          // ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.stretch,

              children: <Widget>[
                Container(
                  width: w * 0.5,
                  child: Text(
                    widget.itemName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: w * 0.2,
                  height: 30,
                  child: Center(
                    child: Text(
                      widget.itemQuantity + " kg",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // SizedBox(
        //   height: 10,
        // ),
        Divider(
          thickness: 2.5,
        ),
      ],
    );
  }
}
