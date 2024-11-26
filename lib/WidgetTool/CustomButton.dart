
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final VoidCallback? onTap; // Callback function for button press
  final String text; // Text parameter
  final double? txtSize;

  const CustomButton({
    Key? key,
    this.onTap,
    this.text = 'Okay', // Default text
    this.txtSize = 17,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap, // Use the provided callback
      child: SizedBox(
        height: width>500?50:40,
        width: width>500?100:70,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff4b66d9), Color(0xff4967d9), Color(0xff1d2e8a)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width * 0.92,
          height: 50,
          child: Center(
            child: Text(
              text, // Use the provided text
              style: TextStyle(
                color: Colors.white, // Fixed text color
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton2 extends StatelessWidget {
  final VoidCallback? onTap; // Callback function for button press
  final String text; // Text parameter
  final double? txtSize;

  const CustomButton2({
    Key? key,
    this.onTap,
    this.text = 'Cancel', // Default text
    this.txtSize=17,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Use the provided callback
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff42ade3), Color(0xff41ace2), Color(0xff4869dd)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.92,
        height: 50,
        child: Center(
          child: Text(
            text, // Use the provided text
            style: TextStyle(
              color: Colors.white, // Fixed text color
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
