import 'dart:async';

import 'package:batuwa/screens/profile/add_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home/home-screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    // _navigatetohome();
    startTimer();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Image(
                        height: MediaQuery.of(context).size.height * 0.14,
                        image: AssetImage(
                          'assets/logo-low-bgless.png',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Text('Version 1.0.3',
                        style: GoogleFonts.oswald(
                            textStyle: TextStyle(color: Colors.black54))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Image(
                      image: AssetImage('assets/lb-transparent.png'),
                      height: 55,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  startTimer() async {
    await Future.delayed(Duration(milliseconds: 2500));
    navigateUser();
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late StreamSubscription<User?> user;
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushNamed(context, '/welcome');
      } else {
        _profcheck(context);
        // Navigator.pushNamed(context, '/home');
      }
    });
    // var status = prefs.getBool('isLoggedIn') ?? false;
    // print(status);
    // if (status) {
    //   Navigator.pushNamed(context, '/home');
    // } else {
    //   Navigator.pushNamed(context, '/welcome');
    // }
  }
}

_profcheck(context) async {
  final User? user = FirebaseAuth.instance.currentUser;
  final String uid = user!.uid.toString();
  QuerySnapshot<Map<String, dynamic>> a = await FirebaseFirestore.instance
      .collection('prof')
      .where("uid", isEqualTo: uid)
      .get();
  if (a.docs.isNotEmpty) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  } else {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => AddProf()), (route) => false);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => AddProf()),
    // );
  }
}
