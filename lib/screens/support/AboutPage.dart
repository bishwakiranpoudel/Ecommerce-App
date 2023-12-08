import 'package:batuwa/constants.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);
  void _showPrivacyPolicyDialog() {
    DraggableScrollableSheet(builder: (context, scrollController) {
      return SingleChildScrollView(
        child: Text("hey"),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
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
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Image(
                      height: MediaQuery.of(context).size.height * 0.1,
                      image: AssetImage(
                        'assets/logo-low-bgless.png',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Text("Batuwa",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.oswald(
                          textStyle:
                              TextStyle(color: Colors.teal, fontSize: 25),
                        )),
                  ),
                  Text("Version 1.0.3",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.oswald(
                        textStyle: TextStyle(color: Colors.orange[900]),
                      )),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 8),
                child: Text('About Batuwa',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(color: Colors.black54, fontSize: 16),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: RichText(
                  textAlign: TextAlign.justify,
                  softWrap: true,
                  text: TextSpan(
                    // style: TextStyle(color: Colors.red),
                    /*defining default style is optional */
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              '"Batuwa - At Your Doorstep" is the wing organization under Dreams Group of Company that is an online-powered home services platform of Province 1, Nepal. The platform helps costumers to book reliable home services and experience incredible online shopping.',
                          style: GoogleFonts.openSans(color: Colors.black87)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text(
                        "Batuwa's data is stored on powerful LinkBinary servers that are geographically cached over the globe, ensuring incredibly fast order cycle for the end users on most secured way possible."),
                    Text(
                        "LinkBinary stores user-data collected by Batuwa on highly-secure servers at Google Data Center ensuring uncompromisable data safety."),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.teal[100],
                          borderRadius: BorderRadius.circular(25)),
                      width: 150,
                      child: TextButton.icon(
                        icon: Icon(
                          Icons.lock,
                          color: Colors.teal[700],
                        ),
                        label: Text(
                          'PRIVACY POLICY'.toUpperCase(),
                          style: TextStyle(color: Colors.teal[700]),
                        ),
                        onPressed: () async {
                          final url =
                              'https://linkbinary.com/clients/batuwa/privacy-policy';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            print("Can't hit link.");
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.teal[100],
                          borderRadius: BorderRadius.circular(25)),
                      width: 150,
                      child: TextButton.icon(
                        icon: FaIcon(
                          FontAwesomeIcons.clipboardCheck,
                          color: Colors.teal[700],
                        ),
                        label: Text(
                          'T&C'.toUpperCase(),
                          style: TextStyle(color: Colors.teal[700]),
                        ),
                        onPressed: () async {
                          final url =
                              'https://linkbinary.com/clients/batuwa/privacy-policy';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            print("Can't hit link.");
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              ExpandablePanel(
                header: Padding(
                  padding: const EdgeInsets.only(top: 12, left: 8),
                  child: Text('Developer Information',
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "The app is developed and powered by ",
                                    style: GoogleFonts.oswald(
                                        textStyle: TextStyle(
                                            color: Colors.red[900],
                                            fontSize: 18)),
                                    softWrap: true,
                                  ),
                                  Text(
                                    "LinkBinary ",
                                    style: GoogleFonts.oswald(
                                        textStyle: TextStyle(
                                            color: Colors.blue[900],
                                            fontSize: 19)),
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Image(
                                image: AssetImage('assets/lb-transparent.png'),
                                height: 50,
                              ),
                            ),
                          ],
                        ),
                        Text(
                            "Ran by an energetic team of passionate Devs and Execs, LinkBinary is Software company based at Birtamode, Jhapa whose primary vocation is on building any system with uncompromised data safety and quality assurance."),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    borderRadius: BorderRadius.circular(25)),
                                width: 110,
                                child: TextButton.icon(
                                  icon: Icon(
                                    Icons.web,
                                    color: Colors.blue[700],
                                  ),
                                  label: Text(
                                    'VISIT US'.toUpperCase(),
                                    style: TextStyle(color: Colors.blue[700]),
                                  ),
                                  onPressed: () async {
                                    final url = 'https://linkbinary.com';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      print("Can't hit link.");
                                    }
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(25)),
                                width: 110,
                                child: TextButton.icon(
                                  icon: Icon(
                                    Icons.phone_iphone,
                                    color: Colors.green[700],
                                  ),
                                  label: Text(
                                    'CALL US'.toUpperCase(),
                                    style: TextStyle(color: Colors.green[700]),
                                  ),
                                  onPressed: () async {
                                    final url = 'tel:9862775192';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      print("Can't call LB.");
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // tapHeaderToExpand: true,
                // hasIcon: true,
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
                        //     icon: FaIcon(
                        //       FontAwesomeIcons.phoneVolume,
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
      ),
    );
  }
}
