import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/models/settings_data.dart';
import 'package:todo_list/services/database_service.dart';

final settingsProvider =
    NotifierProvider<SettingsNotifier, SettingsData>(() => SettingsNotifier());

class SettingsNotifier extends Notifier<SettingsData> {
  @override
  SettingsData build() {
    initialize();
    return SettingsData(
      PlatformDispatcher.instance.platformBrightness == Brightness.dark,
      Colors.amber.value,
    );
  }

  Future initialize() async {
    state = await DatabaseService().isar.settingsDatas.get(0) ??
        SettingsData(
          PlatformDispatcher.instance.platformBrightness == Brightness.dark,
          Colors.amber.value,
        );
  }

  Future toggleThemeMode() async {
    state = state.copyWith(isDarkTheme: !state.isDarkTheme);
    await DatabaseService().isar.writeTxn(() async {
      await DatabaseService().isar.settingsDatas.put(state);
    });
  }

  Future changeThemeColor(int newColorValue) async {
    state = state.copyWith(colorValue: newColorValue);
    await DatabaseService().isar.writeTxn(() async {
      await DatabaseService().isar.settingsDatas.put(state);
    });
  }
}
