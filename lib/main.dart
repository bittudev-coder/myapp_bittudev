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
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification Received in background...");
  }
}

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

  // initialize firebase messaging
  Map<Permission, PermissionStatus> statuses = await [
    // Permission.location,
    Permission.notification,
  ].request();
  await PushNotifications.init();
  await UserRepository.init();
  // initialize local notifications
  // dont use local notifications for web platform
  if (!kIsWeb) {
    await PushNotifications.localNotiInit();
  }

  // Listen to background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped");
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    }
  });

// to handle foreground notifications
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

  // for handling in terminated state
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

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
        "/": (context) => CheckUser(),
        "/signup": (context) => SignUpPage(),
        "/login": (context) => LoginPage(),
        "/home": (context) => ResponsiveLayout(
          mobileBody: const MobileScaffold(),
          tabletBody:  const TabletScaffold(),
          desktopBody: const DesktopScaffold(),
        ),
        "/message": (context) => Message()
      },
    );
  }
}



class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  late SharedPreferences prefs;
  bool isLoggedIn = false;
  String? email;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Function to check login status and fetch the email
  void _checkLoginStatus() async {
    PushNotifications.getDeviceToken();

    final userDetails = await AuthService.getUserDetails();
    setState(() {
      isLoggedIn = userDetails['isLoggedIn']!;
      email = userDetails['email'];  // Store email if logged in
    });


    if (isLoggedIn) {
      print("User is logged in with email: $email");
      UserRepository.setEmail(email!);
      UserRepository.setLoginState(isLoggedIn);
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      print("User is not logged in");
      UserRepository.setEmail("");
      UserRepository.setLoginState(false);
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  @override
  Widget build(BuildContext context) {

    // Once we have the user details, navigate to the home screen
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

