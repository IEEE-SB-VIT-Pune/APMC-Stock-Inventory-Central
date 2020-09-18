import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices{

 final firestoreInstance = Firestore.instance;
  
  // void getTransactions(String shopName) async {
  //   List data;
  //   await firestoreInstance.collection(shopName + '_Transactions').getDocuments().then((querySnapshot) {
  //     querySnapshot.documents.forEach((element) { 
  //       print(element.data);
  //       data.add(element.data);
  //     });
  //   }).then((value) => print('Data: ' + value));
  // }
}