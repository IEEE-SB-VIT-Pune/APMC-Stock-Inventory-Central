import 'package:central/stocks_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'authorize.dart';
import 'home_card.dart';

class addStock extends StatefulWidget {

  final String id2;

  const addStock({Key key, this.id2}) : super(key: key);



  @override
  _addStockState createState() => _addStockState();
}

class _addStockState extends State<addStock> {

  String dropdownValue ;
  int qt=0;
  int k;
  var d1;


  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

      var w= MediaQuery.of(context).size.width;
      var h= MediaQuery.of(context).size.height;
      print(w);
      print(h);
  
    return Scaffold(

       

      resizeToAvoidBottomInset: false,
      
      appBar: AppBar(title: Text("",style: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.bold),),backgroundColor: Color(0xFFFF7979),
              
                
      ),

      body: Builder(builder:(context)=>
               Column(
          children: <Widget>[

            SizedBox(height: h*0.1024,),
            Row(
              children: <Widget>[
                SizedBox(width:w*0.1703163),
                Text(''' Item
Name:''',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),

              SizedBox(width:w*0.04866),
              //-----------------------------------------------------------------
                Container(
                  width:w*0.3406,
                    decoration: BoxDecoration(
                      color: Color(0xFFEAE1FF),
                    border: Border.all(
                      color: Color(0xFFEAE1FF),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),

                         child: Center(
                          child: DropdownButton<String>(
                            hint: dropdownValue==null? Text('Select item'):Text(dropdownValue),


                          value: dropdownValue,
                          icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                          iconSize: 40,
                          
                          elevation: 50,
                          style: TextStyle(color: Colors.black,fontSize: 19),
                          dropdownColor: Color(0xFFEAE1FF),
    
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['potato', 'onion', 'ginger', 'garlic']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
    ),
                                ),
                ),
              
            //------------------------------------------------------------
            ],
            ),




            SizedBox(height:  h*0.1024,),
            Row(
              children: <Widget>[
                SizedBox(width:w*0.1703),
                Text(''' Add
Quantity:''',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),

              SizedBox(width:20),
              //-----------------------------------------------------------------
                Container(

                  decoration: BoxDecoration(
                      color: Color(0xFFEAE1FF),
                    border: Border.all(
                      color: Color(0xFFEAE1FF),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),

                    width: 80,
                    height: 40,
                    child: TextFormField(
                    textAlign: TextAlign.center,
                   
                    keyboardType: TextInputType.number,
                    inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                    style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold),
                    controller: myController,
                    
                    
                  decoration: InputDecoration(
                    
                  ),
                ),
                              ),
              Container(
                  height: 40,
                child: Center(child: Text(" Kg",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
                ),
              
            //------------------------------------------------------------


            InkWell(
              child: Container(
              ),
            ),
            ],

            ),

            SizedBox(height:h*0.1756),

            InkWell(
                        child: Center(
                child: Container(
                  height:50,
                  width:100,
                  color: Color(0xFFE9E9E9),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0),
                                    child: FittedBox(
                      
                    fit: BoxFit.contain,
                    child: Text("ADD"),
                ),
                  ),
                ),
              ),


              onTap: (){

                if(dropdownValue==null)
                {
                  Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Select the item"),
                ));
                }
                else if(myController.text=="")
                {
                  Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Enter the quantity"),
                ));
                }

                else
                {
                  var myInt = int.parse(myController.text);
                  
                 
                        Firestore.instance
                      .collection(widget.id2)
                      .where("itemName", isEqualTo: dropdownValue)
                      .getDocuments()
                      .then((value) {
                        value.documents.forEach((result) {
                          k=(result["itemCount"]);                         
                          d1=(result.documentID);

                             Firestore.instance
                            .collection(widget.id2)
                            .document(d1)
                            .updateData({"itemCount": (myInt+k)}).then((_) {
                            print("success!");
                            });
                        });
                      });

                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Stock Added Successfully !"),
                      ));


                    Navigator.pop(context);


                }
              },
            ),



          ],
        ),
      ),
      
    );
  }
}