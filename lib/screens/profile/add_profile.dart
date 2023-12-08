import 'dart:io';
import 'package:batuwa/screens/home/home-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:batuwa/api/firebase_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class AddProf extends StatefulWidget {
  AddProf();

  @override
  _AddProfState createState() => _AddProfState();
}

class _AddProfState extends State<AddProf> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool _nameValidate = false;
  bool _addressValidate = false;
  bool _phoneValidate = false;

  bool _errorColor = true;
  UploadTask? task;

  File? file;

  String name = '';

  String address = '';

  String phoneno = '';

  String userid = '';

  String dp = '';

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String userid = user!.uid.toString();
    // Create a CollectionReference called users that references the firestore collection

    CollectionReference item = FirebaseFirestore.instance.collection('prof');

    Future uploadFile() async {
      return item
          .add({
            'name': name,
            'address': address,
            'phone': phoneno,
            'uid': userid,
            'image':
                'https://firebasestorage.googleapis.com/v0/b/batuwa-app.appspot.com/o/files%2Favatar.png?alt=media&token=98b733b2-3087-4962-a4e4-8419066b97c6',
            // 42
          })
          .then((value) => print("Profile Added"))
          .catchError((error) => print("Failed to add profile: $error"));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, bottom: 50),
          child: Center(
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
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'ENTER YOUR DETAILS TO CONTINUE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      color: kSecondaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    'Info: The data you provide here will be used for your \nidentification during product delivery procedures.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Colors.black45,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 30, right: 10, left: 10),
                    child: TextField(
                      onChanged: (val) {
                        name = val;
                      },
                      style: TextStyle(color: Color(0xFF202020)),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          filled: true,
                          fillColor: Color(0xFFDADADA),
                          hintText: 'Your name',
                          hintStyle: TextStyle(color: Color(0xFF707070)),
                          focusColor: Color(0xFF202020),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          errorText: _nameValidate
                              ? 'You need to enter valid name to continue.'
                              : null,
                          errorStyle: TextStyle(
                            color: Colors.red,
                          )),
                      keyboardType: TextInputType.name,
                      controller: _nameController,
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: TextField(
                      onChanged: (val) {
                        address = val;
                      },
                      style: TextStyle(color: Color(0xFF202020)),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          filled: true,
                          fillColor: Color(0xFFDADADA),
                          hintText:
                              'Your full address i.e Kirat Chowk, Birtamode, Jhapa',
                          hintStyle: TextStyle(color: Color(0xFF707070)),
                          focusColor: Color(0xFF202020),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          errorText: _addressValidate
                              ? 'You need to enter valid address to continue.'
                              : null,
                          errorStyle: TextStyle(
                            color: Colors.red,
                          )),
                      keyboardType: TextInputType.streetAddress,
                      controller: _addressController,
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          onChanged: (val) {
                            phoneno = val;
                          },
                          style: TextStyle(color: Color(0xFF202020)),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              filled: true,
                              fillColor: Color(0xFFDADADA),
                              hintText: 'Your phone',
                              hintStyle: TextStyle(color: Color(0xFF707070)),
                              focusColor: Color(0xFF202020),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              errorText: _phoneValidate
                                  ? 'You need to enter valid phone number to continue.'
                                  : null,
                              errorStyle: TextStyle(
                                color: Colors.red,
                              )),
                          keyboardType: TextInputType.phone,
                          controller: _phoneController,
                          maxLength: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "NOTE: You will be called using this number during order verification. \nSo please use the number that is available to you.",
                            style: GoogleFonts.ptSans(
                                textStyle: TextStyle(
                              color: Colors.black45,
                              fontStyle: FontStyle.italic,
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: RichText(
                            text: new TextSpan(
                              children: [
                                new TextSpan(
                                  text:
                                      "By clicking 'CONTINUE', you are agreeing to our ",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                ),
                                new TextSpan(
                                  text: 'terms and conditions.',
                                  style: TextStyle(
                                      color: Colors.blue[500], fontSize: 12),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launch(
                                          'https://batuwa.linkbinary.com/batuwa-tc/');
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(25)),
                      child: TextButton(
                        onPressed: () {
                          if (_nameController.text.isEmpty) {
                            setState(() {
                              _nameValidate = true;
                            });
                          } else {
                            _nameValidate = false;
                          }
                          if (_addressController.text.isEmpty) {
                            setState(() {
                              _addressValidate = true;
                            });
                          } else {
                            _addressValidate = false;
                          }
                          if (_phoneController.text.length < 10 ||
                              _phoneController.text.isEmpty ||
                              !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                                  .hasMatch(_phoneController.text)) {
                            setState(() {
                              _phoneValidate = true;
                            });
                          } else {
                            _phoneValidate = false;
                          }

                          if (_nameValidate == false &&
                              _addressValidate == false &&
                              _phoneValidate == false) {
                            setState(() {
                              _errorColor = false;
                            });
                            uploadFile();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (route) => false);
                            Fluttertoast.showToast(
                              msg: "Logged in. Welcome to Batuwa!",
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          }
                        },
                        child: Text(
                          'CONTINUE',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
