import 'package:common/presentation/dependency_setup/pilih_kategori_dependency_setup.dart';
import 'package:common/constant/routes/routes_path.dart';
import 'package:fitur_input_pengajuan/presentation/pages/pilih_list_barang_page.dart';
import 'package:fitur_input_pengajuan/presentation/pages/pilih_pengaju_page.dart';
import 'package:common/presentation/dependency_setup/get_it_dependency_setup.dart';
import 'package:flutter/material.dart';

final Map<String , Widget Function(RouteSettings)> routesMap = {
  RoutesPath.pilihKategoriPath : (settings) => GetItDependencySetup(
      setup: (){},
      disposeFunction: (){},
      page: PilihKategoriDependencySetup()
  ),
  RoutesPath.inputListBarangPath : (settings) =>
    const PilihListBarangPage(),
  RoutesPath.pilihPengajuPath : (settings) =>
    const PilihPengajuPage(),
};