import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromRGBO(242, 104, 55, 1);
const kPrimaryLightColor = Color.fromRGBO(54, 154, 159, 1);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF169E9E);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

//THIS CODE WILL RETURN USER TO THE DESIGNATED SCREEN AND KILL ALL OTHER SCREENS FROM STACK
// onPressed: () {
//                 Navigator.of(context).pushNamedAndRemoveUntil(
//                     '/welcome', (Route<dynamic> route) => false);
//               },