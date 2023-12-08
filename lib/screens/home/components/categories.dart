import 'package:batuwa/screens/category/category.dart';
import 'package:flutter/material.dart';
import 'package:batuwa/constants.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryCard extends StatelessWidget {
  // const CategoryCard({
  //   // required Key key,
  //   required this.icon,
  //   required this.text,
  //   required this.press,
  // });

  // final String icon, text;
  // final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
              child: Text("Categories",
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(fontSize: 18, color: kPrimaryColor),
                  )),
            ),
            Spacer(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 50,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0x34FF7543),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => categoryScreen(
                                      category: "Food and Beverage")),
                            );
                          },
                          icon: Image(
                            image: AssetImage('assets/caticon/foods.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Food & Beverage",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[800]),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 50,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0x34FF7543),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => categoryScreen(
                                      category: "Grocery Items")),
                            );
                          },
                          icon: Image(
                            image: AssetImage('assets/caticon/grocery.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Grocery Items",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[800]),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 50,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0x34FF7543),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => categoryScreen(
                                      category: "Electric Items")),
                            );
                          },
                          icon: Image(
                            image: AssetImage('assets/caticon/electric2.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Electric Items",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[800]),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 50,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0x34FF7543),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => categoryScreen(
                                        category: "Vegetables and Fruits")),
                              );
                            },
                            icon: Image(
                              image: AssetImage('assets/caticon/veggies.png'),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Veggies & Fruits",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[800]),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 50,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0x34FF7543),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => categoryScreen(
                                      category: "Home Appliances")),
                            );
                          },
                          icon: Image(
                            image: AssetImage('assets/caticon/electric.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Home Applia..",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[800]),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 50,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0x34FF7543),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => categoryScreen(
                                      category: "Health & Beauty")),
                            );
                          },
                          icon: Image(
                            image: AssetImage('assets/caticon/beauty.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Health & Beauty",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[800]),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 50,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0x34FF7543),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => categoryScreen(
                                      category: "Babies & Toys")),
                            );
                          },
                          icon: Image(
                            image: AssetImage('assets/caticon/toy.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Babies & Toys",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[800]),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 50,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0x34FF7543),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => categoryScreen(
                                      category: "Pets & Accessories")),
                            );
                          },
                          icon: Image(
                            image: AssetImage('assets/caticon/pets.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Pets & Access...",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[800]),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 50,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0x34FF7543),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => categoryScreen(
                                      category: "Sporting Items")),
                            );
                          },
                          icon: Image(
                            image: AssetImage('assets/caticon/sport.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Sporting Items",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[800]),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 58,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0x34FF7543),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => categoryScreen(
                                      category: "Stationary Items")),
                            );
                          },
                          icon: Image(
                            image: AssetImage('assets/caticon/stationary.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Stationary Items",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[800]),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 50,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0x34FF7543),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => categoryScreen(
                                      category: "Medical Supplies")),
                            );
                          },
                          icon: Image(
                            image: AssetImage('assets/caticon/medical.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Medical Supplies",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[800]),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0x34FF7543),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      categoryScreen(category: "Automobiles")),
                            );
                          },
                          icon: Image(
                            image: AssetImage('assets/caticon/automobiles.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Auto-\nmobiles",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[800]),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 58,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0x34FF7543),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => categoryScreen(
                                      category: "Hardware Items")),
                            );
                          },
                          icon: Image(
                            image: AssetImage('assets/caticon/hardware.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Hardware Items",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[800]),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 50,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0x34FF7543),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => categoryScreen(
                                      category: "Home & Lifestyle")),
                            );
                          },
                          icon: Image(
                            image: AssetImage('assets/caticon/lifestyle.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Home & Lifestyle",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[800]),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Container(
                      width: 108,
                      decoration: BoxDecoration(
                          color: Color(0x34FF7543),
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => categoryScreen(
                                    category: "Batuwa Home Services")),
                          );
                        },
                        icon: Image(
                          image: AssetImage('assets/caticon/home.png'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "Batuwa Home Services",
                        style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 50,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0x34FF7543),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => categoryScreen(
                                        category: "Flower & Plastic")),
                              );
                            },
                            icon: Image(
                              image: AssetImage('assets/caticon/flowers.png'),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Flower & Plastic",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[800]),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 50,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0x34FF7543),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => categoryScreen(
                                      category: "Fashion Items")),
                            );
                          },
                          icon: Image(
                            image: AssetImage('assets/caticon/fashion.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Fashion Items",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[800]),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
