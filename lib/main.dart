import 'dart:convert';
import 'package:bittudev/responsive/desktop_body.dart';
import 'package:bittudev/responsive/mobile_body.dart';
import 'package:bittudev/responsive/tablet_body.dart';
import 'package:bittudev/responsive_layout.dart';
import 'package:bittudev/util/user__repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'Chat/pages/LoginPage.dart';
import 'WidgetTool/showHeadId.dart';
import 'controllers/notification_service.dart';
import 'firebase_options.dart';
import 'views/message.dart';


var uuid = Uuid();

final navigatorKey = GlobalKey<NavigatorState>();



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

  Future _firebaseBackgroundMessage(RemoteMessage message) async {
    if (message.notification != null) {
      print("Some notification Received in background...");
    }
  }
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
        // "/":(context)=>CustomContainer1(),
        // "/": (context) => ResponsiveLayout(
        //   mobileBody: const MobileScaffold(),
        //   tabletBody:  const TabletScaffold(),
        //   desktopBody: const DesktopScaffold(),
        // ),
        // "/message": (context) => Message(),
        "/": (context) => LoginPage()
      },
    );
  }
}



