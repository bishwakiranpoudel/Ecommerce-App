import 'package:batuwa/constants.dart';
import 'package:batuwa/screens/home/home-screen.dart';
import 'package:batuwa/screens/profile/add_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen(this.phone);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      // appBar: AppBar(
      //   title: Text('OTP Verification'),
      // ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Image(
                height: MediaQuery.of(context).size.height * 0.15,
                image: AssetImage(
                  'assets/logo-low-bgless.png',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'The 6-Digit OTP is sent to +977-${widget.phone}.\nPlease check your SMS.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: kSecondaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Enter your OTP to continue.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: PinPut(
                fieldsCount: 6,
                textStyle: const TextStyle(fontSize: 25.0, color: Colors.black),
                eachFieldWidth: 40.0,
                eachFieldHeight: 55.0,
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                submittedFieldDecoration: pinPutDecoration.copyWith(
                  color: Color(0xFFDADADA),
                  border: Border.all(
                    width: 2,
                    color: kSecondaryColor,
                  ),
                ),
                selectedFieldDecoration: pinPutDecoration.copyWith(
                  color: Color(0xFFDADADA),
                  border: Border.all(
                    width: 0,
                    color: Color(0xFFDADADA),
                  ),
                ),
                followingFieldDecoration: pinPutDecoration.copyWith(
                  color: Color(0xFFDADADA),
                  border: Border.all(
                    width: 0,
                    color: Color(0xFFDADADA),
                  ),
                ),
                pinAnimationType: PinAnimationType.scale,
                onSubmit: (pin) async {
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: _verificationCode, smsCode: pin))
                        .then((value) async {
                      if (value.user != null) {
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => HomeScreen()),
                        //     (route) => false);
                        _profcheck(context);
                      }
                    });
                  } catch (e) {
                    // FocusScope.of(context).unfocus();
                    // _scaffoldkey.currentState
                    //     .showSnackBar(SnackBar(content: Text('invalid OTP')));
                  }
                },
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Wrong number?",
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 10),
            //   child: Countdown(
            //     duration: Duration(seconds: 30),
            //     onFinish: () {
            //       print('finished!');
            //     },
            //     builder: (BuildContext ctx, Duration remaining) {
            //       return Text(
            //         "Didn't get OTP? \nWait ${remaining.inSeconds} seconds to resend.",
            //         textAlign: TextAlign.center,
            //         style: TextStyle(color: kSecondaryColor),
            //       );
            //     },
            //   ),
            // ),
            DelayedDisplay(
              delay: Duration(seconds: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'RESEND',
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  _verifyPhone();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+977${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              _profcheck(context);
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(builder: (context) => HomeScreen()),
              //     (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 90));
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
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
    Fluttertoast.showToast(
        msg: "Logged in. Welcome to Batuwa!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  } else {
    Fluttertoast.showToast(
        msg: "Logged in. Enter your details.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => AddProf()), (route) => false);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => AddProf()),
    // );
  }
}
