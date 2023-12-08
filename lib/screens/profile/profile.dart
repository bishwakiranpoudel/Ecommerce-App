import 'package:batuwa/screens/profile/add_profile.dart';
import 'package:batuwa/screens/profile/edit_pp.dart';
import 'package:batuwa/screens/profile/edit_profile.dart';
import 'package:batuwa/screens/profile/myorders.dart';
import 'package:batuwa/screens/profile/profile_menu.dart';
import 'package:batuwa/screens/profile/edit_profile.dart';
import 'package:batuwa/screens/welcome/welcome.dart';
import 'package:batuwa/screens/wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants.dart';

class ProfileList extends StatefulWidget {
  const ProfileList({Key? key, required this.onInit}) : super(key: key);
  final Function onInit;

  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
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
    // super.initState();

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
      Fluttertoast.showToast(
        msg: "Logging out..",
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(pageBuilder: (BuildContext context,
              Animation animation, Animation secondaryAnimation) {
            return Wrapper();
          }, transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return new SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          }),
          (Route route) => false);
      await FirebaseAuth.instance.signOut();
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => WelcomeScreen()),
      //     (route) => false);
      // Navigator.pushAndRemoveUntil(
      //     context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
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
            body: SingleChildScrollView(
              child: Container(
                // color: kPrimaryColor,

                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  stops: [
                    0.035,
                    0.65,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFEE9944),
                    Colors.white12,
                  ],
                )),
                child: GridView.count(
                  childAspectRatio: 0.80 / 1.33,
                  physics: new NeverScrollableScrollPhysics(),
                  crossAxisCount: 1,
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((doc) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20),
                            Stack(
                              children: [
                                SizedBox(height: 8),
                                // Text(
                                //   'DELIVERY DETAILS',
                                //   style: TextStyle(
                                //       color: kPrimaryColor,
                                //       fontSize: 18,
                                //       fontWeight: FontWeight.w600),
                                // ),
                                Container(
                                  margin: EdgeInsets.only(top: 58, right: 0),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(250, 250, 250, 1),
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(60.0),
                                      )),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 60),
                                      Text(
                                        doc['name'].toUpperCase(),
                                        style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        doc['address'],
                                        style: TextStyle(
                                            color: kSecondaryColor,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        doc['phone'],
                                        style: TextStyle(
                                            color: kSecondaryColor,
                                            fontSize: 12),
                                      ),
                                      SizedBox(height: 18),
                                      ProfileMenu(
                                        text: "Edit Details",
                                        icon: "assets/icons/User Icon.svg",
                                        press: () => {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => EditProf(
                                                      image: doc['image'],
                                                      doc: doc.id,
                                                      name: doc['name'],
                                                      address: doc['address'],
                                                      phone: doc['phone'],
                                                    )),
                                          )
                                        },
                                      ),
                                      // ProfileMenu(
                                      //   text: "Notifications",
                                      //   icon: "assets/icons/Bell.svg",
                                      //   press: () {},
                                      // ),
                                      // ProfileMenu(
                                      //   text: "Settings",
                                      //   icon: "assets/icons/Settings.svg",
                                      //   press: () {},
                                      // ),

                                      ProfileMenu(
                                        text: "My Orders",
                                        icon: "assets/icons/Cart Icon.svg",
                                        press: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyOrderScreen(uid: uid)),
                                          );
                                        },
                                      ),

                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.start,
                                      //   children: [
                                      //     Padding(
                                      //       padding: const EdgeInsets.only(
                                      //           left: 25.0),
                                      //       child: Text(
                                      //         "Support",
                                      //         style: TextStyle(
                                      //             color: Colors.black87),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),

                                      ProfileMenu(
                                        text: "Support & Help",
                                        icon:
                                            "assets/icons/customer-service.svg",
                                        press: () {
                                          Navigator.pushNamed(context, '/help');
                                        },
                                      ),

                                      ProfileMenu(
                                        text: "About",
                                        icon: "assets/icons/info-new.svg",
                                        press: () {
                                          Navigator.pushNamed(
                                              context, '/about');
                                        },
                                      ),

                                      SizedBox(
                                        height: 40,
                                      ),

                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.orange[100],
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        width: 135,
                                        child: TextButton.icon(
                                          icon: Icon(
                                            Icons.logout_rounded,
                                            color: Colors.orange[700],
                                          ),
                                          label: Text(
                                            'Log Out'.toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.orange[700]),
                                          ),
                                          onPressed: () {
                                            logout();
                                          },
                                        ),
                                      ),

                                      SizedBox(
                                        height: 40,
                                      ),
                                    ],
                                  ),
                                ),

                                // SizedBox(height: 20),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 0.0,
                                      left: MediaQuery.of(context).size.width *
                                          0.37),
                                  height: 115,
                                  width: 115,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    fit: StackFit.expand,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Color.fromRGBO(
                                                  250, 250, 250, 1),
                                              width: 5),
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //       color: Colors.white54,
                                          //       blurRadius: 10.0,
                                          //       offset: Offset(0.0, 0.75))
                                          // ],
                                        ),
                                        child: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(doc['image']),
                                        ),
                                      ),
                                      Positioned(
                                        right: -16,
                                        bottom: 0,
                                        child: SizedBox(
                                          height: 46,
                                          width: 46,
                                          child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              side: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            color: Color(0xFFE7E7E7),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditPP(
                                                          image: doc['image'],
                                                          doc: doc.id,
                                                        )),
                                              );
                                              // selectFile;
                                            },
                                            child: SvgPicture.asset(
                                                "assets/icons/Camera Icon.svg"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        });
  }
}
