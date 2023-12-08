import 'package:batuwa/screens/cart/cart.dart';
import 'package:batuwa/screens/explore/explore.dart';
import 'package:batuwa/screens/home/components/foryou.dart';
import 'package:batuwa/screens/home/components/imageslider.dart';
import 'package:batuwa/screens/home/components/special_foryou.dart';
import 'package:batuwa/screens/home/components/top_data.dart';
import 'package:batuwa/screens/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'all_products.dart';
import 'announcement_banner.dart';
import 'search_field.dart';
import 'categories.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:batuwa/constants.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  int _selectedIndex = 0;
  final List<Widget> _children = [
    Body(),
    ExploreScreen(),
    cartScreen(uid: FirebaseAuth.instance.currentUser!.uid.toString()),
    ProfileList(
      onInit: () {},
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 53,
        backgroundColor: Colors.white,
        color: kPrimaryColor,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.explore,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_cart_outlined,
            size: 25,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 25,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
      body: Center(
        child: _children.elementAt(_selectedIndex),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                // SearchField(),
                TopData(),
                AnnouncementBanner(),
                CategoryCard(),
                ISlider(),
                SpecialOffers(),
                ForyouScreen(),
                AllProducts(),
                // RecommendedScreen(category: 'shoes')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
