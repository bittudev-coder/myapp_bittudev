import 'package:flutter/material.dart';

class MyBox extends StatelessWidget {
  final String imageurl; // Declare the imageurl as a final field

  // Constructor with required parameter
  MyBox({required this.imageurl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[400],
        ),
        child: Image.asset(imageurl,fit: BoxFit.cover,),  // Use imageurl as the asset path
      ),
    );
  }
}
