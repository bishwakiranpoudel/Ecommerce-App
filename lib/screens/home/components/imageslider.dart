import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';

class ISlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("banner2")
            .limit(3)
            // .where('search', isGreaterThanOrEqualTo: widget.name.toLowerCase())

            // .where('category', isEqualTo: widget.name.toLowerCase())
            // .where('search', isLessThan: widget.name.toLowerCase())
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
          return Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, bottom: 0),
                    child: Text("Collections",
                        style: GoogleFonts.oswald(
                          textStyle:
                              TextStyle(fontSize: 18, color: kPrimaryColor),
                        )),
                  ),
                  // Spacer()
                ],
              ),
              Container(
                height: 300,
                color: Colors.white,
                child: CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    autoPlay: true,
                    viewportFraction: 0.95,
                  ),
                  items: snapshot.data!.docs
                      .map((doc) => ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                Image.network(
                                  doc['image'],
                                  width: MediaQuery.of(context).size.width * 1,
                                  height: MediaQuery.of(context).size.width / 2,
                                  fit: BoxFit.cover,
                                )
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          );
        });
  }
}
