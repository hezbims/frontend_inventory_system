import 'package:common/presentation/provider/user_provider.dart';
import 'package:common/constant/routes/routes.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:flutter/material.dart';
import 'package:fitur_auth_guard/presentation/route_guard.dart';
import 'package:fitur_auth_guard/presentation/page/route_not_found_page.dart';
import 'package:stock_bu_fan/dependency_injection/setup_di.dart';
import 'package:stock_bu_fan/routing/routes_map.dart';
import 'package:stock_bu_fan/theme/custom_theme_data.dart';

void main() {
  setupMainDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GetIt.I.get<UserProvider>(),
        ),
      ],

      child: Builder(
        builder: (context) {
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
                    displayedPage: routesMap[settings.name]!,
                );
              }

              return MaterialPageRoute(
                builder: (context) => nextPage,
                settings: settings,
              );
            },
          );
        }
      ),
    );
  }
}

