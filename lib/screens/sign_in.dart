import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/controllers/auth_controller.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: SizedBox(
            width: 500,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Sign in to\nSync Todo List",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Add your email. We'll send you a\n confirmation link so we know you are real.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 60),
                    TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: [AutofillHints.email],
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Enter your email address",
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Enter the email";
                        }
                        return null;
                      },
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          await ref
                              .read(authProvider.notifier)
                              .sendEmail(context, email);
                        }
                      },
                      child: const Text("Send Magic Link"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
