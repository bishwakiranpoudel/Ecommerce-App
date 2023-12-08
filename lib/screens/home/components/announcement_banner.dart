import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnnouncementBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("banner1").snapshots(),
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
            height: MediaQuery.of(context).size.width / 2,
            child: GridView.count(
              childAspectRatio: 2 / 1,
              physics: new NeverScrollableScrollPhysics(),
              crossAxisCount: 1,
              shrinkWrap: true,
              children: snapshot.data!.docs.map((doc) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    // height: 90,
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.width / 2,
                    margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 40,
                    ),
                    decoration: BoxDecoration(
                        // color: Color.fromRGBO(204, 65, 255, 1),
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(doc['image']),
                            fit: BoxFit.cover)),
                    // Till here
                    // child: Text.rich(
                    //   TextSpan(
                    //     style: TextStyle(color: Colors.white),
                    //     children: [
                    //       TextSpan(
                    //           text: "ASSISTING YOU ON THIS LOCKDOWN\n",
                    //           style: TextStyle(color: Colors.white)),
                    //       TextSpan(
                    //         text: "Free Home Delivery!",
                    //         style: TextStyle(
                    //           color: Color.fromRGBO(251, 255, 0, 1),
                    //           fontSize: 25,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ),
                );
              }).toList(),
            ),
          );
        });
  }
}
