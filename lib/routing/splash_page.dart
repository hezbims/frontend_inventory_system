import 'package:flutter/material.dart';
import 'package:inventory_system/routing/splash_screen.dart';

class SplashPage extends Page {
  const SplashPage() : super(key: const ValueKey('Splash Screen'));

  @override
  Route<dynamic> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => const SplashScreen()
    );
  }
}