import 'package:batuwa/screens/home/components/search_field%20copy.dart';
import 'package:batuwa/screens/profile/profile.dart';
import 'package:batuwa/screens/support/AboutPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

class TopData extends StatelessWidget {
  const TopData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String uid = user!.uid.toString();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, left: 10, bottom: 10),
                      child: Text(
                        "Batuwa",
                        style: GoogleFonts.oswald(
                          textStyle:
                              TextStyle(fontSize: 32, color: kSecondaryColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 13.0, left: 5),
                      child: Text(
                        "At your Doorstep",
                        style: GoogleFonts.satisfy(
                            textStyle: TextStyle(
                                color: kPrimaryColor,
                                fontStyle: FontStyle.italic)),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Column(
              children: [
                // TextButton(onPressed: () {}, child: Icon(Icons.search)),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        // color: Color(0xFFE9E9E9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0, bottom: 0),
                            child: IconButton(
                              onPressed: () async {
                                final url = 'tel:023536360';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  print("Can't call Batuwa.");
                                }
                              },
                              icon: Image(
                                image: AssetImage('assets/icons/telephone.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
