import 'dart:async';
import 'package:batuwa/constants.dart';
import 'package:batuwa/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_version/new_version.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;
  bool go = true;

  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
        go = false;
      } else {
        print('User is signed in!');
        go = true;
      }
    });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Batuwa',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.cyan,
        primaryColor: Color.fromRGBO(242, 104, 55, 1),
      ),
      routes: routes,
      // initialRoute: go == false ? WelcomeScreen.id : HomeScreen.id,
      // routes: {
      //   WelcomeScreen.id: (context) => WelcomeScreen(),
      //   HomeScreen.id: (context) => HomeScreen(),
      // },
      // home: HomeScreen(),
    );
  }
}
//asdfasdfafds
//changes
