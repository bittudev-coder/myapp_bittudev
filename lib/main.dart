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

// Request notification permissions for iOS
Future<void> requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Requesting permissions for iOS devices
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("User granted notification permission");
  } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
    print("User denied notification permission");
  } else {
    print("User has not responded to notification permission");
  }
}

// Handle notifications when the app is in the background
Future<void> _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification Received in background...");
  }
}

// Initialize push notifications
Future<void> initializePushNotifications() async {
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
          body: message.notification!.body!,
        );
      } else {
        PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData,
        );
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

  // Initialize Firebase only
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize user repository
  await UserRepository.init();

  // Load the app UI asynchronously
  runApp(const MyApp());

  // Initialize push notifications
  await initializePushNotifications();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          tabletBody: const TabletScaffold(),
          desktopBody: const DesktopScaffold(),
        ),
        "/message": (context) => Message(),
      },
    );
  }
}


