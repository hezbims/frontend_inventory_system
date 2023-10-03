import 'package:common/presentation/dependency_setup/get_it_dependency_setup.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_buat_laporan/data/repository/get_data_laporan_repository_impl.dart';
import 'package:fitur_buat_laporan/domain/model/generate_pdf_parameter_dto.dart';
import 'package:fitur_buat_laporan/presentation/page/preview_laporan_page.dart';
import 'package:fitur_buat_laporan/presentation/provider/preview_laporan_provider.dart';
import 'package:flutter/material.dart';

class PreviewLaporanDependencySetup extends GetItDependencySetup {
  PreviewLaporanDependencySetup({
    super.key,
    required RouteSettings settings,
  }) : super(
    setup: (){
      // TODO : Buat test untuk mastiin parameter pasti ke pass
      final param = settings.arguments as GeneratePdfParameterDto;

      GetIt.I.registerSingleton(
        PreviewLaporanProvder(
          repository: GetDataLaporanRepositoryImpl(),
          param: param,
        ),
      );
    },
    disposeFunction: (){
      GetIt.I.unregister<PreviewLaporanProvder>();
    },
    page: const PreviewLaporanPage(),
  );
}