import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/services/shared_prefs_service.dart';

final authProvider = NotifierProvider<AuthNotifier, User?>(AuthNotifier.new);

class AuthNotifier extends Notifier<User?> {
  final FirebaseAuth _instance = FirebaseAuth.instance;

  @override
  User? build() {
    _instance.authStateChanges().listen((user) {
      state = user;
    });
    return _instance.currentUser;
  }

  Future<void> sendEmail(BuildContext context, String email) async {
    try {
      await SharedPrefService().setEmail(email.trim());
      await _instance.sendSignInLinkToEmail(
        email: email.trim(),
        actionCodeSettings: ActionCodeSettings(
          androidPackageName: "com.adeeteya.todo_list",
          androidMinimumVersion: "1.2.0",
          dynamicLinkDomain: "adeeteya.page.link",
          androidInstallApp: true,
          handleCodeInApp: true,
          iOSBundleId: "com.adeeteya.todo_list",
          url: "https://adeeteya.page.link/todo-list/finishSignIn",
        ),
      );
      if (context.mounted) {
        context.go("/login/authenticate");
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? ''),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Unexpected Error Occurred"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  Future<void> loginUsingEmailLink(
    BuildContext context,
    String emailLink,
  ) async {
    try {
      if (!_instance.isSignInWithEmailLink(emailLink)) {
        return;
      }

      final email = SharedPrefService().getEmail();
      if (email != null) {
        await _instance.signInWithEmailLink(email: email, emailLink: emailLink);
        await SharedPrefService().removeEmail();
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted && e.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message!),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Unexpected Error Occurred"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  Future<void> logout(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to log out of the app?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _instance.signOut();
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
