import 'package:common/presentation/provider/user_provider.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:flutter/material.dart';
import 'package:stock_bu_fan/dependency_injection/setup_main_dependency_injection.dart';
import 'package:stock_bu_fan/routing/on_generate_route.dart';
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
            onGenerateRoute: onGenerateRoute,
          );
        }
      ),
    );
  }
}

