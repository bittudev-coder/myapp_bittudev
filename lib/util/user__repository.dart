import 'package:shared_preferences/shared_preferences.dart';
import 'const_repo.dart';

class UserRepository {
  static late SharedPreferences prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }


  static void setToken(String token) {
    prefs.setString(TOKEN, token);
  }

  static String? getToken() {
    return prefs.getString(TOKEN);
  }


  static void setLanguage(String lang) {
    prefs.setString(PREF_LANGUAGE, lang);
  }

  static String? getLanguage() {
    return prefs.getString(PREF_LANGUAGE);
  }

  static bool getLoginState() {
    return prefs.getBool(STATE) ?? false;  // Return a default value if STATE is null
  }

  static void setLoginState(bool state) {
    prefs.setBool(STATE, state);
  }

  static String? getName() {
    return prefs.getString(NAME);
  }

  static void setName(String name) {
    prefs.setString(NAME, name);
  }

  static String? getEmail() {
    return prefs.getString(PREF_EMAIL);
  }

  static void setEmail(String email) {
    prefs.setString(PREF_EMAIL, email);
  }

  static String? getServerUrl() {
    return prefs.getString(PREF_URL);
  }

  static void setServerUrl(String url) {
    prefs.setString(PREF_URL, url);
  }

  static String? getPassword() {
    return prefs.getString(PREF_PASSWORD);
  }

  static void setPassword(String password) {
    prefs.setString(PREF_PASSWORD, password);
  }

  static void doLogout() {
    prefs.clear();
  }
}
