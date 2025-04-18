import 'package:flutter/material.dart';
import 'package:buildconnect/screens/auth/auth_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthScreen(mode: AuthMode.login);
  }
}