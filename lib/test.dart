import 'package:flutter/material.dart';

class CustomContainer1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          width: 200, // Width of the container
          height: 100, // Height of the container
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon/Image
              CircleAvatar(
                radius: 24, // Icon/Image size
                backgroundColor: Colors.blueAccent, // Background for the icon
                child: Icon(
                  Icons.email, // Email icon
                  color: Colors.white,
                  size: 28,
                ),
              ),
              SizedBox(width: 16), // Space between icon and email
              // Email Text
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Email", // Placeholder
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "example@email.com", // Replace with actual email
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

