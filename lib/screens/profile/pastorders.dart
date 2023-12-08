import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants.dart';

class PastOrderScreen extends StatefulWidget {
  PastOrderScreen({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  PastOrderScreenState createState() => PastOrderScreenState();
}

class PastOrderScreenState extends State<PastOrderScreen> {
  PastOrderScreenState();

  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String uid = user!.uid.toString();

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("cart")
            .where('uid', isEqualTo: widget.uid)
            .where('order', isEqualTo: true)
            .where('orderstatus', isEqualTo: 'completed')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          var ds = snapshot.data!.docs;
          double sum = 0.0;
          for (int i = 0; i < ds.length; i++)
            sum += int.parse(ds[i]['price']) *
                int.parse(ds[i]['quantity']).toDouble();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white12,
              elevation: 0,
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  // color: Colors.black26
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your Past Orders'),
                  if (ds.length.toString() == "1")
                    Text(
                      'Batuwa succesfully fulfilled ' +
                          ds.length.toString() +
                          ' order for you.',
                      style: TextStyle(color: Colors.green[900], fontSize: 10),
                    )
                  else if (ds.length.toString() == "0")
                    Text(
                      'Nothing here! Batuwa is yet to fulfill your orders.',
                      style: TextStyle(color: Colors.red[900], fontSize: 10),
                    )
                  else
                    Text(
                      'Batuwa succesfully fulfilled ' +
                          ds.length.toString() +
                          ' orders for you.',
                      style: TextStyle(color: Colors.green[900], fontSize: 10),
                    )

                  // Text(
                  //   "${demoCarts.length} items",
                  //   style: Theme.of(context).textTheme.caption,
                  // ),
                ],
              ),
            ),
            body: Column(
              children: [
                Column(
                  children: [
                    SingleChildScrollView(
                      child: ListView(
                        // childAspectRatio: 1.03 / 1.33,

                        physics: new NeverScrollableScrollPhysics(),

                        shrinkWrap: true,
                        children: snapshot.data!.docs.map((doc) {
                          return Row(children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SizedBox(
                                width: 80,
                                child: AspectRatio(
                                  aspectRatio: 0.88,
                                  child: Container(
                                    padding: EdgeInsets.all((10)),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF0F0F0),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Image.network(doc['image']),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doc['name'],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  maxLines: 2,
                                ),
                                SizedBox(height: 10),
                                Text.rich(
                                  TextSpan(
                                    text: "Rs." + doc['price'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: kPrimaryColor),
                                    children: [
                                      TextSpan(
                                          text: " x " + doc["quantity"],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                    ],
                                  ),
                                ),
                                Text(
                                  doc['orderstatus'].toUpperCase(),
                                  style: TextStyle(
                                      color: doc['orderstatus'].toUpperCase() ==
                                              "VERIFIED"
                                          ? Colors.green[600]
                                          : doc['orderstatus'].toUpperCase() ==
                                                  "COMPLETED"
                                              ? Colors.blue
                                              : Colors.teal[600],
                                      fontSize: 16),
                                  maxLines: 2,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Order ID:  ",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      maxLines: 2,
                                    ),
                                    Text(
                                      uid.substring(0, 6),
                                      style: TextStyle(
                                          color: kPrimaryColor, fontSize: 20),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: doc['orderstatus'].toUpperCase() ==
                                      "PROCESSING"
                                  ? IconButton(
                                      icon: Icon(Icons.remove_circle),
                                      color: kPrimaryColor,
                                      onPressed: () {
                                        String id = doc.id;
                                        FirebaseFirestore.instance
                                            .collection("cart")
                                            .doc(id)
                                            .delete();
                                        Fluttertoast.showToast(
                                          msg: "Order cancelled.",
                                          toastLength: Toast.LENGTH_SHORT,
                                        );
                                      },
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: IconButton(
                                        icon: Icon(Icons.remove_circle),
                                        color: Colors.grey,
                                        onPressed: () {
                                          Fluttertoast.showToast(
                                            msg: "You can't cancel a " +
                                                doc['orderstatus']
                                                    .toLowerCase() +
                                                " order.",
                                            toastLength: Toast.LENGTH_LONG,
                                          );
                                        },
                                      )),
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
