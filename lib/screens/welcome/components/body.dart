import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Image(
                  height: MediaQuery.of(context).size.height * 0.12,
                  image: AssetImage(
                    'assets/logo-low-bgless.png',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image(
                  height: MediaQuery.of(context).size.height * 0.4,
                  image: AssetImage(
                    'assets/illuone-dark.png',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(242, 104, 55, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 15.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                ),
              ),
              // Container(
              //   width: 150,
              //   height: 50,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(25),
              //       color: Colors.green),
              //   child: TextButton(
              //       onPressed: () {
              //         Navigator.pushNamed(context, '/admin');
              //       },
              //       child: Text(
              //         "Admin",
              //         style: TextStyle(color: Colors.white, fontSize: 20),
              //       )),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
