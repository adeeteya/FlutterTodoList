import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/services/database_service.dart';

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

  Future logIn(BuildContext context, String email) async {
    try {
      return _client.auth
          .signInWithOtp(
              email: email.trim(),
              emailRedirectTo: kIsWeb
                  ? null
                  : 'io.supabase.flutterquickstart://login-callback/')
          .then(
            (_) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Check your email for a login link!')),
            ),
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

  Future<void> logout() async {
    await DatabaseService().deleteAllLocalTodos();
    await _client.auth.signOut();
  }
}
