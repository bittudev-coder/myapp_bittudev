import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../Function/Function.dart';
import '../util/user__repository.dart';
import 'notification_service.dart';

class AuthService {
  // creating a new account
  static Future<String> createAccountWithEmail(
      String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return "Account Created";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  // login with email password method
  static Future<String> loginWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Login Successful";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  // logout the user
  static Future logout() async {
    await FirebaseAuth.instance.signOut();
  }

  // check whether the user is sign in or not
  static Future<bool> isLoggedIn() async {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  static Future<Map<String, dynamic>> getUserDetails() async {
    final User? user = FirebaseAuth.instance.currentUser;

    // Check if the user is logged in
    if (user != null) {
      return {
        'isLoggedIn': true,
        'email': user.email, // Return the email of the logged-in user
      };
    } else {
      return {
        'isLoggedIn': false,
        'email': null, // No email if not logged in
      };
    }
  }


  // Method to check login status
  static Future<void> checkLoginStatus(BuildContext context) async {
    PushNotifications.getDeviceToken();
    final userDetails = await AuthService.getUserDetails();

    bool isLoggedIn = userDetails['isLoggedIn']!;
    String? email = userDetails['email'];

    if (isLoggedIn) {
      print("User is logged in with email: $email");
      UserRepository.setEmail(email!);
      UserRepository.setLoginState(isLoggedIn);

    } else {
      print("User is not logged in");
      UserRepository.setEmail("");
      UserRepository.setLoginState(false);
        showReportDialog(context,true);

    }
  }

}
