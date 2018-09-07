import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setSharedPreferencesInt(String key, int vlue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setInt(key, vlue);
}

Future<int> getSharedPreferencesInt(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.get(key);
}

Future<bool> setSharedPreferencesString(String key, String vlue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString(key, vlue);
}
