import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/controllers/auth_controller.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController =
      TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await ref
            .read(authProvider.notifier)
            .signUpUsingEmailAndPassword(
              _emailTextController.text,
              _passwordTextController.text,
            );
      } on FirebaseAuthException catch (e) {
        late final String errorMessage;
        if (e.code == "email-already-in-use") {
          errorMessage =
              "You have already signed up with this email. Please login instead.";
        } else if (e.code == "invalid-email") {
          errorMessage = "Please try signing up with a valid email.";
        } else if (e.code == "weak-password") {
          errorMessage = "Please try signing up with a stronger password.";
        } else if (e.code == "too-many-requests") {
          errorMessage =
              "You have made too many requests. Please try signing up later.";
        } else if (e.code == "network-request-failed") {
          errorMessage =
              "There was a network error. Please check your internet connection and try again.";
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
                          "Sign up to\nSync Todo List",
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
                          textInputAction: TextInputAction.next,
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
                        const SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          controller: _confirmPasswordTextController,
                          keyboardType: TextInputType.visiblePassword,
                          autofillHints: const [AutofillHints.password],
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _signUp(),
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Enter your password again",
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Enter the password";
                            } else if (val.length < 6) {
                              return "Password must be at least 6 characters long";
                            } else if (val != _passwordTextController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: _isLoading ? () {} : _signUp,
                          child: _isLoading
                              ? const Padding(
                                  padding: EdgeInsets.all(1),
                                  child: CircularProgressIndicator(),
                                )
                              : const Text("Sign Up"),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text("Already have an account?"),
                            const SizedBox(width: 2),
                            TextButton(
                              onPressed: () {
                                context.go("/sign_in");
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: const Text("Sign in"),
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
