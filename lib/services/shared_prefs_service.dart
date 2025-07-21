import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/settings_data.dart';

class SharedPrefService {
  static late final SharedPreferencesWithCache _prefs;
  static late final SettingsData settingsData;

  Future<void> init() async {
    _prefs = await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(),
    );
    settingsData = await getPreferences();
  }

  Future<SettingsData> getPreferences() async {
    return SettingsData(
      _prefs.getBool("isDarkMode") ??
          PlatformDispatcher.instance.platformBrightness == Brightness.dark,
      _prefs.getInt("colorValue") ?? Colors.green.toARGB32(),
    );
  }

  Future<void> setDarkMode(bool isDarkMode) async {
    await _prefs.setBool("isDarkMode", isDarkMode);
  }

  Future<void> setColorValue(int colorValue) async {
    await _prefs.setInt("colorValue", colorValue);
  }

  String? getEmail() {
    return _prefs.getString("email");
  }

  Future<void> setEmail(String email) async {
    await _prefs.setString("email", email);
  }

  Future<void> removeEmail() async {
    await _prefs.remove("email");
  }
}
