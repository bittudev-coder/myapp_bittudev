import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'controllers/auth_service.dart';
import 'controllers/notification_service.dart';
import 'main.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileBody;
  final Widget tabletBody;
  final Widget desktopBody;

  ResponsiveLayout({
    required this.mobileBody,
    required this.tabletBody,
    required this.desktopBody,
  });

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  bool isLoggedIn = false;
  String? email;


  Future _firebaseBackgroundMessage(RemoteMessage message) async {
    if (message.notification != null) {
      print("Some notification Received in background...");
    }
  }

  Future<void> _initializeApp() async {
    await PushNotifications.init();

    if (!kIsWeb) {
      await PushNotifications.localNotiInit();
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        print("Background Notification Tapped");
        navigatorKey.currentState!.pushNamed("/message", arguments: message);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String payloadData = jsonEncode(message.data);
      print("Got a message in foreground");
      if (message.notification != null) {
        if (kIsWeb) {
          showNotification(
              title: message.notification!.title!,
              body: message.notification!.body!);
        } else {
          PushNotifications.showSimpleNotification(
              title: message.notification!.title!,
              body: message.notification!.body!,
              payload: payloadData);
        }
      }
    });

    final RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      print("Launched from terminated state");
      Future.delayed(Duration(seconds: 1), () {
        navigatorKey.currentState!.pushNamed("/message", arguments: message);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeApp();
    AuthService.checkLoginStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return widget.mobileBody;
        } else if (constraints.maxWidth < 1100) {
          return widget.tabletBody;
        } else {
          return widget.desktopBody;
        }
      },
    );
  }
}


