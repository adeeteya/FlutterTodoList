import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/controllers/settings_controller.dart';
import 'package:todo_list/firebase_options.dart';
import 'package:todo_list/routes.dart';
import 'package:todo_list/services/shared_prefs_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefService().init();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  runApp(const ProviderScope(child: TodoListApp()));
}

class TodoListApp extends ConsumerWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsData = ref.watch(settingsProvider);
    return MaterialApp.router(
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
      themeMode: settingsData.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorSchemeSeed: Color(settingsData.colorValue),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Color(settingsData.colorValue),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
      ),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
