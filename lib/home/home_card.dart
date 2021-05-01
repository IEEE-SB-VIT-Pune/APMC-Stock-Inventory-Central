import 'package:flutter/material.dart';
import 'package:inventory_central/home/subunitPage.dart';

class branchCard extends StatefulWidget {
  final branchName;
  final managerName;
  final managerNo;
  final location;
  final int h;
  final int w;

  const branchCard(
      {Key key,
      this.branchName,
      this.managerName,
      this.managerNo,
      this.h,
      this.w,
      this.location})
      : super(key: key);

  @override
  _branchCardState createState() => _branchCardState();
}

class _branchCardState extends State<branchCard> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 1,
      ),
      height: h / 7,
      width: w - 20,
      child: Card(
        elevation: 2,
        color: Colors.white,
        child: ListTile(
          title: Text(
            '${widget.location}\n',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.managerName,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                ),
              ),
              Text(
                widget.managerNo,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => subPage1(
                        id: widget.branchName, location: widget.location)));
          },
        ),
      ),
    );

    // return Card(
    //   margin: EdgeInsets.only(top: 10.0, left: 10, right: 10),
    //   color: Color(0xFFE9E9E9),
    //   child: InkWell(
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: <Widget>[
    //           Text(
    //             widget.location,
    //             style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    //           ),
    //           SizedBox(height: 30),
    //           Text(
    //             widget.managerName,
    //             style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    //           ),
    //           Text(
    //             widget.managerNo,
    //             style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    //           )
    //         ],
    //       ),
    //     ),
    //     onTap: () {
    //       Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) => subPage1(
    //                   id: widget.branchName, location: widget.location)));
    //     },
    //   ),
    // );
  }
}
