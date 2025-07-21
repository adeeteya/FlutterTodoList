import 'package:app_links/app_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/controllers/auth_controller.dart';
import 'package:todo_list/screens/check_email.dart';
import 'package:todo_list/screens/home.dart';
import 'package:todo_list/screens/settings.dart';
import 'package:todo_list/screens/sign_in.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final user = ref.watch(authProvider);
  if (user == null) {
    return GoRouter(
      initialLocation: "/login",
      onException: (_, state, router) => router.go('/'),
      redirect: (context, state) async {
        final initialLink = await AppLinks().getInitialLinkString();
        if (initialLink != null && context.mounted) {
          await ref.read(authProvider.notifier).login(context, initialLink);
        }
        return null;
      },
      routes: [
        GoRoute(
          path: "/login",
          name: "Login",
          pageBuilder: (context, state) =>
              const CupertinoPage(child: SignInScreen()),
          routes: [
            GoRoute(
              path: "authenticate",
              name: "Authenticate",
              pageBuilder: (context, state) =>
                  const CupertinoPage(child: CheckEmailScreen()),
            ),
          ],
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
