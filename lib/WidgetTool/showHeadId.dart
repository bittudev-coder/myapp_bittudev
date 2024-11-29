import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  CustomContainer({
    Key? key,
   required this.text, // You can now pass IconData instead of an Icon widget
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130, // Width of the container
      height: 50, // Height of the container
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(12), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Shadow color
            blurRadius: 8, // Soft blur radius
            offset: Offset(4, 4), // Shadow position
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Profile Image/Icon
          ClipRRect(
            borderRadius: BorderRadius.circular(10), // Rounded corners for image
            child: Image.asset(
              'assets/logo.png', // Add your image path here
              width: 40, // Width of the profile image
              height: 40, // Height of the profile image
              fit: BoxFit.cover, // Makes sure the image fits well
            ),
          ),
          SizedBox(width: 10), // Space between image and text
          // Email Text
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Email", // Label text
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  text, // Email text
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  overflow: TextOverflow.ellipsis, // Ensures long email doesn't overflow
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
