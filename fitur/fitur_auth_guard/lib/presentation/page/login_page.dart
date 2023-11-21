import 'package:fitur_auth_guard/presentation/page/login_screen.dart';
import 'package:flutter/material.dart';

class LoginPage extends Page {

  const LoginPage() : super(key: const ValueKey('Login Page'));

  @override
  Route<dynamic> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => LoginScreen()
    );
  }
}