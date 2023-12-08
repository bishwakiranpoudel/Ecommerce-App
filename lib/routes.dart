import 'package:batuwa/screens/home/home-screen.dart';
import 'package:batuwa/screens/profile/profile.dart';
import 'package:batuwa/screens/support/AboutPage.dart';
import 'package:batuwa/screens/support/support&help.dart';
import 'package:batuwa/screens/welcome/welcome.dart';
import 'package:batuwa/screens/wrapper.dart';
import 'package:batuwa/screens/HomeWrapper.dart';
import 'package:batuwa/screens/explore/explore.dart';
import 'package:batuwa/screens/cart/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/widgets.dart';
import 'package:batuwa/screens/welcome/sign-in/sign-in.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => Wrapper(),
  '/homeWrapper': (context) => HomeWrapper(),
  '/welcome': (context) => WelcomeScreen(),
  //'/otp': (context) => OTPScreen(),
  '/home': (context) => HomeScreen(),
  '/explore': (context) => ExploreScreen(),
  // '/admin': (context) => Admin(),
  // '/addproduct': (context) => AddItem(),
  // '/addtrending': (context) => AddPopularProducts(),
  '/signin': (context) => LoginScreen(),
  '/account': (context) => ProfileList(
        onInit: () {},
      ),
  '/help': (context) => SupportAndHelpPage(),
  '/about': (context) => AboutPage(),
  '/cart': (context) =>
      cartScreen(uid: FirebaseAuth.instance.currentUser!.uid.toString()),
  //'/cart': (context) => cartScreen(uid: uid),
  // '/myOrder': (context) => MyOrderScreen(uid: uid),
};
