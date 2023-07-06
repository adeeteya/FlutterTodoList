import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/settings_data.dart';

class SharedPrefService {
  static late final SharedPreferences _prefs;
  static late final SettingsData settingsData;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    settingsData=await getPreferences();
  }

  Future<SettingsData> getPreferences() async {
    return SettingsData(
        _prefs.getBool("isDarkMode") ??
            PlatformDispatcher.instance.platformBrightness == Brightness.dark,
        _prefs.getInt("colorValue") ?? Colors.green.value);
  }

  Future<void> setDarkMode(bool isDarkMode) async {
    await _prefs.setBool("isDarkMode", isDarkMode);
  }

  Future<void> setColorValue(int colorValue) async {
    await _prefs.setInt("colorValue", colorValue);
  }
}
