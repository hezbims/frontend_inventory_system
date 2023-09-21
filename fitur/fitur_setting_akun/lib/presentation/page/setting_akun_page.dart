import 'package:common/constant/themes/custom_sizing.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/presentation/bottom_navbar/stock_bottom_navbar.dart';
import 'package:common/presentation/provider/user_provider.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:common/constant/routes/routes.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_setting_akun/data/repository/setting_akun_repository_impl.dart';
import 'package:fitur_setting_akun/presentation/component/buat_akun_baru_dialog.dart';
import 'package:fitur_setting_akun/presentation/component/loader_overlay.dart';
import 'package:fitur_setting_akun/presentation/component/setting_akun_item.dart';
import 'package:fitur_setting_akun/presentation/provider/setting_akun_provider.dart';
import 'package:flutter/material.dart';

class SettingAkunPage extends StatelessWidget {
  const SettingAkunPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return ChangeNotifierProvider(
      create: (BuildContext context) => SettingAkunProvider(
        repository: SettingAkunRepositoryImpl()
      ),
      child: Consumer<SettingAkunProvider>(
        builder: (context , provider , child) {
          if (provider.logoutSuccess){
            WidgetsBinding.instance.addPostFrameCallback(
              (timeStamp) {
                Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
              }
            );
          }
          return LoaderOverlay(
            isLoading: provider.isLoading,
            child: Scaffold(
              bottomNavigationBar: StockBottomNavBar(currentIndex: Routes.settingAkunIndex),
              body: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: CustomSizing.maxLayoutWidth),
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
                              onTap: provider.logout,
                              icon: Icons.logout,
                              label: "Logout"
                            ),

                            const SizedBox(height: 12,),

                            SettingAkunItem(
                              onTap: (){},
                              icon: Icons.question_mark,
                              label: "Lupa password"
                            ),

                            FutureBuilder(
                              future: userProvider.getUserResponse,
                              builder: (BuildContext context , snapshot){
                                if (snapshot.hasData){
                                  final response = snapshot.data as ApiResponseSuccess<User>;
                                  if (response.data!.isAdmin) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 12,),

                                        SettingAkunItem(
                                          onTap: () async {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return BuatAkunBaruDialog();
                                              }
                                            );
                                          },
                                          icon: Icons.person_add_alt,
                                          label: 'Tambah akun baru'
                                        ),
                                      ],
                                    );
                                  }
                                  else  {
                                    return const SizedBox();
                                  }
                                }
                                else {
                                  return const SizedBox();
                                }
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
