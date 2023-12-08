import 'package:batuwa/detail/detail.dart';
import 'package:batuwa/screens/home/components/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class searchScreen extends StatefulWidget {
  searchScreen({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  searchScreenState createState() => searchScreenState();
}

class searchScreenState extends State<searchScreen> {
  searchScreenState();

  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("item")
            // .where('search', isGreaterThanOrEqualTo: widget.name.toLowerCase())
            .where('search', isGreaterThanOrEqualTo: widget.name.toLowerCase())
            // .where('category', isEqualTo: widget.name.toLowerCase())
            // .where('search', isLessThan: widget.name.toLowerCase())
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Container(
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
              ),
              title: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  child: SearchField(),
                ),
              ),
              backgroundColor: Colors.white24,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: GridView.count(
                childAspectRatio: 1.2 / 1.33,
                physics: new NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                shrinkWrap: true,
                children: snapshot.data!.docs.map((doc) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doc['name'],
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        'Rs.' + doc['price'],
                                        style: TextStyle(
                                            color: Colors.orange[900],
                                            fontSize: 12),
                                      ),
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
                                    //     height: 30,
                                    //     decoration: BoxDecoration(
                                    //         borderRadius:
                                    //             BorderRadius.circular(20),
                                    //         color: Colors.orange),
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
