import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:batuwa/api/firebase_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
// Import the firebase_core and cloud_firestore plugin

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants.dart';

class EditPP extends StatefulWidget {
  EditPP({
    Key? key,
    required this.doc,
    required this.image,
  }) : super(key: key);

  final String image;
  final String doc;

  @override
  _EditPPState createState() => _EditPPState();
}

class _EditPPState extends State<EditPP> {
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
            Text('Edit Profile Picture'),
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
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Update Your Profile Picture',
                  style: TextStyle(color: Colors.black45),
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     shape: BoxShape.circle,
              //     boxShadow: [
              //       BoxShadow(
              //           color: Colors.white54,
              //           blurRadius: 10.0,
              //           offset: Offset(0.0, 0.75))
              //     ],
              //   ),
              //   child: CircleAvatar(
              //     backgroundImage: NetworkImage(doc['image']),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(25)),
                  child: IconButton(
                      onPressed: selectFile,
                      icon: Icon(
                        Icons.upload,
                        size: 25,
                        color: Colors.blue,
                      )
                      // child: Text(
                      //   'Select Your Profile Picture',
                      //   style: TextStyle(color: Colors.blue),
                      // )
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 11.0),
                child: Text(
                  fileName,
                  style: TextStyle(
                      color: _errorColor == true ? Colors.green : Colors.green),
                ),
              ),
              // Container(
              //   child: TextButton(
              //     child: Text('update'),
              //     onPressed: uploadFile,
              //   ),
              // ),
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
                    msg:
                        "Profile updated. It may take few seconds to update your image.",
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
