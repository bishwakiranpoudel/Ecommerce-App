import 'package:batuwa/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// Import the firebase_core and cloud_firestore plugin

import 'package:cloud_firestore/cloud_firestore.dart';

class Editcart extends StatefulWidget {
  const Editcart({
    Key? key,
    required this.doc,
    required this.qua,
    required this.pref,
  }) : super(key: key);
  final String doc;
  final String qua;
  final String pref;

  @override
  _EditcartState createState() => _EditcartState();
}

class _EditcartState extends State<Editcart> {
  UploadTask? task;

  String name = '';
  int quantity = 1;
  String pref = '';
  bool ordered = false;

  @override
  Widget build(BuildContext context) {
    pref = widget.pref;
    // quantity = int.parse(widget.qua);
    final User? user = FirebaseAuth.instance.currentUser;
    final String uid = user!.uid.toString();
    // Create a CollectionReference called users that references the firestore collection

    Future<void> edit() {
      WriteBatch batch = FirebaseFirestore.instance.batch();

      return FirebaseFirestore.instance
          .collection("cart")
          .doc(widget.doc)
          .update({
            'quantity': quantity.toString(),
            'preference': pref,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "EDIT CART",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white10),
          height: 450,
          child: Column(
            children: [
              Text(
                "Previous Quantity:" + widget.qua.toString(),
                style: TextStyle(fontSize: 20.0),
              ),
              // TextButton(onPressed: uploadFile, child: Text('uploadfile')),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "New Quantity",
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
              // Text("Order Preference:"),
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
                padding: const EdgeInsets.only(top: 0.0),
                child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "Item Updated",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          edit();
                          Navigator.popAndPushNamed(context, '/cart');
                          // Navigator.pushNamed(context, '/cart');
                        },
                        child: Text(
                          'UPDATE ITEM',
                          style: TextStyle(color: Colors.white),
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
