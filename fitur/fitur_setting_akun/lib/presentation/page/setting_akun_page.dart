import 'package:common/presentation/bottom_navbar/stock_bottom_navbar.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:common/routes/routes.dart';
import 'package:fitur_setting_akun/presentation/component/setting_akun_item.dart';
import 'package:flutter/material.dart';

class SettingAkunPage extends StatelessWidget {
  const SettingAkunPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: StockBottomNavBar(currentIndex: Routes.settingAkunIndex),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(36),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Akun",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const VerticalFormSpacing(),

                  SettingAkunItem(
                    icon: Icons.logout,
                    label: "Logout"
                  ),

                  const SizedBox(height: 12,),

                  SettingAkunItem(
                      icon: Icons.question_mark,
                      label: "Lupa password"
                  ),

                  const SizedBox(height: 12,),

                  SettingAkunItem(
                    icon: Icons.person_add_alt,
                    label: 'Tambah akun baru'
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
