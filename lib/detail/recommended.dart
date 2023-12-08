import 'package:batuwa/detail/detail.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class RecommendedScreen extends StatefulWidget {
  RecommendedScreen({Key? key, required this.category}) : super(key: key);
  final String category;

  @override
  RecommendedScreenState createState() => RecommendedScreenState();
}

class RecommendedScreenState extends State<RecommendedScreen> {
  RecommendedScreenState();

  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("item")
            .where('category', isEqualTo: widget.category)
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
          return Container(
            color: Colors.white,
            child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: snapshot.data!.docs.map((doc) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
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
                          height: 2000,
                          child: Column(
                            children: [
                              Container(
                                width: 180,
                                height: 130,
                                decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.only(
                                    //     topLeft: Radius.circular(4),
                                    //     topRight: Radius.circular(4)),
                                    image: DecorationImage(
                                        image: NetworkImage(doc['image']),
                                        fit: BoxFit.cover)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doc['name'],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                    Text(
                                      'Rs.' + doc['price'],
                                      style: TextStyle(
                                          color: Colors.orange, fontSize: 12),
                                    ),
                                    Row(
                                      children: [
                                        // Text(
                                        //   '4.5',
                                        //   style: TextStyle(
                                        //       color: Colors.black,
                                        //       fontSize: 10),
                                        // ),
                                        // Icon(
                                        //   Icons.star_border_outlined,
                                        //   size: 12,
                                        // ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 9),
                                      child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                            // borderRadius:
                                            //     BorderRadius.circular(20),
                                            color: Colors.orange),
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Add +",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
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
                }).toList()),
          );
        });
  }
}

class recScreen extends StatefulWidget {
  recScreen({Key? key, required this.category}) : super(key: key);
  final String category;

  @override
  recScreenState createState() => recScreenState();
}

class recScreenState extends State<recScreen> {
  recScreenState();

  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("item").snapshots(),
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
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(30),
              //     topRight: Radius.circular(30))
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 10, bottom: 0),
                  child: Container(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Recommended Products",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                "Matching Products",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey[800]),
                              ),
                            ),
                          ],
                        ),
                        // Spacer()
                      ],
                    ),
                  ),
                ),
                GridView.count(
                  // childAspectRatio: 1.03 / 1.33,
                  childAspectRatio: 0.7 / 1.11,
                  physics: new NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((doc) {
                    return Padding(
                      // padding: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.only(left: 2, right: 2, top: 5),
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
                            height: 2000,
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
                                          image: NetworkImage(doc['image']),
                                          fit: BoxFit.cover)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        doc['name'],
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                      ),
                                      Text(
                                        'Rs.' + doc['price'],
                                        style: TextStyle(
                                            color: kPrimaryColor, fontSize: 14),
                                      ),
                                      Row(
                                        children: [
                                          // Text(
                                          //   '4.5',
                                          //   style: TextStyle(
                                          //       color: Colors.grey[600],
                                          //       fontSize: 10),
                                          // ),
                                          // Icon(
                                          //   Icons.star_border_outlined,
                                          //   size: 14,
                                          // ),
                                        ],
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
              ],
            ),
          );
        });
  }
}
//backend aspect completed

