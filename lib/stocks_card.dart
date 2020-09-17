import 'package:central/subunitPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class stockCard extends StatefulWidget {

  final itemName;
  final itemQuantity;
  final int h;
  final int w;

  const stockCard({Key key, this.itemName, this.itemQuantity, this.h, this.w}) : super(key: key);



  @override
  _stockCardState createState() => _stockCardState();
}

class _stockCardState extends State<stockCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      
      margin:EdgeInsets.only(top: 10.0,left: 10,right:10),
      

      color:Color(0xFFE9E9E9),

      child: InkWell(
              child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0),

          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.stretch,

            
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height:20),
                  Container(
                    width:70,
                    child:Text(widget.itemName,style: TextStyle(fontSize:17,fontWeight: FontWeight.bold),),
                  ),
                  
                  SizedBox(height:20),
                ],
              ),
              

              SizedBox(width:130),

              Text(widget.itemQuantity+" Kg",style: TextStyle(fontSize:17,fontWeight: FontWeight.normal),),
            ],
          ),
        ),

        onTap: (){

        },

      ),
      
    );
  }
}