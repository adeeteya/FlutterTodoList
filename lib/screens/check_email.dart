import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_list/controllers/auth_controller.dart';

class CheckEmailScreen extends ConsumerStatefulWidget {
  const CheckEmailScreen({super.key});

  @override
  ConsumerState createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends ConsumerState<CheckEmailScreen> {
  late final StreamSubscription _authLinkCheckerSubscription;

  @override
  void initState() {
    super.initState();
    _authLinkCheckerSubscription = AppLinks().stringLinkStream.listen((link) {
      if (mounted) {
        ref.read(authProvider.notifier).login(context, link);
      }
    });
  }

  @override
  void dispose() {
    _authLinkCheckerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: "Back to Login",
          onPressed: () => context.go("/login"),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text("Confirm Email"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Flexible(flex: 10, child: Lottie.asset("assets/check_email.json")),
            const SizedBox(height: 20),
            const Text(
              "Click the link on your email to login",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
