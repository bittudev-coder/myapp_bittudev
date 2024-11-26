import 'package:flutter/material.dart';

class Navbarlisttool extends StatelessWidget {
  final String name; // Declare the name as a final field
  final VoidCallback? callback; // Nullable callback, update type to VoidCallback for better function signature
  final IconData icon; // Changed to IconData for flexibility, now you pass an icon's data instead of an Icon widget

  // Constructor with required parameters
  Navbarlisttool({
    required this.name,
    this.callback, // Make callback nullable
    required this.icon, // You can now pass IconData instead of an Icon widget
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Padding to match the tilePadding equivalent
          child: ListTile(
            onTap: callback, // It will be null safe, callback will not run if null
            leading: Icon(icon, color: Colors.white), // Use IconData for the icon
            title: Text(
              name,
              style: TextStyle(color: Colors.white), // Customize text style as required
            ),
          ),
        ),
        Divider(thickness: 1),
      ],
    );
  }
}
