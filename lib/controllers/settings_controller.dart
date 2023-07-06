import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/models/settings_data.dart';
import 'package:todo_list/services/shared_prefs_service.dart';

final settingsProvider =
    NotifierProvider<SettingsNotifier, SettingsData>(() => SettingsNotifier());

class SettingsNotifier extends Notifier<SettingsData> {
  @override
  SettingsData build() {
    return SharedPrefService.settingsData;
  }

  Future<void> toggleThemeMode() async {
    state = state.copyWith(isDarkTheme: !state.isDarkTheme);
    await SharedPrefService().setDarkMode(state.isDarkTheme);
  }

  Future<void> changeThemeColor(int newColorValue) async {
    state = state.copyWith(colorValue: newColorValue);
    await SharedPrefService().setColorValue(state.colorValue);
  }
}
