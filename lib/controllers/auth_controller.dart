import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authProvider =
    NotifierProvider<AuthNotifier, User?>(() => AuthNotifier());

class AuthNotifier extends Notifier<User?> {
  final SupabaseClient _client = Supabase.instance.client;

  @override
  User? build() {
    _client.auth.onAuthStateChange.listen((event) {
      state = event.session?.user;
    });
    return _client.auth.currentUser;
  }

  Future<void> logIn(BuildContext context, String email) async {
    try {
      return await _client.auth
          .signInWithOtp(
              email: email.trim(),
              emailRedirectTo: kIsWeb
                  ? null
                  : 'io.supabase.flutterquickstart://login-callback/')
          .then(
            (_) => context.go("/login/authenticate"),
          );
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Colors.redAccent,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Unexpected Error Occurred"),
          backgroundColor: Colors.redAccent,
        ),
      );
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
              await _client.auth.signOut();
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
