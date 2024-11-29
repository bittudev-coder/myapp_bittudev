import 'dart:convert';
import 'package:bittudev/responsive/desktop_body.dart';
import 'package:bittudev/responsive/mobile_body.dart';
import 'package:bittudev/responsive/tablet_body.dart';
import 'package:bittudev/responsive_layout.dart';
import 'package:bittudev/util/const_repo.dart';
import 'package:bittudev/util/user__repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/auth_service.dart';
import 'controllers/notification_service.dart';
import 'firebase_options.dart';
import 'views/home_page.dart';
import 'views/login_page.dart';
import 'views/message.dart';
import 'views/signup_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// function to listen to background changes


// to handle notification on foreground on web platform
void showNotification({required String title, required String body}) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"))
      ],
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await UserRepository.init();
  runApp(const MyApp());
}






class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BittuDev - Freelance Software & App Development',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      routes: {
        "/": (context) => ResponsiveLayout(
          mobileBody: const MobileScaffold(),
          tabletBody:  const TabletScaffold(),
          desktopBody: const DesktopScaffold(),
        ),
        "/signup": (context) => SignUpPage(),
        "/login": (context) => LoginPage(),
        "/message": (context) => Message()
      },
    );
  }
}



