import 'package:batuwa/screens/search/search.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _SearchFieldState extends State<SearchField> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: TextField(
            controller: myController,
            textInputAction: TextInputAction.go,
            onSubmitted: (value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        searchScreen(name: myController.text)),
              );
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search Batuwa",
                suffixIcon: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              searchScreen(name: myController.text)),
                    );
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
