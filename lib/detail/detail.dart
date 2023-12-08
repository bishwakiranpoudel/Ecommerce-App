import 'package:batuwa/constants.dart';
import 'package:batuwa/detail/addcart.dart';
import 'package:batuwa/detail/recommended.dart';
import 'package:batuwa/screens/cart/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class detailScreen extends StatefulWidget {
  detailScreen(
      {Key? key,
      required this.name,
      required this.category,
      required this.image,
      required this.price})
      : super(key: key);
  final String name;
  final String category;
  final String image;
  final String price;

  @override
  detailScreenState createState() => detailScreenState();
}

class detailScreenState extends State<detailScreen> {
  detailScreenState();
  bool stock = false;
  String available = 'Stock';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("item")
            .where('name', isEqualTo: widget.name)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }

          return Scaffold(
            bottomNavigationBar: Bottom(
              name: widget.name,
              image: widget.image,
              price: widget.price,
            ),
            backgroundColor: Color(0xFFF0F0F0),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ListView(
                    //scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((doc) {
                      return Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 1.3,
                            decoration: BoxDecoration(
                                color: Color(0xFFF0F0F0),
                                image: DecorationImage(
                                    image: NetworkImage(doc['image']),
                                    alignment: Alignment.topCenter,
                                    fit: BoxFit.contain)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.black26),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 3),
                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(Icons.arrow_back_ios),
                                            iconSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                doc['name'],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Rs. ' + doc['price'],
                                                style: TextStyle(
                                                    color: Colors.teal,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 3),
                                              child: Row(
                                                children: [],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                // height:
                                                //     MediaQuery.of(context).size.height / 8, //11
                                                color: Colors.white24,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              color: Color(doc[
                                                                  'color'])),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Text(
                                                              doc['stock'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 10),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      doc['description'],
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 15),
                                                    ),
                                                    SizedBox(height: 20),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 0,
                                  color: Colors.black38,
                                  indent: 12,
                                  endIndent: 12,
                                  thickness: 1.5,
                                ),
                              ],
                            ),
                          ),

                          //price name rating container

                          //description container
                        ],
                      );
                    }).toList(),
                  ),
                  recScreen(category: widget.category)
                ],
              ),
            ),
          );
        });
  }
}

class Bottom extends StatefulWidget {
  const Bottom(
      {Key? key, required this.name, required this.image, required this.price})
      : super(key: key);
  final String name;
  final String price;

  final String image;

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String uid = user!.uid.toString();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.orange[800]),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddCart(
                              name: widget.name,
                              image: widget.image,
                              uid: uid,
                              price: widget.price,
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 55),
                  child: Text(
                    "ADD TO CART",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          VerticalDivider(
            width: 3,
            indent: 8,
            endIndent: 8,
            thickness: 1.5,
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => cartScreen(
                            uid: uid,
                          )),
                );
              },
              icon: Icon(
                Icons.shopping_cart,
                color: kPrimaryColor,
              )),
        ],
      ),
    );
  }
}
