import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences prefs;

  static Future<SharedPreferences> getPrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
    // prefs.clear();
    return prefs;
  }
}
