import 'package:common/constant/routes/routes_path.dart';
import 'package:common/constant/themes/custom_sizing.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/presentation/bottom_navbar/stock_bottom_navbar.dart';
import 'package:common/presentation/loader_overlay/loader_overlay.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:common/routing/my_route_state_provider.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_setting_akun/presentation/component/buat_akun_baru_dialog.dart';
import 'package:fitur_setting_akun/presentation/component/setting_akun_item.dart';
import 'package:fitur_setting_akun/presentation/provider/setting_akun_provider.dart';
import 'package:flutter/material.dart';

class SettingAkunScaffold extends StatefulWidget {
  const SettingAkunScaffold({Key? key}) : super(key: key);

  @override
  State<SettingAkunScaffold> createState() => _SettingAkunScaffoldState();
}

class _SettingAkunScaffoldState extends State<SettingAkunScaffold> {
  late final MyRouteStateProvider _routeStateProvider = context.read();
  late final SettingAkunProvider _provider = context.read();

  @override
  Widget build(BuildContext context) {
    return Selector<SettingAkunProvider , SettingAkunProvider>(
      selector: (context , prov) => prov,
      shouldRebuild: (prov1 , prov2) => prov1.isLoading != prov2.isLoading,
      builder: (context , provider , child) {
        return LoaderOverlay(
          isLoading: provider.isLoading,
          child: Scaffold(
            bottomNavigationBar: StockBottomNavBar(currentIndex: RoutesPath.settingAkunIndex),
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
                              onTap: provider.tryLogout,
                              icon: Icons.logout,
                              label: "Logout"
                          ),

                          const SizedBox(height: 12,),

                          SettingAkunItem(
                              onTap: (){},
                              icon: Icons.question_mark,
                              label: "Lupa password"
                          ),

                          if (GetIt.I.get<User>().isAdmin) ...[
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
    );
  }

  @override
  void initState() {
    super.initState();
    _provider.addListener(_onLogoutSuccess);
  }

  void _onLogoutSuccess() {
    if (_provider.logoutSuccess){
      _routeStateProvider.setStateUnauthenticated();
    }
  }

  @override
  void dispose() {
    _provider.removeListener(_onLogoutSuccess);
    super.dispose();
  }
}
