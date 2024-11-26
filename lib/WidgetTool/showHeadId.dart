import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  CustomContainer({
    Key? key,
   required this.text, // You can now pass IconData instead of an Icon widget
  });

  @override
  Widget build(BuildContext context) {
    return Container(// Height of the container
      decoration: BoxDecoration(
        color: Colors.blueAccent, // Background color of the container
        borderRadius: BorderRadius.circular(8), // Rounded corners for the container
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Align children to the start (left)
        crossAxisAlignment: CrossAxisAlignment.center, // Align vertically centered
        children: [
          // Icon (person icon)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 12, // Radius of the icon
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blueAccent),
            ),
          ),

          // Email Text
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Text(
              text.substring(5, 15), // Get only the first 15 characters
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
