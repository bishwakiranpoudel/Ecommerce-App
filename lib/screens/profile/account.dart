import 'package:batuwa/screens/profile/add_profile.dart';
import 'package:batuwa/screens/welcome/welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

import '../../constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.onInit}) : super(key: key);
  final Function onInit;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _profile = true;
  FirebaseAuth auth = FirebaseAuth.instance;

  signOut() async {
    await _firebaseAuth.signOut();
    Navigator.pushNamed(context, WelcomeScreen.id);
  }

  void _profcheck() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String uid = user!.uid.toString();
    QuerySnapshot<Map<String, dynamic>> a = await FirebaseFirestore.instance
        .collection('prof')
        .where("uid", isEqualTo: uid)
        .get();
    if (widget.onInit == () {}) {
      widget.onInit();
    }
    super.initState();

    if (mounted) {
      setState(() {
        if (a.docs.isNotEmpty) {
          _profile = true;
        } else {
          _profile = false;
        }
      });
    }
  }

//
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String uid = user!.uid.toString();
    _profcheck();
    if (_profile = true) {
      return profile(uid: uid);
    } else {
      return Scaffold(body: AddProf());
    }
  }
}

class _firebaseAuth {
  static signOut() {}
}

class profile extends StatelessWidget {
  const profile({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    void logout() async {
      await FirebaseAuth.instance.signOut();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      setState() {}
      ;
    }

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("prof")
            .where('uid', isEqualTo: uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }

          // return ListView(children: snapshot.data.documents.map((document) {
          //   return Center(
          //     child: Container(
          //       child: Column(
          //         children: [
          //           Text(document['name']),
          //           Text(document['price']),
          //           Text(document['description']),
          //         ],
          //       ),
          //     ),
          //   );
          // }));
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  // color: Colors.black26
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              title: Text(
                'My Account',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              child: GridView.count(
                // childAspectRatio: 1.03 / 1.33,
                childAspectRatio: 1 / 1,
                physics: new NeverScrollableScrollPhysics(),
                crossAxisCount: 1,
                shrinkWrap: true,
                children: snapshot.data!.docs.map((doc) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Column(
                        children: [
                          Text('Name: ' + doc['name']),
                          Text('Address: ' + doc['address']),
                          Text('Phone: ' + doc['phone']),
                          SizedBox(
                            height: 115,
                            width: 115,
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(doc['image']),
                                ),
                                // Positioned(
                                //   right: -16,
                                //   bottom: 0,
                                //   child: SizedBox(
                                //     height: 46,
                                //     width: 46,
                                //     child: FlatButton(
                                //       shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(50),
                                //         side: BorderSide(color: Colors.white),
                                //       ),
                                //       color: Color(0xFFF5F6F9),
                                //       onPressed: () {},
                                //       child: SvgPicture.asset(
                                //           "assets/icons/Camera Icon.svg"),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                          //Image(image: NetworkImage(doc['image'])),
                          ElevatedButton(
                              onPressed: () {
                                logout();
                              },
                              child: Text('LOG OUT'))
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        });
  }
}
