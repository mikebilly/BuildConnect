import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import 'package:buildconnect/features/auth/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

enum AuthMode { login, register }

class AuthScreen extends ConsumerStatefulWidget {
  final AuthMode mode;

  const AuthScreen({super.key, required this.mode});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    debugPrint('Hit submit button');
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authNotifier = ref.read(authProvider.notifier);

    try {
      if (widget.mode == AuthMode.login) {
        await authNotifier.signIn(
          email: _email.text.trim(),
          password: _password.text,
        );
      } else {
        await authNotifier.signUp(
          email: _email.text.trim(),
          password: _password.text,
        );
      }

      if (mounted) {
        context.go('/');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mode == AuthMode.login ? 'Login' : 'Register'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator:
                      (value) =>
                          EmailValidator.validate(value ?? '')
                              ? null
                              : 'Invalid email',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _password,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator:
                      (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters long";
                          }
                          return null;
                      }
                ),

                /// confirm password
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: auth.isLoading ? null : _submit,
                  child:
                      auth.isLoading
                          ? const CircularProgressIndicator(strokeWidth: 2)
                          : Text(
                            widget.mode == AuthMode.login
                                ? 'Login'
                                : 'Register',
                          ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    final newRoute = widget.mode == AuthMode.login ? '/register' : '/login';
                    context.go(newRoute);
                  },
                  child: Text(
                    widget.mode == AuthMode.login ? "Don't have an account? Register" : "Already have an account? Login",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
