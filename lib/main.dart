import 'package:common/routes/routes.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_login/data/repository/auth_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:stock_bu_fan/routing/route_guard.dart';
import 'package:stock_bu_fan/routing/route_guard_provider.dart';
import 'package:stock_bu_fan/routing/route_not_found_page.dart';
import 'package:stock_bu_fan/routing/routes_map.dart';
import 'package:stock_bu_fan/theme/custom_theme_data.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RouteGuardProvider(
        repository: AuthRepositoryImpl()
      ),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: customThemeData,
      initialRoute: Routes.initialRoute,
      onGenerateRoute: (settings){
        late Widget nextPage;
        if (!routesMap.containsKey(settings.name)){
          nextPage = const RouteNotFoundPage();
        }
        else {
          nextPage = RouteGuard(
              displayedPage: routesMap[settings.name]!
          );
        }

        return MaterialPageRoute(
          builder: (context) => nextPage,
          settings: settings,
        );
      },
    );
  }
}

