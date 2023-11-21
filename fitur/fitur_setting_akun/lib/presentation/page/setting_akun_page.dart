import 'package:fitur_setting_akun/presentation/page/setting_akun_screen.dart';
import 'package:flutter/material.dart';

class SettingAkunPage extends Page {

  @override
  Route<dynamic> createRoute(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) => SettingAkunScreen()
    );
  }
}