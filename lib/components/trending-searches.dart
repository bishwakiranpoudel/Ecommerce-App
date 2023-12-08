import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import 'package:batuwa/constants.dart';
import 'package:batuwa/detail/detail.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

// class TrendingSearches extends StatelessWidget {
//   const TrendingSearches({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Text(
//               "TRENDING SEARCHES",
//               style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: kPrimaryColor),
//             ),
//           ),
//           Row(
//             children: <Widget>[
//               Container(
//                 width: 120,
//                 child: TextButton.icon(
//                   icon: Icon(
//                     Icons.trending_up,
//                     color: kSecondaryColor,
//                   ),
//                   label: Text(
//                     'Camera',
//                     style: TextStyle(color: Colors.black54),
//                   ),
//                   onPressed: () {},
//                 ),
//               ),
//               Container(
//                 width: 120,
//                 child: TextButton.icon(
//                   icon: Icon(
//                     Icons.trending_up,
//                     color: kSecondaryColor,
//                   ),
//                   label: Text(
//                     'Makeup',
//                     style: TextStyle(color: Colors.black54),
//                   ),
//                   onPressed: () {},
//                 ),
//               ),
//               Container(
//                 width: 120,
//                 child: TextButton.icon(
//                   icon: Icon(
//                     Icons.trending_up,
//                     color: kSecondaryColor,
//                   ),
//                   label: Text(
//                     'Old car',
//                     style: TextStyle(color: Colors.black54),
//                   ),
//                   onPressed: () {},
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             children: <Widget>[
//               Container(
//                 width: 120,
//                 child: TextButton.icon(
//                   icon: Icon(
//                     Icons.trending_up,
//                     color: kSecondaryColor,
//                   ),
//                   label: Text(
//                     'Sandals',
//                     style: TextStyle(color: Colors.black54),
//                   ),
//                   onPressed: () {},
//                 ),
//               ),
//               Container(
//                 width: 120,
//                 child: TextButton.icon(
//                   icon: Icon(
//                     Icons.trending_up,
//                     color: kSecondaryColor,
//                   ),
//                   label: Text(
//                     'Mo:Mo:',
//                     style: TextStyle(color: Colors.black54),
//                   ),
//                   onPressed: () {},
//                 ),
//               ),
//               Container(
//                 width: 120,
//                 child: TextButton.icon(
//                   icon: Icon(
//                     Icons.trending_up,
//                     color: kSecondaryColor,
//                   ),
//                   label: Text(
//                     'Makeup',
//                     style: TextStyle(color: Colors.black54),
//                   ),
//                   onPressed: () {},
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class TrendingSearches extends StatefulWidget {
  TrendingSearches();

  @override
  TrendingSearchesState createState() => TrendingSearchesState();
}

class TrendingSearchesState extends State<TrendingSearches> {
  TrendingSearchesState();

  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("popular")
            .limit(30)
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
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              color: Colors.white,
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
                            Text("Trending Products",
                                style: GoogleFonts.oswald(
                                  textStyle: TextStyle(
                                      fontSize: 18, color: kPrimaryColor),
                                )),
                          ],
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                ),
                GridView.count(
                  // childAspectRatio: 1.03 / 1.33,
                  childAspectRatio: 3.5 / 1.25,
                  physics: new NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((doc) {
                    return Padding(
                      // padding: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.only(left: 0, right: 0, top: 5),
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
                            width: 120,
                            child: TextButton.icon(
                              icon: Icon(
                                Icons.trending_up,
                                color: kSecondaryColor,
                              ),
                              label: Text(
                                doc['name'],
                                style: TextStyle(color: Colors.black54),
                              ),
                              onPressed: () {},
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
