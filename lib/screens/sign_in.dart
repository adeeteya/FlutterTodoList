import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/controllers/auth_controller.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await ref
            .read(authProvider.notifier)
            .signInUsingEmailAndPassword(
              _emailTextController.text,
              _passwordTextController.text,
            );
      } on FirebaseAuthException catch (e) {
        late final String errorMessage;
        if (e.code == "invalid-email") {
          errorMessage = "Please try signing in with a valid email.";
        } else if (e.code == "user-disabled") {
          errorMessage =
              "Your account has been disabled. Please contact support.";
        } else if (e.code == "user-not-found") {
          errorMessage =
              "The email you entered is not registered. Please sign up first.";
        } else if (e.code == "wrong-password" ||
            e.code == "invalid-credential" ||
            e.code == "INVALID_LOGIN_CREDENTIALS") {
          errorMessage =
              "The password you entered is incorrect. Please try again.";
        } else if (e.code == "too-many-requests") {
          errorMessage =
              "You have made too many requests. Please try signing in later.";
        } else if (e.code == "network-request-failed") {
          errorMessage =
              "There was a network error. Please check your internet connection and try again.";
        } else {
          errorMessage = "An unknown error occurred. Please try again later.";
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      } catch (_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Unexpected Error Occurred. Please try again later.",
              ),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _forgotPassword() async {
    final email = _emailTextController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your email address.")),
      );
      return;
    }
    try {
      await ref.read(authProvider.notifier).sendPasswordResetEmail(email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Password reset email sent! Please check your inbox.",
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Center(
            child: SizedBox(
              width: 500,
              child: Form(
                key: _formKey,
                child: AutofillGroup(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Sign in to\nSync Todo List",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        TextFormField(
                          controller: _emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          textInputAction: TextInputAction.next,
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
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          controller: _passwordTextController,
                          keyboardType: TextInputType.visiblePassword,
                          autofillHints: const [AutofillHints.password],
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _signIn(),
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Enter your password",
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Enter the password";
                            } else if (val.length < 6) {
                              return "Password must be at least 6 characters long";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: _forgotPassword,
                          child: const Text("Forgot Password?"),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _isLoading ? () {} : _signIn,
                          child: _isLoading
                              ? const Padding(
                                  padding: EdgeInsets.all(1),
                                  child: CircularProgressIndicator(),
                                )
                              : const Text("Sign In"),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text("Don't have an account?"),
                            const SizedBox(width: 2),
                            TextButton(
                              onPressed: () {
                                context.go("/sign_up");
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: const Text("Sign up"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
