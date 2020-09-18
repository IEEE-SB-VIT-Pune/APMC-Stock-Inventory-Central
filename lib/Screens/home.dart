import 'package:central/Screens/shopInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:central/Screens/authorize.dart';

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
    return ShopInfo();
    // return DefaultTabController(
    //         length: 2,
    //       child: Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: Color(0xFFFF7979),
    //       actions: [
    //         RaisedButton(
    //           color: Color(0xFFFF7979),
    //             child: Text('Logout'),
    //             onPressed: () {
    //               _logout();
    //               Navigator.of(context).pushReplacement(MaterialPageRoute(
    //                 builder: (BuildContext context) => LoginPage(),
    //               ));
    //             }),
    //       ],
    //       title: Text('Admin App'),
    //       bottom: PreferredSize(
    //         preferredSize: Size(40, 40),
    //                   child: TabBar(
    //           tabs: [
    //             Container(
    //               height: 30,
    //               child: Text('Stocks', style: TextStyle(fontSize: 18),),),
    //             Container(
    //               height: 30,
    //               child: Text('Transactions', style: TextStyle(fontSize: 18),),),
    //           ],
    //           ),
    //       ),
    //     ),
    //     body: TabBarView(
          
    //       children: [
    //         Text('Stocks'),
    //         Text('Transactions'),
    //       ],
    //       ),
    //   ),
    // );
  }
}
