import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class addStock extends StatefulWidget {
  final String id2;

  const addStock({Key key, this.id2}) : super(key: key);

  @override
  _addStockState createState() => _addStockState();
}

class _addStockState extends State<addStock> {
  //Map<String, TextEditingController> _productController = {};
  Map<String, String> selectedItems = {};
  int itemsCount = 0;
  List<String> ll = [null, null, null, null];
  List<TextEditingController> _productController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final myController = TextEditingController();

  bool status;

  bool condition;
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text('Entry'),
          backgroundColor: Color(0xff57c89f),
        ),
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: h / 10,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Text(
                            'Item',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Text(
                            'Quantity',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Container(
                            width: 150,
                            height: 35,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[300],
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            padding: const EdgeInsets.only(left: 8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: ll[0] == null
                                    ? Text('Select')
                                    : Text(
                                        ll[0],
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                value: ll[0],
                                items: [
                                  DropdownMenuItem(
                                    child: Text('Onion (कांदा)'),
                                    value: 'Onion (कांदा)',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Potato (बटाटा)'),
                                    value: 'Potato (बटाटा)',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Garlic (लसूण)'),
                                    value: 'Garlic (लसूण)',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Ginger (आले)'),
                                    value: 'Ginger (आले)',
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    ll[0] = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Container(
                            width: 150,
                            height: 35,
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 6.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[300],
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              controller: _productController[0],
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'quantity',
                                  suffixText: ('kg'),
                                  suffixStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: (itemsCount >= 1)
                                ? Icon(Icons.remove_circle_outline)
                                : Icon(Icons.add_circle_outline),
                            iconSize: 28,
                            onPressed: () {
                              if (itemsCount >= 1) {
                                print('Removing....');
                                setState(() {
                                  print('$itemsCount on removing');
                                  ll[itemsCount] = null;
                                  _productController[itemsCount] =
                                      TextEditingController();
                                  itemsCount = --itemsCount;
                                });
                              } else {
                                print('Adding....');
                                setState(() {
                                  itemsCount = ++itemsCount;
                                });
                                if (!selectedItems.containsKey(ll[0])) {
                                  selectedItems[ll[0]] =
                                      _productController[0].text.toString();
                                }
                              }
                              print(itemsCount);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                (itemsCount >= 1)
                    ? Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Container(
                                  width: 150,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey[300],
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      hint: ll[1] == null
                                          ? Text('Select')
                                          : Text(
                                              ll[1],
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                      value: ll[1],
                                      items: [
                                        DropdownMenuItem(
                                          child: Text('Onion (कांदा)'),
                                          value: 'Onion (कांदा)',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Potato (बटाटा)'),
                                          value: 'Potato (बटाटा)',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Garlic (लसूण)'),
                                          value: 'Garlic (लसूण)',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Ginger (आले)'),
                                          value: 'Ginger (आले)',
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          ll[1] = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Container(
                                  width: 150,
                                  height: 35,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 6.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey[300],
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    controller: _productController[1],
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'quantity',
                                        suffixText: ('kg'),
                                        suffixStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  icon: (itemsCount > 1)
                                      ? Icon(Icons.remove_circle_outline)
                                      : Icon(Icons.add_circle_outline),
                                  iconSize: 28,
                                  onPressed: () {
                                    if (itemsCount > 1) {
                                      print('Removing....');
                                      setState(() {
                                        print('$itemsCount on removing');
                                        ll[itemsCount] = null;
                                        _productController[itemsCount] =
                                            TextEditingController();
                                        itemsCount = --itemsCount;
                                      });
                                    } else {
                                      print('Adding....');
                                      setState(() {
                                        itemsCount = ++itemsCount;
                                      });
                                      if (!selectedItems.containsKey(ll[1])) {
                                        selectedItems[ll[1]] =
                                            _productController[1]
                                                .text
                                                .toString();
                                      }
                                    }
                                    print(itemsCount);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            )
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 5,
                ),
                (itemsCount >= 2)
                    ? Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Container(
                                  width: 150,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey[300],
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      hint: ll[2] == null
                                          ? Text('Select')
                                          : Text(
                                              ll[2],
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                      value: ll[2],
                                      items: [
                                        DropdownMenuItem(
                                          child: Text('Onion (कांदा)'),
                                          value: 'Onion (कांदा)',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Potato (बटाटा)'),
                                          value: 'Potato (बटाटा)',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Garlic (लसूण)'),
                                          value: 'Garlic (लसूण)',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Ginger (आले)'),
                                          value: 'Ginger (आले)',
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          ll[2] = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Container(
                                  width: 150,
                                  height: 35,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 6.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey[300],
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    controller: _productController[2],
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'quantity',
                                        suffixText: ('kg'),
                                        suffixStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  icon: (itemsCount > 2)
                                      ? Icon(Icons.remove_circle_outline)
                                      : Icon(Icons.add_circle_outline),
                                  iconSize: 28,
                                  onPressed: () {
                                    if (itemsCount > 2) {
                                      print('Removing....');
                                      setState(() {
                                        print('$itemsCount on removing');
                                        ll[itemsCount] = null;
                                        _productController[itemsCount] =
                                            TextEditingController();
                                        itemsCount = --itemsCount;
                                      });
                                    } else {
                                      print('Adding....');
                                      setState(() {
                                        itemsCount = ++itemsCount;
                                      });
                                      if (!selectedItems.containsKey(ll[2])) {
                                        selectedItems[ll[2]] =
                                            _productController[2]
                                                .text
                                                .toString();
                                      }
                                    }
                                    print(itemsCount);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            )
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 5,
                ),
                (itemsCount >= 3)
                    ? Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Container(
                                  width: 150,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey[300],
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      hint: ll[3] == null
                                          ? Text('Select')
                                          : Text(
                                              ll[3],
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                      value: ll[3],
                                      items: [
                                        DropdownMenuItem(
                                          child: Text('Onion (कांदा)'),
                                          value: 'Onion (कांदा)',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Potato (बटाटा)'),
                                          value: 'Potato (बटाटा)',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Garlic (लसूण)'),
                                          value: 'Garlic (लसूण)',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Ginger (आले)'),
                                          value: 'Ginger (आले)',
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          ll[3] = value;
                                        });
                                        if (!selectedItems.containsKey(ll[3])) {
                                          selectedItems[ll[3]] =
                                              _productController[3]
                                                  .text
                                                  .toString();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Container(
                                  width: 150,
                                  height: 35,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 6.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey[300],
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    controller: _productController[3],
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'quantity',
                                        suffixText: ('kg'),
                                        suffixStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(),
                              flex: 1,
                            ),
                            SizedBox(
                              width: 10.0,
                            )
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Container(
                        height: 40,
                        width: 150,
                        child: RaisedButton(
                          onPressed: () async {
                            status = true;
                            print(itemsCount);
                            if (itemsCount == 0) {
                              condition = ll[0] != null;
                            } else if (itemsCount == 1) {
                              condition = ll[0] != null && ll[1] != null;
                            } else if (itemsCount == 2) {
                              condition = ll[0] != null &&
                                  ll[1] != null &&
                                  ll[2] != null;
                            } else {
                              condition = ll[0] != null &&
                                  ll[1] != null &&
                                  ll[2] != null &&
                                  ll[3] != null;
                            }

                            if (condition) {
                              if (_productController[0].text != '') {
                                double qty0 =
                                    double.parse(_productController[0].text);
                                await Firestore.instance
                                    .collection('${widget.id2}_stocks')
                                    .document(ll[0])
                                    .get()
                                    .then((value) => {
                                          if (value.data['itemCount'] - qty0 >=
                                              0)
                                            {
                                              Firestore.instance
                                                  .collection(
                                                      '${widget.id2}_stocks')
                                                  .document(ll[0])
                                                  .updateData({
                                                "itemCount":
                                                    (value.data['itemCount'] -
                                                        qty0)
                                              }).then((_) {
                                                print("success 0!");
                                              }),
                                            }
                                          else
                                            {
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Not enough stock to remove from ${ll[0]}."),
                                              )),
                                              status = false,
                                            }
                                        });
                              } else if (ll[0] != null) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Fill quantity for ${ll[0]}."),
                                ));
                                status = false;
                              }

                              if (_productController[1].text != '') {
                                double qty1 =
                                    double.parse(_productController[1].text);
                                await Firestore.instance
                                    .collection('${widget.id2}_stocks')
                                    .document(ll[1])
                                    .get()
                                    .then((value) => {
                                          if (value.data['itemCount'] - qty1 >=
                                              0)
                                            {
                                              Firestore.instance
                                                  .collection(
                                                      '${widget.id2}_stocks')
                                                  .document(ll[1])
                                                  .updateData({
                                                "itemCount":
                                                    (value.data['itemCount'] -
                                                        qty1)
                                              }).then((_) {
                                                print("success 1!");
                                              }),
                                            }
                                          else
                                            {
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Not enough stock to remove from ${ll[1]}."),
                                              )),
                                              status = false,
                                            }
                                        });
                              } else if (ll[1] != null) {
                                status = false;
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Fill quantity for ${ll[1]}."),
                                ));
                              }

                              if (_productController[2].text != '') {
                                double qty2 =
                                    double.parse(_productController[2].text);
                                await Firestore.instance
                                    .collection('${widget.id2}_stocks')
                                    .document(ll[2])
                                    .get()
                                    .then((value) => {
                                          if (value.data['itemCount'] - qty2 >=
                                              0)
                                            {
                                              Firestore.instance
                                                  .collection(
                                                      '${widget.id2}_stocks')
                                                  .document(ll[2])
                                                  .updateData({
                                                "itemCount":
                                                    (value.data['itemCount'] -
                                                        qty2)
                                              }).then((_) {
                                                print("success 2!");
                                              }),
                                            }
                                          else
                                            {
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Not enough stock to remove from ${ll[2]}."),
                                              )),
                                              status = false,
                                            }
                                        });
                              } else if (ll[2] != null) {
                                status = false;
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Fill quantity for ${ll[2]}."),
                                ));
                              }

                              if (_productController[3].text != '') {
                                double qty3 =
                                    double.parse(_productController[3].text);
                                await Firestore.instance
                                    .collection('${widget.id2}_stocks')
                                    .document(ll[3])
                                    .get()
                                    .then((value) => {
                                          if (value.data['itemCount'] - qty3 >=
                                              0)
                                            {
                                              Firestore.instance
                                                  .collection(
                                                      '${widget.id2}_stocks')
                                                  .document(ll[3])
                                                  .updateData({
                                                "itemCount":
                                                    (value.data['itemCount'] -
                                                        qty3)
                                              }).then((_) {
                                                print("success 3!");
                                              }),
                                            }
                                          else
                                            {
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Not enough stock to remove from ${ll[3]}."),
                                              )),
                                              status = false,
                                            }
                                        });
                              } else if (ll[3] != null) {
                                status = false;
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Fill quantity for ${ll[3]}."),
                                ));
                              }
                            } else {
                              status = false;
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Fill the empty values!"),
                              ));
                            }

                            if (status == true) {
                              Navigator.of(context).pop();
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23.0),
                              side: BorderSide(color: Colors.grey)),
                          color: Colors.black45,
                          child: Text(
                            'REMOVE  STOCK',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 40,
                        width: 150,
                        child: RaisedButton(
                          onPressed: () async {
                            status = true;
                            print(itemsCount);
                            if (itemsCount == 0) {
                              condition = ll[0] != null;
                            } else if (itemsCount == 1) {
                              condition = ll[0] != null && ll[1] != null;
                            } else if (itemsCount == 2) {
                              condition = ll[0] != null &&
                                  ll[1] != null &&
                                  ll[2] != null;
                            } else {
                              condition = ll[0] != null &&
                                  ll[1] != null &&
                                  ll[2] != null &&
                                  ll[3] != null;
                            }

                            if (condition) {
                              if (_productController[0].text != '') {
                                double qty0 =
                                    double.parse(_productController[0].text);
                                await Firestore.instance
                                    .collection('${widget.id2}_stocks')
                                    .document(ll[0])
                                    .get()
                                    .then((value) => {
                                          if (qty0 + value.data['itemCount'] >=
                                              0)
                                            {
                                              Firestore.instance
                                                  .collection(
                                                      '${widget.id2}_stocks')
                                                  .document(ll[0])
                                                  .updateData({
                                                "itemCount": (qty0 +
                                                    value.data['itemCount'])
                                              }).then((_) {
                                                print("success 0!");
                                              }),
                                            }
                                          else
                                            {
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Not enough stock to remove from ${ll[0]}."),
                                              )),
                                              status = false,
                                            }
                                        });
                              } else if (ll[0] != null) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Fill quantity for ${ll[0]}."),
                                ));
                                status = false;
                              }

                              if (_productController[1].text != '') {
                                double qty1 =
                                    double.parse(_productController[1].text);
                                await Firestore.instance
                                    .collection('${widget.id2}_stocks')
                                    .document(ll[1])
                                    .get()
                                    .then((value) => {
                                          if (qty1 + value.data['itemCount'] >=
                                              0)
                                            {
                                              Firestore.instance
                                                  .collection(
                                                      '${widget.id2}_stocks')
                                                  .document(ll[1])
                                                  .updateData({
                                                "itemCount": (qty1 +
                                                    value.data['itemCount'])
                                              }).then((_) {
                                                print("success 1!");
                                              }),
                                            }
                                          else
                                            {
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Not enough stock to remove from ${ll[1]}."),
                                              )),
                                              status = false,
                                            }
                                        });
                              } else if (ll[1] != null) {
                                status = false;
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Fill quantity for ${ll[1]}."),
                                ));
                              }

                              if (_productController[2].text != '') {
                                double qty2 =
                                    double.parse(_productController[2].text);
                                await Firestore.instance
                                    .collection('${widget.id2}_stocks')
                                    .document(ll[2])
                                    .get()
                                    .then((value) => {
                                          if (qty2 + value.data['itemCount'] >=
                                              0)
                                            {
                                              Firestore.instance
                                                  .collection(
                                                      '${widget.id2}_stocks')
                                                  .document(ll[2])
                                                  .updateData({
                                                "itemCount": (qty2 +
                                                    value.data['itemCount'])
                                              }).then((_) {
                                                print("success 2!");
                                              }),
                                            }
                                          else
                                            {
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Not enough stock to remove from ${ll[2]}."),
                                              )),
                                              status = false,
                                            }
                                        });
                              } else if (ll[2] != null) {
                                status = false;
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Fill quantity for ${ll[2]}."),
                                ));
                              }

                              if (_productController[3].text != '') {
                                double qty3 =
                                    double.parse(_productController[3].text);
                                await Firestore.instance
                                    .collection('${widget.id2}_stocks')
                                    .document(ll[3])
                                    .get()
                                    .then((value) => {
                                          if (qty3 + value.data['itemCount'] >=
                                              0)
                                            {
                                              Firestore.instance
                                                  .collection(
                                                      '${widget.id2}_stocks')
                                                  .document(ll[3])
                                                  .updateData({
                                                "itemCount": (qty3 +
                                                    value.data['itemCount'])
                                              }).then((_) {
                                                print("success 3!");
                                              }),
                                            }
                                          else
                                            {
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Not enough stock to remove from ${ll[3]}."),
                                              )),
                                              status = false,
                                            }
                                        });
                              } else if (ll[3] != null) {
                                status = false;
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Fill quantity for ${ll[3]}."),
                                ));
                              }
                            } else {
                              status = false;
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Fill the empty values!"),
                              ));
                            }

                            if (status == true) {
                              Navigator.of(context).pop();
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23.0),
                              side: BorderSide(color: Colors.grey)),
                          color: Color(0xff8df0a9),
                          child: Text(
                            'ADD  STOCK',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
