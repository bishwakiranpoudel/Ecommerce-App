import 'package:flutter/material.dart';

class ButtonContainer extends StatefulWidget {
  const ButtonContainer(
      {Key? key,
      required this.title,
      required this.onClick,
      required this.containerColor,
      required this.textColor})
      : super(key: key);
  final String title;
  final Function onClick;
  final Color containerColor;
  final Color textColor;

  @override
  _ButtonContainerState createState() => _ButtonContainerState();
}

class _ButtonContainerState extends State<ButtonContainer> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        widget.title,
        style: TextStyle(color: widget.textColor, fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
          primary: widget.containerColor, //background color of button
          side: BorderSide(
              width: 3,
              color: Color.fromRGBO(242, 104, 55, 1)), //border width and color
          elevation: 1, //elevation of button
          shape: RoundedRectangleBorder(
              //to set border radius to button
              borderRadius: BorderRadius.circular(30)),
          padding: EdgeInsets.symmetric(
              vertical: 20, horizontal: 100) //content padding inside button
          ),
      onPressed: () => widget.onClick(),
    );
  }
}

// InkWell(
//       child: Container(
//         padding: EdgeInsets.all(10),
//         width: MediaQuery.of(context).size.width * 0.72,
//         decoration: BoxDecoration(
//           color: widget.containerColor,
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         child: Center(
//           child: Text(
//             widget.title,
//             style: TextStyle(
//               color: widget.textColor,
//               fontSize: 30,
//             ),
//           ),
//         ),
//       ),
//       onTap: () => widget.onClick(),
//     );
