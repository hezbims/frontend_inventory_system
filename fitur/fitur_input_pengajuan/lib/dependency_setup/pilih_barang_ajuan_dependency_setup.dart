import 'package:common/presentation/dependency_setup/get_it_dependency_setup.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/data/repository/get_barang_preview_repository_impl.dart';
import 'package:fitur_input_pengajuan/presentation/arg_model/main_form_to_pilih_barang_arg.dart';
import 'package:fitur_input_pengajuan/presentation/pages/pilih_list_barang_page.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/pilih_barang_provider.dart';
import 'package:flutter/material.dart';

class PilihBarangAjuanDependencySetup extends GetItDependencySetup {
  PilihBarangAjuanDependencySetup({
    required RouteSettings settings,
    super.key,
  }) : super(
    setup: (){
      final arg = settings.arguments as MainFormToPilihBarangArg;

      GetIt.I.registerSingleton(
        PilihBarangProvider(
          barangRepository: GetBarangPreviewRepositoryImpl(),
          choosenBarang: arg.initialList,
          isPemasukan: arg.isPemasukan,
        )
      );
    },
    disposeFunction: (){
      GetIt.I.unregister<PilihBarangProvider>();
    },
    page: const PilihListBarangPage()
  );
}