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
      Colors.green.value,
      DateTime.now(),
    );
  }

  Future<void> initialize() async {
    state = await DatabaseService().isar.settingsDatas.get(0) ??
        SettingsData(
          PlatformDispatcher.instance.platformBrightness == Brightness.dark,
          Colors.green.value,
          DateTime.now(),
        );
  }

  Future<void> toggleThemeMode() async {
    state = state.copyWith(isDarkTheme: !state.isDarkTheme);
    await DatabaseService().isar.writeTxn(() async {
      await DatabaseService().isar.settingsDatas.put(state);
    });
  }

  Future<void> changeThemeColor(int newColorValue) async {
    state = state.copyWith(colorValue: newColorValue);
    await DatabaseService().isar.writeTxn(() async {
      await DatabaseService().isar.settingsDatas.put(state);
    });
  }

  Future<void> updateLastModifiedTime(DateTime newEditedTime) async {
    state = state.copyWith(lastUpdatedDate: newEditedTime);
    await DatabaseService().isar.writeTxn(() async {
      await DatabaseService().isar.settingsDatas.put(state);
    });
  }
}
