import 'package:shared_preferences/shared_preferences.dart';

class OnSharedPreferences {
  OnSharedPreferences._privateConstructor();

  static final OnSharedPreferences instance =
      OnSharedPreferences._privateConstructor();

  String _jwt = "";
  String _username = "";

  String get getJwtVal {
    return _jwt;
  }

  String get getUsername {
    return _username;
  }

  void setJwtVal(String values) {
    _jwt = values;
  }

  void setUsername(String values) {
    _username = values;
  }

  setStringValue(String key, String value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString(key, value);
  }

  Future<String> getStringValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString(key) ?? "";
  }

  Future<bool> containsKey(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.containsKey(key);
  }

  removeValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.remove(key);
  }

  removeAll() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.clear();
  }
}
