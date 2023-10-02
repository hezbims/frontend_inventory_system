import 'package:common/data/repository/pengaju_repository_impl.dart';
import 'package:common/presentation/dependency_setup/get_it_dependency_setup.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/presentation/pages/pilih_pengaju_page.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_pengaju/pilih_pengaju_provider.dart';
import 'package:flutter/material.dart';

class PilihPengajuDependencySetup extends GetItDependencySetup {
  PilihPengajuDependencySetup({
    required RouteSettings settings,
    super.key
  }) : super(
    setup: (){
      final isPemasok = settings.arguments as bool;

      GetIt.I.registerSingleton(
        PilihPengajuProvider(
          repository: PengajuRepositoryImpl(),
          isPemasok: isPemasok,
        )
      );
    },
    disposeFunction: (){
      GetIt.I.unregister<PilihPengajuProvider>();
    },
    page: const PilihPengajuPage()
  );
}