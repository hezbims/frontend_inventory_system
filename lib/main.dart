import 'package:common/routes/routes.dart';
import 'package:fitur_autentikasi/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:stock_bu_fan/routing/route_guard.dart';
import 'package:stock_bu_fan/routing/routes_map.dart';
import 'package:stock_bu_fan/theme/custom_theme_data.dart';

void main() {
  runApp(const MyApp());
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
        if (settings.name != Routes.loginRoute){
          nextPage = RouteGuard(
            child: routesMap[settings.name]!
          );
        }
        else {
          nextPage = const LoginScreen();
        }

        return MaterialPageRoute(builder: (context) => nextPage);
      },
    );
  }
}

