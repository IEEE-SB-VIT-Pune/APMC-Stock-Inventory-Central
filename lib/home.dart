import 'package:central/home_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:central/authorize.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseUser currentUser;

  @override
  initState() {
    getCurrentUser();

    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

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

    return Scaffold(

       appBar: AppBar(title: Text("",style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),),backgroundColor: Color(0xFFFF7979),
              
                  
                  iconTheme: new IconThemeData(color: Colors.black),
                 actions: <Widget>[
                   Padding(
                      padding: EdgeInsets.only(right: 20.0),
                          child: GestureDetector(
                              onTap: () {
                                _logout();
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (BuildContext context) => LoginPage(),
                                    ));
                              },
                                 child: Icon(
                                      Icons.exit_to_app,size: 35,
                          ),
                       )
                     ),
                 ],
      ),


      body: Column(

       
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.grey,
                  ),
                  margin:EdgeInsets.only(top: 10.0,left: 10,right:10),
                  height: 200,
                  
                ),
                
                
                Flexible(
            
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('subunits').snapshots(),
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
                        return new branchCard(
                          
                          branchName: document['id'],
                          managerName: document['managerName'],
                          managerNo: document['managerNo'],
                        );
                      }).toList(),
                    );
                }
              },
            ),
            ),


              ],
      ),
    );
  }
}
