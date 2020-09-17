import 'package:central/stocks_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_stock.dart';
import 'authorize.dart';
import 'home_card.dart';

class subPage1 extends StatefulWidget {

  final id;
  
  

  const subPage1({Key key, this.id}) : super(key: key);

  @override
  _subPageState createState() => _subPageState();
}

class _subPageState extends State<subPage1> {
  @override
  Widget build(BuildContext context) {
    String iid=widget.id;
    print(iid);
    return Scaffold(
      
      appBar: AppBar(title: Text(widget.id,style: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.bold),),backgroundColor: Color(0xFFFF7979),
              
                
      ),

      body: DefaultTabController(
        
        
        length: 2,
        child: Scaffold(
          appBar: TabBar(
            indicatorColor: Colors.grey,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(child: Text("Stocks",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                Tab(child:Text("Transactions",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                
              ],
            ),
            
          
          body: TabBarView(
            
            children: [

              
              Scaffold(
                           body: Column(
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
                        return new Text('Loading...');
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
                  ]
                ),


                floatingActionButton: FloatingActionButton(
                  onPressed: () 
                  {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>addStock(id2: widget.id,)));
                  },
                  
                  
                  child: Icon(Icons.add),
                  backgroundColor: Color(0xFFFF7979),
                ),
                        ),
                              


              Container(
                child: Center(
                  child:Text("Transactions")
                ),
              ),
              
            ],

            
          ),
          
        ),
      ),

    );
  }
}