import 'package:flutter/material.dart';
import 'package:buildconnect/screens/auth/auth_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthScreen(mode: AuthMode.register);
  }
}