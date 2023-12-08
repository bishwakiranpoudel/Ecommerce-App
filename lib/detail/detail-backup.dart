import 'package:batuwa/constants.dart';
import 'package:batuwa/detail/addcart.dart';
import 'package:batuwa/detail/recommended.dart';
import 'package:batuwa/screens/cart/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class dSc extends StatefulWidget {
  dSc(
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

  // here you write the codes to input the data into firestore

  @override
  dScState createState() => dScState();
}

class dScState extends State<dSc> {
  dScState();
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
            bottomNavigationBar: Bottom(
              name: widget.name,
              image: widget.image,
              price: widget.price,
            ),
            backgroundColor: Colors.white24,
            // appBar: AppBar(

            //   leading: IconButton(
            //     icon: Icon(Icons.arrow_back),
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => HomeScreen()),
            //       );
            //     },
            //   ),
            //   title: Text("detail"),
            // ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((doc) {
                      return Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2,
                            decoration: BoxDecoration(
                                color: Colors.white24,
                                image: DecorationImage(
                                    image: NetworkImage(doc['image']),
                                    fit: BoxFit.cover)),
                            child: Column(
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
                                      color: Colors.white24,
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
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Rs. ' + doc['price'],
                                                style: TextStyle(
                                                    color: Colors.yellow,
                                                    fontSize: 22),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 3),
                                              child: Row(
                                                children: [
                                                  // Text(
                                                  //   '4.5',
                                                  //   style: TextStyle(
                                                  //       color:
                                                  //           Colors.yellow[600],
                                                  //       fontSize: 14),
                                                  // ),
                                                  // Icon(
                                                  //   Icons.star_border_outlined,
                                                  //   size: 16,
                                                  //   color: Colors.yellow[700],
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //price name rating container

                          //description container
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // height:
                              //     MediaQuery.of(context).size.height / 8, //11
                              color: Colors.white24,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      // Text(
                                      //   'Stock',
                                      //   style: TextStyle(
                                      //       color: Colors.white, fontSize: 15),
                                      // ),
                                      // SizedBox(
                                      //   width: 75,
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Color(doc['color'])),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              doc['stock'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      doc['description'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          )
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

// Card(
//                       child: Container(
//                         width: 100,
//                         child: Column(
//                           children: [
//                             Image(
//                               image: NetworkImage(doc['image']),
//                               height: 300,
//                             ),
//                             Text(doc['name']),
//                             Text(doc['price']),
//                             Text(doc['description']),
//                           ],
//                         ),
//                       ),
//                     );

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
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade400,
              width: 0.5,
            ),
          )),
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 10),
          //   child: IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.store_outlined,
          //         color: Colors.orange,
          //       )),
          // ),
          //
          // Padding(
          //   padding: const EdgeInsets.only(left: 0),
          //   child: IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.search_outlined,
          //         color: Colors.orange,
          //       )),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 1),
          //   child: Container(
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(4), color: Colors.orange),
          //     child: TextButton(
          //       onPressed: () {},
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 40),
          //         child: Text(
          //           "Buy Now",
          //           style: TextStyle(fontSize: 10, color: Colors.white),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "ADD TO CART",
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
