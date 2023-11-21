import 'package:common/presentation/provider/refresh_notifier.dart';
import 'package:common/routing/my_route_state_provider.dart';
import 'package:dependencies/flutter_dotenv.dart';
import 'package:dependencies/provider.dart';
import 'package:flutter/material.dart';
import 'package:inventory_system/dependency_injection/setup_main_dependency_injection.dart';
import 'package:inventory_system/routing/my_router_delegate.dart';
import 'package:inventory_system/theme/custom_theme_data.dart';

void main() async {
  await dotenv.load();
  setupMainDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _routerDelegate = MyRouterDelegate();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MyRouteStateProvider()
        ),
        ChangeNotifierProvider(
          create: (context) => RefreshNotifier()
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Inventory System',
        theme: customThemeData,
        routerDelegate: _routerDelegate,
      ),
    );
  }
}

