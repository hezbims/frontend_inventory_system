import 'package:common/presentation/api_loader/api_loader.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/data/repository/get_detail_pengajuan_repository_impl.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:fitur_input_pengajuan/dependency_setup/main_form_dependency_setup.dart';
import 'package:fitur_input_pengajuan/presentation/provider/main_form/get_detail_pengajuan_provider.dart';
import 'package:flutter/material.dart';

class InitialDetailPengajuanLoader extends StatelessWidget {
  final int idPengajuan;
  const InitialDetailPengajuanLoader({
    required this.idPengajuan,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GetDetailPengajuanProvider(
        id: idPengajuan == 0 ? null : idPengajuan,
        repository: GetDetailPengajuanRepositoryImpl(),
      ),
      child: Consumer<GetDetailPengajuanProvider>(
          builder: (context , provider , child) {
            return ApiLoader(
              apiResponse: provider.getDetailPengajuanResponse(),
              onRefresh: provider.refresh,
              builder: (Pengajuan initialData) {
                return MainFormDependencySetup(initialData: initialData);
              },
              useScaffold: true,
            );
          }
      ),
    );
  }
}
