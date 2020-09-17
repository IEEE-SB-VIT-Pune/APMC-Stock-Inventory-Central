
import 'package:central/subunitPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class branchCard extends StatefulWidget {

  final branchName;
  final managerName;
  final managerNo;
  final int h;
  final int w;

  const branchCard({Key key, this.branchName, this.managerName, this.managerNo,this.h,this.w}) : super(key: key);

  @override
  _branchCardState createState() => _branchCardState();
}

class _branchCardState extends State<branchCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      
      margin:EdgeInsets.only(top: 10.0,left: 10,right:10),
      

      color:Color(0xFFE9E9E9),

      child: InkWell(
              child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(widget.branchName,style: TextStyle(fontSize:17,fontWeight: FontWeight.bold),),

              SizedBox(height:30),

              Text(widget.managerName,style: TextStyle(fontSize:17,fontWeight: FontWeight.bold),),
              Text(widget.managerNo,style: TextStyle(fontSize:17,fontWeight: FontWeight.bold),)
            ],
          ),
        ),

        onTap: ()
        {
                Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => subPage1(id:widget.branchName,)));

        },


      ),
      
    );
  }
}