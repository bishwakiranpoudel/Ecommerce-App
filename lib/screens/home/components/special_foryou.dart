import 'package:batuwa/screens/category/category.dart';
import 'package:batuwa/screens/explore/explore_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';

class SpecialOffers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<int> getData(String a) async {
      // Get docs from collection reference
      final _fireStore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await _fireStore
          .collection('item')
          .where('category', isEqualTo: a)
          .get();

      // Get data from docs and convert map to List
      final no = querySnapshot.docs.map((doc) => doc.data()).toList().length;
      //for a specific field

      return no;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
              child: Text("Special For You",
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(fontSize: 18, color: kPrimaryColor),
                  )),
            ),
            // Spacer(),
          ],
        ),
        Column(
          children: [
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SpecialOfferCard(
                    image: "assets/images/food.jpg",
                    category: "Food and Beverage",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                categoryScreen(category: "Food and Beverage")),
                      );
                    },
                  ),
                  SpecialOfferCard(
                    image: 'assets/images/fi.jpeg',
                    category: "Fashion Items",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                categoryScreen(category: "Fashion Items")),
                      );
                    },
                  ),
                  SpecialOfferCard(
                    image: 'assets/images/h&l.jpg',
                    category: "Home & Lifestyle",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                categoryScreen(category: "Home & Lifestyle")),
                      );
                    },
                  ),
                  SizedBox(width: (20)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SpecialOfferCardFull extends StatelessWidget {
  const SpecialOfferCardFull({
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  });

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: (10), bottom: 10),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: (700),
          height: (100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                new Positioned.fill(
                  child: Image.asset(
                    image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.7),
                        Color(0xFF343434).withOpacity(0.18),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: (15.0),
                    vertical: (10),
                  ),
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: "$category\n",
                            style: TextStyle(
                              fontSize: (18),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
