import 'package:common/presentation/page/pilih_kategori/pilih_kategori_page.dart';
import 'package:common/routes/routes.dart';
import 'package:fitur_input_data_barang/presentation/page/input_data_barang_page.dart';
import 'package:fitur_input_pengajuan/presentation/pages/initial_detail_pengajuan_loader.dart';
import 'package:fitur_input_pengajuan/presentation/pages/pilih_pengaju_page.dart';
import 'package:fitur_input_pengajuan/presentation/pages/pilih_list_barang_page.dart';
import 'package:fitur_lihat_pengajuan/presentation/pages/lihat_pengajuan_pages.dart';
import 'package:fitur_lihat_stock_barang/presentation/page/lihat_stock_barang_page.dart';
import 'package:flutter/material.dart';
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
      initialRoute: Routes.fiturLihatStockBarangRoute,
      routes: {
        Routes.fiturLihatStockBarangRoute : (context) => const LihatStockBarangPage(),
        Routes.fiturInputDataBarangRoute : (context) => const InputDataBarangPage(),
        Routes.fiturPilihKategoriRoute : (context) => const PilihKategoriPage(),
        Routes.fiturLihatPengajuanRoute : (context) => const LihatPengajuanPages(),
        Routes.fiturInputDataPengajuanRoute : (context){
          final idPengajuan = ModalRoute.of(context)?.settings.arguments as int?;

          return InitialDetailPengajuanLoader(idPengajuan: idPengajuan);
        },
        Routes.fiturInputListBarangRoute : (context) => const PilihListBarangPage(),
        Routes.fiturPilihGroupRoute : (context) => const PilihPengajuPage(),
      },
    );
  }
}

