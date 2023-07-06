import 'package:isar/isar.dart';

part 'settings_data.g.dart';

@collection
class SettingsData {
  final Id id = 0;

  final bool isDarkTheme;
  final int colorValue;

  SettingsData(this.isDarkTheme, this.colorValue);

  SettingsData copyWith(
      {bool? isDarkTheme, int? colorValue, DateTime? lastUpdatedDate}) {
    return SettingsData(
        isDarkTheme ?? this.isDarkTheme, colorValue ?? this.colorValue);
  }
}
