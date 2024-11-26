import 'package:firebase_auth/firebase_auth.dart';

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

}
