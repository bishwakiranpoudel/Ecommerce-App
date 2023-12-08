import 'package:batuwa/constants.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportAndHelpPage extends StatelessWidget {
  const SupportAndHelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Support / Help Center"),
        backgroundColor: Colors.white24,
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 0),
                  child: Image(
                    height: MediaQuery.of(context).size.height * 0.1,
                    image: AssetImage(
                      'assets/support.png',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Text("BATUWA SUPPORT & HELP CENTER",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.oswald(
                        textStyle: TextStyle(color: Colors.teal, fontSize: 25),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(25)),
                  width: 135,
                  child: TextButton.icon(
                    icon: Icon(
                      Icons.call,
                      color: Colors.red[700],
                    ),
                    label: Text(
                      'Call Support'.toUpperCase(),
                      style: TextStyle(color: Colors.red[700]),
                    ),
                    onPressed: () async {
                      final url = 'tel:981-4043165';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        print("Can't call suport.");
                      }
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.all(5)),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(25)),
                  width: 135,
                  child: TextButton.icon(
                    icon: Icon(
                      Icons.mail,
                      color: Colors.green[700],
                    ),
                    label: Text(
                      'Mail Us'.toUpperCase(),
                      style: TextStyle(color: Colors.green[700]),
                    ),
                    onPressed: () async {
                      final toMail = 'support@batuwa.linkbinary.com';
                      final subject = 'New Batuwa Support';
                      final message = 'Message: ';
                      final url =
                          'mailto:$toMail?subject=${subject}&body=${message}';

                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        print("Can't call suport.");
                      }
                    },
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(5)),
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(25)),
              width: 135,
              child: TextButton.icon(
                icon: Icon(
                  Icons.replay_outlined,
                  color: Colors.blue[700],
                ),
                label: Text(
                  'UPDATE APP'.toUpperCase(),
                  style: TextStyle(color: Colors.blue[700]),
                ),
                onPressed: () async {
                  final url = 'https://batuwa.linkbinary.com';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    print("Can't hit update link.");
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Divider(color: Colors.black26),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Frequently Asked Questions",
                      style: GoogleFonts.oswald(
                        textStyle: TextStyle(color: Colors.teal, fontSize: 20),
                      ),
                    ),
                  ),
                  ExpandablePanel(
                    header: Padding(
                      padding: const EdgeInsets.only(top: 12, left: 8),
                      child: Text("How do I cancel my order?",
                          style: GoogleFonts.oswald(
                            textStyle:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          )),
                    ),
                    collapsed: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "",
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    expanded: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "You can cancel your orders from 'My Orders' section by hitting on (-) sign right of ordered item. The order could also be canceled on call from Batuwa Sales during verification. If the order is already verified or completed (delivered), you can't cancel it.",
                        softWrap: true,
                      ),
                    ),
                    // tapHeaderToExpand: true,
                    // hasIcon: true,
                  ),
                  ExpandablePanel(
                    header: Padding(
                      padding: const EdgeInsets.only(top: 12, left: 8),
                      child: Text('How does Batuwa Order Cycle work?',
                          style: GoogleFonts.oswald(
                            textStyle:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          )),
                    ),
                    collapsed: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "",
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    expanded: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Batuwa Order Cycle works in three steps:\n1. You order something from Batuwa considering succesfull checkout.\n2. Sales Assistants at Batuwa verify your order by calling you.\n(During verification, your order and delivery details are re-confirmed.)\n3. Batuwa will deliver your order at your preferred delivery location.",
                        softWrap: true,
                      ),
                    ),
                    // tapHeaderToExpand: true,
                    // hasIcon: true,
                  ),
                  ExpandablePanel(
                    header: Padding(
                      padding: const EdgeInsets.only(top: 12, left: 8),
                      child: Text('Can I get refund on faulty orders?',
                          style: GoogleFonts.oswald(
                            textStyle:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          )),
                    ),
                    collapsed: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "",
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    expanded: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "You will get refunds on orders that are faulted from Batuwa's end.",
                        softWrap: true,
                      ),
                    ),
                    // tapHeaderToExpand: true,
                    // hasIcon: true,
                  ),
                  ExpandablePanel(
                    header: Padding(
                      padding: const EdgeInsets.only(top: 12, left: 8),
                      child: Text(
                          "My order status says Verified but I didn't receive the order.",
                          style: GoogleFonts.oswald(
                            textStyle:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          )),
                    ),
                    collapsed: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "",
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    expanded: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "The delivery could take few hours upto several days depending on your location. Please call support if you didn't receive your order in time.",
                        softWrap: true,
                      ),
                    ),
                    // tapHeaderToExpand: true,
                    // hasIcon: true,
                  ),
                  ExpandablePanel(
                    header: Padding(
                      padding: const EdgeInsets.only(top: 12, left: 8),
                      child: Text("I can't see my processing/verified order.",
                          style: GoogleFonts.oswald(
                            textStyle:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          )),
                    ),
                    collapsed: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "",
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    expanded: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "If you don't see your orders that were still processing/verified, the order might have been canceled from your end or you contacted the Batuwa Sales in-order-to cancel the order. Please do check if you are logged in with same mobile number you ordered with.",
                        softWrap: true,
                      ),
                    ),
                    // tapHeaderToExpand: true,
                    // hasIcon: true,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Divider(color: Colors.black26),
                  Text(
                    "Follow us on social media!",
                    style: TextStyle(color: Colors.black54),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                          icon: FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blue[900],
                          ),
                          onPressed: () async {
                            final url =
                                'https://www.facebook.com/%E0%A4%AC%E0%A4%9F%E0%A5%81%E0%A4%B5%E0%A4%BE-At-Your-Door-step-109207091320344/';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              print("Can't launch Facebook.");
                            }
                          }),
                      // IconButton(
                      //     // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                      // icon: FaIcon(
                      //   FontAwesomeIcons.phoneVolume,
                      //       color: Colors.green[900],
                      //     ),
                      //     onPressed: () async {
                      //       final url = 'tel:981-4043165';
                      //       if (await canLaunch(url)) {
                      //         await launch(url);
                      //       } else {
                      //         print("Can't launch Facebook.");
                      //       }
                      //     }),
                    ],
                  ),
                  Divider(color: Colors.black26),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
