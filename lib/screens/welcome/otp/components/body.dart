import 'package:batuwa/constants.dart';
import 'package:batuwa/screens/profile/account.dart';
import 'package:batuwa/screens/profile/add_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class Body extends StatefulWidget {
  final String phone;
  Body(this.phone);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String _verificationCode;
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      //BackgroundImage(),
      Scaffold(
        backgroundColor: Colors.white70,
        body: Container(
          width: MediaQuery.of(context).size.width * 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Image(
                  height: MediaQuery.of(context).size.height * 0.15,
                  image: AssetImage(
                    'assets/logo-low-bgless.png',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Text(
                  'WELCOME BACK!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60, bottom: 10),
                child: Text(
                  'Enter your OTP to continue.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 30),
                child: Text(
                  'Check your SMS.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    color: kSecondaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: PinPut(
                  fieldsCount: 4,
                  withCursor: true,
                  textStyle:
                      const TextStyle(fontSize: 25.0, color: Colors.white),
                  eachFieldWidth: 40.0,
                  eachFieldHeight: 55.0,
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  submittedFieldDecoration: pinPutDecoration,
                  selectedFieldDecoration: pinPutDecoration,
                  followingFieldDecoration: pinPutDecoration,
                  pinAnimationType: PinAnimationType.fade,
                  onSubmit: (pin) {
                    _profcheck(context);
                  },
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.only(left: 60, right: 60),
              //   child: TextField(
              //     textAlignVertical: TextAlignVertical.center,
              //     textAlign: TextAlign.center,
              //     decoration: new InputDecoration(
              //       hintText: 'XXXXXX',
              //       alignLabelWithHint: true,
              //       contentPadding: EdgeInsets.all(10.0),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(20.0),
              //       ),
              //     ),
              //     maxLength: 6,
              //     keyboardType: TextInputType.number,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 50.0),
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       primary: kPrimaryColor,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(25),
              //       ),
              //       elevation: 15.0,
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(15.0),
              //       child: Text(
              //         'LOGIN',
              //         style: TextStyle(
              //           fontSize: 20,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //     onPressed: (pin) async {
              //       await FirebaseAuth.instance.signInWithCredential(
              //           PhoneAuthProvider.credential(
              //               verificationId: _verificationCode, smsCode: pin));
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    ]);
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+977${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              print('User logged in.');
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationID, int) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 60));
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => profile(uid: uid)),
    );
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProf()),
    );
  }
}
