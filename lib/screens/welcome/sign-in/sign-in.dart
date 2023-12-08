import 'package:batuwa/constants.dart';
import 'package:batuwa/screens/welcome/otp/otp.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Phone Auth'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
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
                'START SHOPPING RIGHT AWAY!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: kSecondaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 0),
              child: Text(
                'Enter your phone number to continue.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: kPrimaryColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40, right: 10, left: 10),
              child: TextField(
                style: TextStyle(color: Color(0xFF202020)),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    filled: true,
                    fillColor: Color(0xFFDADADA),
                    hintText: 'Your number',
                    hintStyle: TextStyle(color: Color(0xFF707070)),
                    focusColor: Color(0xFF202020),
                    prefix: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        '+977',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    errorText: _validate
                        ? 'You need to enter valid phone number.'
                        : null,
                    errorStyle: TextStyle(
                      color: Colors.red,
                    )),
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: _controller,
              ),
            )
          ]),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 8.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'GET OTP',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: () {
                if (_controller.text.isEmpty ||
                    !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                        .hasMatch(_controller.text)) {
                  setState(() {
                    _validate = true;
                  });
                } else if (_controller.text.length < 10) {
                  setState(() {
                    _validate = true;
                  });
                } else {
                  setState(() {
                    _validate = false;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OTPScreen(_controller.text)));
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
