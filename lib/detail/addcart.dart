import 'package:batuwa/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// Import the firebase_core and cloud_firestorcmde plugin
import '../../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCart extends StatefulWidget {
  const AddCart(
      {Key? key,
      required this.name,
      required this.image,
      required this.uid,
      required this.price})
      : super(key: key);
  final String name;
  final String uid;
  final String price;

  final String image;

  @override
  _AddCartState createState() => _AddCartState();
}

class _AddCartState extends State<AddCart> {
  UploadTask? task;

  String name = '';
  // String quantity = '0';
  String pref = '';
  int quantity = 1;

  bool ordered = false;

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String uid = user!.uid.toString();
    // Create a CollectionReference called users that references the firestore collection

    CollectionReference cart = FirebaseFirestore.instance.collection('cart');

    Future uploadFile() async {
      return cart
          .add({
            'name': widget.name,
            'image': widget.image,
            'quantity': quantity.toString(),
            'preference': pref,
            'uid': uid,
            'order': ordered,
            'price': widget.price,
            'orderstatus': 'processing',
            'phonenumber': user.phoneNumber.toString(),
            'orderid': uid.substring(0, 6),
          })
          .then((value) => print("Item Added"))
          .catchError((error) => print("Failed to add item: $error"));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        elevation: 0,
        title: Column(
          children: [
            Text(
              "Add To Cart",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      // appBar: AppBar(
      //   backgroundColor: kPrimaryColor,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     color: Colors.white,
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   title: Text(
      //     "ADD TO CART",
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[200]),
            height: 340,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  // TextButton(onPressed: uploadFile, child: Text('uploadfile')),
                  // Text(
                  //   "Quantity:",
                  //   style: TextStyle(fontSize: 18),
                  // ),
                  // TextField(
                  //   onChanged: (val) {
                  //     quantity = val;
                  //   },
                  //   obscureText: false,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     labelText: 'Quantity',
                  //     hintText: 'Enter Quantity',
                  //   ),
                  // ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Quantity",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        new IconButton(
                            icon: new Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (quantity <= 1) {
                                  quantity = 1;
                                  print(quantity);
                                } else {
                                  quantity = quantity - 1;
                                  print(quantity);
                                }
                              });
                            }),
                        // TextField(
                        //   onChanged: (val) {
                        //     quantity = val;
                        //   },
                        // ),
                        Text('$quantity'),
                        IconButton(
                            icon: new Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantity = quantity + 1;
                                print(quantity);
                              });
                            }),
                      ]),

                  SizedBox(
                    height: 20,
                  ),
                  // Text("Order Preference:", style: TextStyle(fontSize: 18)),
                  TextField(
                    onChanged: (val) {
                      pref = val;
                    },
                    maxLength: 100,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Order Preferences',
                      hintText: 'Order Preferences',
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                            onPressed: () {
                              Fluttertoast.showToast(
                                  msg: "Item Added",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              uploadFile();
                              Navigator.popAndPushNamed(context, '/cart');
                              // Navigator.pushNamed(context, '/cart');
                            },
                            child: Text(
                              'ADD ITEM',
                              style: TextStyle(color: Colors.white),
                            ))),
                  ),
                  // TrendingSearches()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
