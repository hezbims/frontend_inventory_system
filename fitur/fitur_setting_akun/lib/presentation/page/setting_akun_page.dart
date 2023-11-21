import 'package:fitur_setting_akun/presentation/page/setting_akun_screen.dart';
import 'package:flutter/material.dart';

class SettingAkunPage extends Page {
  const SettingAkunPage() : super(key: const ValueKey('Setting Akun Page'));
  @override
  Route<dynamic> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => SettingAkunScreen()
    );
  }
}