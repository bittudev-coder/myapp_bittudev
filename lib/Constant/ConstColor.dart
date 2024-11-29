import 'dart:ui';

import 'package:flutter/material.dart';

var defaultBackgroundColor = bodyColor;
var appBarColor = headColor;
var drawerTextColor = TextStyle(
  color: Colors.grey[600],
);



final bool colorDrak=true;
Color headColor = !colorDrak ?const Color(0xFFFB88F6): const Color(0xFF010718);
Color bodyColor = colorDrak ?const Color(0xFFE4E9F7):const Color(0xFF010718);
Color navbarColor = const Color(0xFF010718);




const Color MAPS_IMAGES_COLOR = Color(0xFF0a4349);

// class CustomColor {
//   static var primaryColor = MaterialColor(0xFF189ad3, color);
//   static var secondaryColor = Colors.white;
//   static var onColor = Colors.green;
//   static var offColor = Colors.grey;
//   static var backgroundOffColor=Color.fromARGB(255,241,225,225);
// }
//
// Map<int, Color> color = {
//   50: Color.fromRGBO(24, 154, 211, .1),
//   100: Color.fromRGBO(24, 154, 211, .2),
//   200: Color.fromRGBO(24, 154, 211, .3),
//   300: Color.fromRGBO(24, 154, 211, .4),
//   400: Color.fromRGBO(24, 154, 211, .5),
//   500: Color.fromRGBO(24, 154, 211, .6),
//   600: Color.fromRGBO(24, 154, 211, .7),
//   700: Color.fromRGBO(24, 154, 211, .8),
//   800: Color.fromRGBO(24, 154, 211, .9),
//   900: Color.fromRGBO(24, 154, 211, 1),
// };
//



// class CustomColor {
//   static var primaryColor = MaterialColor(0xFFc34343, color);
//   static var secondaryColor = Colors.white;
//   static var onColor = Colors.green;
//   static var offColor = Colors.grey;
//   static var backgroundOffColor=Color.fromARGB(255,241,225,225);
// }
//
// Map<int, Color> color = {
//   50: Color.fromRGBO( 195,67,67,.1),
//   100: Color.fromRGBO(195,67,67, .2),
//   200: Color.fromRGBO(195,67,67, .3),
//   300: Color.fromRGBO(195,67,67, .4),
//   400: Color.fromRGBO(195,67,67, .5),
//   500: Color.fromRGBO(195,67,67, .6),
//   600: Color.fromRGBO(195,67,67, .7),
//   700: Color.fromRGBO(195,67,67, .8),
//   800: Color.fromRGBO(195,67,67, .9),
//   900: Color.fromRGBO(195,67,67, 1),
// };




class CustomColor {
  static var primaryColor = MaterialColor(0xFFE4E9F7, color);
  static var secondaryColor = Colors.white;
  static var onColor = Colors.green;
  static var offColor = Colors.grey;
  static var backgroundOffColor=Colors.blue.shade50;
  static var ContainerColor=Colors.blue.shade50;
}

Map<int, Color> color = {
  50: Color.fromRGBO(228, 233, 247, .1), // 10% opacity
  100: Color.fromRGBO(228, 233, 247, .2), // 20% opacity
  200: Color.fromRGBO(228, 233, 247, .3), // 30% opacity
  300: Color.fromRGBO(228, 233, 247, .4), // 40% opacity
  400: Color.fromRGBO(228, 233, 247, .5), // 50% opacity
  500: Color.fromRGBO(228, 233, 247, .6), // 60% opacity
  600: Color.fromRGBO(228, 233, 247, .7), // 70% opacity
  700: Color.fromRGBO(228, 233, 247, .8), // 80% opacity
  800: Color.fromRGBO(228, 233, 247, .9), // 90% opacity
  900: Color.fromRGBO(228, 233, 247, 1),   // 100% opacity
};
