import 'package:batuwa/screens/cart/cart_edit.dart';
import 'package:batuwa/screens/profile/myorders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';

class cartScreen extends StatefulWidget {
  cartScreen({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  cartScreenState createState() => cartScreenState();
}

class cartScreenState extends State<cartScreen> {
  cartScreenState();

  Widget build(BuildContext context) {
    Future<void> order() {
      WriteBatch batch = FirebaseFirestore.instance.batch();

      return FirebaseFirestore.instance
          .collection("cart")
          .where('uid', isEqualTo: widget.uid)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((document) {
          batch.update(document.reference, {'order': true});
        });

        return batch.commit();
      });
    }

    ;
    final User? user = FirebaseAuth.instance.currentUser;
    final String uid = user!.uid.toString();

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("cart")
            .where('uid', isEqualTo: widget.uid)
            .where('order', isEqualTo: false)
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

          // return ListView(children: snapshot.data.documents.map((document) {
          //   return Center(
          //     child: Container(
          //       child: Column(
          //         children: [
          //           Text(document['name']),
          //           Text(document['price']),
          //           Text(document['description']),
          //         ],
          //       ),
          //     ),
          //   );
          // }));
          return Scaffold(
            bottomNavigationBar: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                vertical: (15),
                horizontal: (26),
              ),
              // height: 174,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -15),
                    blurRadius: 20,
                    color: Color(0xFFDADADA).withOpacity(0.15),
                  )
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Container(
                        //   padding: EdgeInsets.all(10),
                        //   height: (40),
                        //   width: (40),
                        //   decoration: BoxDecoration(
                        //     color: Color(0xFFF5F6F9),
                        //     borderRadius: BorderRadius.circular(10),
                        //   ),
                        //   child: SvgPicture.asset("assets/icons/receipt.svg"),
                        // ),
                        // Spacer(),
                        // Text("Add voucher code"),
                        // const SizedBox(width: 10),
                        // Icon(
                        //   Icons.arrow_forward_ios,
                        //   size: 12,
                        //   color: kTextColor,
                        // )
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(
                          Icons.info_sharp,
                          color: Colors.black26,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                              'The default payment option is Cash on Delivery.\nMeaning, you must pay once you receive your order.',
                              style: GoogleFonts.actor(
                                  textStyle: TextStyle(color: Colors.black54))),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "Total:\n",
                            children: [
                              TextSpan(
                                text: "Rs. " + sum.toString(),
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: ds.length.toString() != "0"
                                    ? Color.fromRGBO(242, 104, 55, 1)
                                    : Colors.black26,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 15.0,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'CHECK OUT',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: ds.length.toString() != "0"
                                  ? () {
                                      Fluttertoast.showToast(
                                        msg: "Your order is placed.",
                                        toastLength: Toast.LENGTH_SHORT,
                                      );
                                      order();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyOrderScreen(uid: uid)),
                                      );
                                    }
                                  : () {
                                      Fluttertoast.showToast(
                                        msg:
                                            "Can't place order with empty cart!",
                                        toastLength: Toast.LENGTH_SHORT,
                                      );
                                    }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
                  Text('Your Cart'),
                  if (ds.length.toString() == "0")
                    Text(
                      'Nothing on your cart. Try shopping?',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    )
                  else if (ds.length.toString() == "1")
                    Text(
                      ds.length.toString() + ' item',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    )
                  else
                    Text(
                      ds.length.toString() + ' items',
                      style: TextStyle(color: Colors.black, fontSize: 10),
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
                                    text: "Rs. " + doc['price'],
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
                                )
                              ],
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                color: kPrimaryColor,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Editcart(
                                              doc: doc.id,
                                              qua: doc['quantity'],
                                              pref: doc['preference'],
                                            )),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: IconButton(
                                icon: Icon(Icons.remove_circle),
                                color: kPrimaryColor,
                                onPressed: () {
                                  String id = doc.id;
                                  FirebaseFirestore.instance
                                      .collection("cart")
                                      .doc(id)
                                      .delete();
                                  Fluttertoast.showToast(
                                    msg: "Item Removed",
                                    toastLength: Toast.LENGTH_SHORT,
                                  );
                                },
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
                    // Divider(
                    //   height: 20,
                    //   thickness: 2,
                    //   indent: 25,
                    //   endIndent: 25,
                    // ),

                    Padding(
                      padding:
                          const EdgeInsets.only(left: 50.0, top: 0, right: 50),
                      child: Row(
                        children: [
                          // Text(
                          //   "Total:",
                          //   style: TextStyle(
                          //       fontSize: 20,
                          //       color: kPrimaryColor,
                          //       fontWeight: FontWeight.bold),
                          // ),
                          // Spacer(),
                          // Text(
                          //   sum.toString(),
                          //   style: TextStyle(
                          //       fontSize: 20,
                          //       color: kPrimaryColor,
                          //       fontWeight: FontWeight.bold),
                          // ),
                        ],
                      ),
                    ),

                    //TextButton(onPressed: order, child: Text("order")),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class DefaultButton {}
