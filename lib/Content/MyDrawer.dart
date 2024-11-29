import 'package:bittudev/util/user__repository.dart';
import 'package:flutter/material.dart';
import '../Constant/ConstColor.dart';
import '../WidgetTool/navbarListTool.dart';
import '../controllers/auth_service.dart';

var myDrawer = (BuildContext context) => Drawer(
  backgroundColor: navbarColor,
  elevation: 0,
  child: Column(
    children: [
      // Drawer Header with circular logo
      DrawerHeader(
        child: Center(
          child: Container(
            width: 120,  // Set the width of the circle
            height: 120, // Set the height (same as width for a circle)
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,  // Circular shape
              image: DecorationImage(
                image: AssetImage('assets/logo.png'), // Replace with your logo path
                fit: BoxFit.cover, // Ensures the image fits within the circle
              ),
            ),
          ),
        ),
      ),
      // Menu items
      ClipOval(child: Navbarlisttool(name: 'D A S H B O A R D', icon: Icons.home,)),
      ClipOval(child: Navbarlisttool(name: 'S E R V I C E S', icon: Icons.miscellaneous_services,)),
      ClipOval(child: Navbarlisttool(name: 'A B O U T S', icon: Icons.person,)),
      ClipOval(child: Navbarlisttool(name: 'C O N T A C T S', icon: Icons.call,)),
      ClipOval(child: Navbarlisttool(name: 'A C C O U N T ', icon: Icons.account_circle,)),
     UserRepository.getLoginState()? ClipOval(child: Navbarlisttool(name: 'L O G O U T', icon: Icons.logout,callback:()async{
        await AuthService.logout();
        UserRepository.doLogout();
        Navigator.pushReplacementNamed(context, '/');
      },)):new Container(),
    ],
  ),
);
