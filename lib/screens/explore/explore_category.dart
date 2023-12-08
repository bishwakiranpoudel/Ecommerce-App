import 'package:batuwa/screens/category/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:batuwa/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ExploreCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _fireStore = FirebaseFirestore.instance;
    Future<int> getData(String a) async {
      // Get docs from collection reference
      QuerySnapshot querySnapshot = await _fireStore
          .collection('item')
          .where('category', isEqualTo: a)
          .get();

      // Get data from docs and convert map to List
      final no = await querySnapshot.docs.length;
      print(a);
      print(no);
      //for a specific field

      return await no;
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text("Batuwa Products & Services",
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(fontSize: 18, color: kPrimaryColor),
                )),
          ),
          SizedBox(height: (20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpecialOfferCardFull(
                image: 'assets/images/bhs.jpg',
                category: "BATUWA HOME SERVICES",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            categoryScreen(category: "Batuwa Home Services")),
                  );
                },
              ),
              SizedBox(width: (20)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpecialOfferCard(
                image: 'assets/images/food.jpg',
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
                image: 'assets/images/grocery.jpg',
                category: "Grocery Items",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            categoryScreen(category: "Grocery Items")),
                  );
                },
              ),
              SizedBox(width: (20)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpecialOfferCard(
                image: 'assets/images/electric.jpg',
                category: "Electric Items",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            categoryScreen(category: "Electric Items")),
                  );
                },
              ),
              SpecialOfferCard(
                image: 'assets/images/fruit.jpg',
                category: "Vegetables and Fruits",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            categoryScreen(category: "Vegetables and Fruits")),
                  );
                },
              ),
              SizedBox(width: (20)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpecialOfferCard(
                image: 'assets/images/appliances.jpg',
                category: "Home Appliances",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            categoryScreen(category: "Home Appliances")),
                  );
                },
              ),
              SpecialOfferCard(
                image: 'assets/images/h&b.jpg',
                category: "Health & Beauty",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            categoryScreen(category: "Health & Beauty")),
                  );
                },
              ),
              SizedBox(width: (20)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpecialOfferCard(
                image: 'assets/images/b&t.jpg',
                category: "Babies and Toys",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            categoryScreen(category: "Babies & Toys")),
                  );
                },
              ),
              SpecialOfferCard(
                image: 'assets/images/p&a.jpg',
                category: "Pets & Accesories",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            categoryScreen(category: "Pets & Accessories")),
                  );
                },
              ),
              SizedBox(width: (20)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpecialOfferCard(
                image: 'assets/images/sport.jpg',
                category: "Sporting Items",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            categoryScreen(category: "Sporting Items")),
                  );
                },
              ),
              SpecialOfferCard(
                image: 'assets/images/stat.jpg',
                category: "Stationary Items",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            categoryScreen(category: "Stationary Items")),
                  );
                },
              ),
              SizedBox(width: (20)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpecialOfferCard(
                image: 'assets/images/med.jpeg',
                category: "Medical Supplies",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            categoryScreen(category: "Medical Supplies")),
                  );
                },
              ),
              SpecialOfferCard(
                image: 'assets/images/am.jpg',
                category: "Automobiles",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            categoryScreen(category: "Automobiles")),
                  );
                },
              ),
              SizedBox(width: (20)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpecialOfferCard(
                image: 'assets/images/hard.jpg',
                category: "Hardware Items",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            categoryScreen(category: "Hardware Items")),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpecialOfferCard(
                image: 'assets/images/f&p.jpg',
                category: "Flower & Plastic",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            categoryScreen(category: "Flower & Plastic")),
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
              SizedBox(width: (20)),
            ],
          ),
        ],
      ),
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    required this.category,
    required this.image,
    required this.press,
  });

  final String category, image;

  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("item")
            .where('category', isEqualTo: category)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          var ds = snapshot.data!.docs;

          return Padding(
            padding: EdgeInsets.only(left: (10), bottom: 10),
            child: GestureDetector(
              onTap: press,
              child: SizedBox(
                width: (170),
                height: (100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      new Positioned.fill(
                        child: Image.asset(
                          image,
                          fit: BoxFit.fill,
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
                              if (ds.length.toString() == '1')
                                TextSpan(text: ds.length.toString() + " item")
                              else if (ds.length.toString() == '0')
                                TextSpan(text: "Nothing Available")
                              else
                                TextSpan(text: ds.length.toString() + " items")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class SpecialOfferCardFull extends StatelessWidget {
  const SpecialOfferCardFull({
    required this.category,
    required this.image,
    required this.press,
  });

  final String category, image;

  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("item")
            .where('category', isEqualTo: category)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          var ds = snapshot.data!.docs;

          return Padding(
            padding: EdgeInsets.only(left: (10), bottom: 10),
            child: GestureDetector(
              onTap: press,
              child: SizedBox(
                width: (340),
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
        });
  }
}
