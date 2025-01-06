import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clears all session data
  }
}
