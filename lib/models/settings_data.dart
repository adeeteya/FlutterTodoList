class SettingsData {
  final bool isDarkTheme;
  final int colorValue;

  SettingsData(this.isDarkTheme, this.colorValue);

  SettingsData copyWith({
    bool? isDarkTheme,
    int? colorValue,
    DateTime? lastUpdatedDate,
  }) {
    return SettingsData(
      isDarkTheme ?? this.isDarkTheme,
      colorValue ?? this.colorValue,
    );
  }
}
