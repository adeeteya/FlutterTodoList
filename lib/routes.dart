import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/controllers/auth_controller.dart';
import 'package:todo_list/screens/check_email.dart';
import 'package:todo_list/screens/home.dart';
import 'package:todo_list/screens/settings.dart';
import 'package:todo_list/screens/sign_in.dart';
import 'package:todo_list/screens/sign_up.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final user = ref.watch(authProvider);
  if (user == null) {
    return GoRouter(
      initialLocation: "/sign_in",
      onException: (_, state, router) => router.go('/'),
      routes: [
        GoRoute(
          path: "/sign_up",
          name: "SignUp",
          pageBuilder: (context, state) =>
              const CupertinoPage(child: SignUpScreen()),
        ),
        GoRoute(
          path: "/sign_in",
          name: "SignIn",
          pageBuilder: (context, state) =>
              const CupertinoPage(child: SignInScreen()),
        ),
      ],
    );
  } else if (!user.emailVerified) {
    return GoRouter(
      initialLocation: "/",
      onException: (_, state, router) => router.go('/'),
      routes: [
        GoRoute(
          path: "/",
          name: "Authenticate",
          pageBuilder: (context, state) =>
              CupertinoPage(child: CheckEmailScreen(user: user)),
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
          pageBuilder: (context, state) => const CupertinoPage(child: Home()),
        ),
        GoRoute(
          path: "/settings",
          name: "Settings",
          pageBuilder: (context, state) =>
              const CupertinoPage(child: SettingsScreen()),
        ),
      ],
    );
  }
});
