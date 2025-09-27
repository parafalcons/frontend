import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _tokenKey = "token";
  static const String _isUserLoggedInKey = "isUserLoggedIn";
  static const String _userNameKey = "userName";

  // Save token, username, and login state
  static Future<void> saveSession(String token, String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userNameKey, userName);
    await prefs.setBool(_isUserLoggedInKey, true);
  }

  // Retrieve saved username
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  // Get stored token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Check if user is logged in
  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isUserLoggedInKey) ?? false;
  }

  // Logout and clear session data
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.setBool(_isUserLoggedInKey, false);
  }
}
