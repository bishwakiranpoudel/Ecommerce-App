import 'package:batuwa/constants.dart';
import 'package:batuwa/detail/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class AllProducts extends StatefulWidget {
  AllProducts();

  @override
  AllProductsState createState() => AllProductsState();
}

class AllProductsState extends State<AllProducts> {
  AllProductsState();

  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("item").limit(30).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }

          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              color: Colors.grey[100],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 10, bottom: 12),
                  child: Container(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("All Products",
                                style: GoogleFonts.oswald(
                                  textStyle: TextStyle(
                                      fontSize: 18, color: kPrimaryColor),
                                )),
                            Text(
                              "Batuwa Product Repository",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                ),
                GridView.count(
                  // childAspectRatio: 1.03 / 1.33,
                  childAspectRatio: 0.7 / 1.05,
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
