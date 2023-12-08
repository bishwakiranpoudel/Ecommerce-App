import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:batuwa/api/firebase_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
// Import the firebase_core and cloud_firestore plugin

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants.dart';

class EditProf extends StatefulWidget {
  EditProf({
    Key? key,
    required this.doc,
    required this.image,
    required this.name,
    required this.address,
    required this.phone,
  }) : super(key: key);
  final String doc;
  final String image;
  final String name;
  final String address;
  final String phone;

  @override
  _EditProfState createState() => _EditProfState();
}

class _EditProfState extends State<EditProf> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool _nameValidate = false;
  bool _addressValidate = false;
  bool _phoneValidate = false;
  bool _photoValidate = false;
  bool _errorColor = true;
  UploadTask? task;

  File? file;

  String name = '';

  String address = '';

  String phoneno = '';

  String userid = '';

  String dp = '';
  String url = '';

  @override
  Widget build(BuildContext context) {
    name = widget.name;
    address = widget.address;
    phoneno = widget.phone;

    final User? user = FirebaseAuth.instance.currentUser;
    final String userid = user!.uid.toString();
    // Create a CollectionReference called users that references the firestore collection
    final fileName = file != null ? basename(file!.path) : 'No Image Selected';
    CollectionReference item = FirebaseFirestore.instance.collection('prof');

    Future uploadFile() async {
      if (file == null) {
        dp = widget.image;
      } else {
        final fileName = basename(file!.path);
        final destination = 'files/$fileName';

        task = FirebaseApi.uploadFile(destination, file!);
        setState(() {});

        if (task == null) return;

        final snapshot = await task!.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();
        dp = urlDownload;
      }

      return FirebaseFirestore.instance
          .collection("prof")
          .doc(widget.doc)
          .update({
            'name': name, // John Doe
            'address': address, // Stokes and Sons
            'phone': phoneno,
            'uid': userid,
            'image': dp,
            // 42
          })
          .then((value) => print("Profile Added"))
          .catchError((error) => print("Failed to add profile: $error"));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            // color: Colors.black26
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Column(
          children: [
            Text('Edit Your Details'),
            // Text(
            //   "${demoCarts.length} items",
            //   style: Theme.of(context).textTheme.caption,
            // ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Name",
                      style: GoogleFonts.oswald(
                        textStyle:
                            TextStyle(fontSize: 18, color: kSecondaryColor),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: TextField(
                        onChanged: (val) {
                          name = val;
                        },
                        style: TextStyle(color: Color(0xFF202020)),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            filled: true,
                            fillColor: Color(0xFFE6E6E6),
                            hintText: 'Your name',
                            hintStyle: TextStyle(color: Color(0xFF656565)),
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
                        controller: TextEditingController(text: widget.name),
                      )),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      "Address",
                      style: GoogleFonts.oswald(
                        textStyle:
                            TextStyle(fontSize: 18, color: kSecondaryColor),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: TextField(
                        onChanged: (val) {
                          address = val;
                        },
                        style: TextStyle(color: Color(0xFF202020)),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            filled: true,
                            fillColor: Color(0xFFE6E6E6),
                            hintText:
                                'Your full address i.e Rd. 1 Kirat Chowk, Birtamode, Jhapa',
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
                        controller: TextEditingController(text: widget.address),
                      )),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      "Phone",
                      style: GoogleFonts.oswald(
                        textStyle:
                            TextStyle(fontSize: 18, color: kSecondaryColor),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: TextField(
                        onChanged: (val) {
                          phoneno = val;
                        },
                        style: TextStyle(color: Color(0xFF202020)),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            filled: true,
                            fillColor: Color(0xFFE6E6E6),
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
                        controller: TextEditingController(text: widget.phone),
                        maxLength: 10,
                      )),
                ],
              ),
              ElevatedButton(
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
                    'UPDATE',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  uploadFile();
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                    msg: "Updating profile. Please wait..",
                    toastLength: Toast.LENGTH_SHORT,
                  );
                  Fluttertoast.showToast(
                    msg: "Profile updated.",
                    toastLength: Toast.LENGTH_SHORT,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );

    // return Scaffold(
    //   body: Padding(
    //     padding: const EdgeInsets.only(top: 60),
    //     child: Container(
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(15), color: Colors.grey[200]),
    //       height: 450,
    //       child: Column(
    //         children: [
    //           // TextButton(onPressed: uploadFile, child: Text('uploadfile')),
    //           Text("Name:"),
    //           TextField(
    //             onChanged: (val) {
    //               name = val;
    //             },
    //           ),
    //           Text("Address:"),
    //           TextField(
    //             onChanged: (val) {
    //               address = val;
    //             },
    //           ),
    //           // Text("UID:"),
    //           // TextField(
    //           //   onChanged: (val) {
    //           //     phoneno = val;
    //           //   },
    //           // ),

    //           Padding(
    //             padding: const EdgeInsets.all(5.0),
    //             child: Container(
    //               width: 200,
    //               decoration: BoxDecoration(
    //                   color: Colors.green,
    //                   borderRadius: BorderRadius.circular(25)),
    //               child: TextButton(
    //                   onPressed: selectFile,
    //                   child: Text(
    //                     'Select your Profile Picture',
    //                     style: TextStyle(color: Colors.white),
    //                   )),
    //             ),
    //           ),
    //           Container(
    //               width: 200,
    //               decoration: BoxDecoration(
    //                   color: Colors.orange,
    //                   borderRadius: BorderRadius.circular(25)),
    //               child: TextButton(
    //                   onPressed: () {
    //                     uploadFile();
    //                     Navigator.pushAndRemoveUntil(
    //                         context,
    //                         MaterialPageRoute(
    //                             builder: (context) => HomeScreen()),
    //                         (route) => false);
    //                   },
    //                   child: Text(
    //                     'CONTINUE',
    //                     style: TextStyle(color: Colors.white),
    //                   )))
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  Future selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result == null) {
      return;
    }
    final path = result.files.single.path!;
    setState(() => file = File(path));
  }
}
