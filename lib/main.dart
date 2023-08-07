import 'package:common/presentation/bottom_navbar/stock_bottom_navbar_controller.dart';
import 'package:common/routes/routes.dart';
import 'package:common/themes/theme.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_data_barang/presentation/page/input_data_barang_page.dart';
import 'package:fitur_lihat_stock_barang/presentation/page/lihat_stock_barang_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StockBottomNavBarProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: primaryColor,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.grey
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(primaryColor),
              foregroundColor: const MaterialStatePropertyAll(Colors.white),
              padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 24,
                  )
              ),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
            )
          ),
          useMaterial3: true,
        ),
        initialRoute: Routes.fiturLihatStockBarangRoute,
        routes: {
          Routes.fiturLihatStockBarangRoute : (context) => const LihatStockBarangPage(),
          Routes.fiturInputDataBarangRoute : (context) => const InputDataBarangPage(),
        },
      ),
    );
  }
}

