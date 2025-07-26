import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/controllers/auth_controller.dart';
import 'package:todo_list/controllers/settings_controller.dart';
import 'package:todo_list/widgets/change_theme_color_dialog.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsData = ref.watch(settingsProvider);
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Settings")),
      body: Center(
        child: SizedBox(
          width: 500,
          child: ListView(
            children: [
              SwitchListTile.adaptive(
                value: settingsData.isDarkTheme,
                title: const Text("Dark Mode"),
                onChanged: (_) async {
                  await ref.read(settingsProvider.notifier).toggleThemeMode();
                },
              ),
              const SizedBox(height: 10),
              ListTile(
                title: const Text("Theme Color"),
                onTap: () async {
                  final int? newSelectedColor =
                      await showChangeThemeColorDialog(
                        context,
                        settingsData.colorValue,
                      );
                  if (newSelectedColor != null) {
                    await ref
                        .read(settingsProvider.notifier)
                        .changeThemeColor(newSelectedColor);
                  }
                },
                trailing: SizedBox(
                  height: 35,
                  width: 35,
                  child: DecoratedBox(
                    position: DecorationPosition.foreground,
                    decoration: BoxDecoration(
                      color: Color(settingsData.colorValue),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: () async {
                  await ref.read(authProvider.notifier).signOut(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
