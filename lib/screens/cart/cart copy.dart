import 'package:batuwa/detail/detail.dart';
import 'package:batuwa/screens/cart/cart_edit.dart';
import 'package:batuwa/screens/home/home-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: TextButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Place Order",
                      style: TextStyle(fontSize: 18, color: kPrimaryColor),
                    ),
                  ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
              ),
              title: Column(
                children: [
                  Text('Your Cart'),
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
                          return Padding(
                            // padding: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 5),
                            child: Card(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => detailScreen(
                                              name: doc['name'],
                                              category: doc['category'],
                                              image: doc['image'],
                                              price: doc['price'],
                                            )),
                                  );
                                },
                                child: Container(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 180,
                                        height: 130,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4),
                                                topRight: Radius.circular(4)),
                                            image: DecorationImage(
                                                image:
                                                    NetworkImage(doc['image']),
                                                fit: BoxFit.cover)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, top: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              doc['name'],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                            ),
                                            Text(
                                              doc['price'] +
                                                  ' x ' +
                                                  doc['quantity'],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10),
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                  Icons.edit_outlined),
                                              color: Colors.greenAccent,
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Editcart(
                                                            doc: doc.id,
                                                            qua:
                                                                doc['quantity'],
                                                            pref: doc[
                                                                'preference'],
                                                          )),
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                  Icons.delete_outline),
                                              color: Colors.redAccent,
                                              onPressed: () {
                                                String id = doc.id;
                                                FirebaseFirestore.instance
                                                    .collection("cart")
                                                    .doc(id)
                                                    .delete();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Divider(
                      height: 20,
                      thickness: 2,
                      indent: 25,
                      endIndent: 25,
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.only(left: 50.0, top: 0, right: 50),
                      child: Row(
                        children: [
                          Text(
                            "Total:",
                            style: TextStyle(
                                fontSize: 20,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            sum.toString(),
                            style: TextStyle(
                                fontSize: 20,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
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
