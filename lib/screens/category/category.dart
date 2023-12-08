import 'package:batuwa/detail/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants.dart';

// ignore: camel_case_types
class categoryScreen extends StatefulWidget {
  categoryScreen({Key? key, required this.category}) : super(key: key);
  final String category;

  @override
  categoryScreenState createState() => categoryScreenState();
}

// ignore: camel_case_types
class categoryScreenState extends State<categoryScreen> {
  categoryScreenState();

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
          var ds = snapshot.data!.docs;

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
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white24,
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
                children: [
                  Text(widget.category),
                  Text(
                    ds.length.toString() + ' Items',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  )
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: GridView.count(
                // childAspectRatio: 1.03 / 1.33,
                childAspectRatio: 0.7 / 1.11,
                physics: new NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                shrinkWrap: true,
                children: snapshot.data!.docs.map((doc) {
                  return Padding(
                    // padding: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.only(left: 1, right: 1, top: 5),
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
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          color: kPrimaryColor, fontSize: 12),
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
                                        //   size: 12,
                                        // ),
                                      ],
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 9),
                                    //   child: Container(
                                    //     height: 35,
                                    //     decoration: BoxDecoration(
                                    //         borderRadius:
                                    //             BorderRadius.circular(20),
                                    //         color: kPrimaryColor),
                                    //     child: TextButton(
                                    //       onPressed: () {},
                                    //       child: Text(
                                    //         "Add +",
                                    //         style: TextStyle(
                                    //             color: Colors.white,
                                    //             fontSize: 15),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
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
          );
        });
  }
}
