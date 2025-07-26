import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_list/controllers/auth_controller.dart';

class CheckEmailScreen extends ConsumerStatefulWidget {
  final User? user;
  const CheckEmailScreen({super.key, this.user});

  @override
  ConsumerState createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends ConsumerState<CheckEmailScreen> {
  // late final StreamSubscription _authLinkCheckerSubscription;
  late final Timer _emailVerificationTimer;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      unawaited(widget.user?.sendEmailVerification());
      _emailVerificationTimer = Timer.periodic(const Duration(seconds: 5), (
        timer,
      ) async {
        if (mounted) {
          await widget.user?.reload();
        }
      });
    }
    // _authLinkCheckerSubscription = AppLinks().stringLinkStream.listen((
    //   link,
    // ) async {
    //   if (mounted) {
    //     if (widget.user != null) {
    //       await widget.user?.reload();
    //     } else {
    //       await ref
    //           .read(authProvider.notifier)
    //           .signInUsingEmailLink(context, link);
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    if (widget.user == null) {
      // unawaited(_authLinkCheckerSubscription.cancel());
    } else {
      _emailVerificationTimer.cancel();
    }
    super.dispose();
  }

  Future<void> _resendEmail() async {
    await widget.user?.sendEmailVerification();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Verification email sent! Please check your inbox."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () async {
            await ref.read(authProvider.notifier).signOut(context);
          },
        ),
        centerTitle: true,
        title: const Text("Confirm Email"),
      ),
      body: Center(
        child: SizedBox(
          width: 500,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Flexible(
                  flex: 10,
                  child: Lottie.asset("assets/check_email.json"),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.user == null
                      ? "Click the link on your email to login"
                      : "Please check your email to verify your account.",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (widget.user != null) ...[
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _resendEmail,
                    child: const Text("Resend Email"),
                  ),
                ],
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
