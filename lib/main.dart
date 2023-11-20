import 'package:dependencies/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:inventory_system/dependency_injection/setup_main_dependency_injection.dart';
import 'package:inventory_system/routing/on_generate_route.dart';
import 'package:inventory_system/theme/custom_theme_data.dart';

void main() async {
  await dotenv.load();
  setupMainDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Inventory System',
          theme: customThemeData,
          onGenerateRoute: onGenerateRoute,
        );
      }
    );
  }
}

