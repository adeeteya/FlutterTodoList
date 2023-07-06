import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/controllers/auth_controller.dart';
import 'package:todo_list/screens/home.dart';
import 'package:todo_list/screens/settings.dart';
import 'package:todo_list/screens/sign_in.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final user = ref.watch(authProvider);
  if (user == null) {
    return GoRouter(
      initialLocation: "/login",
      onException: (_, state, router) => router.go('/'),
      routes: [
        GoRoute(
          path: "/login",
          name: "Login",
          builder: (context, state) => const SignInScreen(),
        ),
      ],
    );
  } else {
    return GoRouter(
      initialLocation: "/",
      onException: (_, state, router) => router.go('/'),
      routes: [
        GoRoute(
          path: "/",
          name: "Home",
          builder: (context, state) => const Home(),
        ),
        GoRoute(
          path: "/settings",
          name: "Settings",
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    );
  }
});
