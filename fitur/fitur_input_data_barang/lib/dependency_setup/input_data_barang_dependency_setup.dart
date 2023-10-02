import 'package:common/domain/model/barang.dart';
import 'package:common/presentation/dependency_setup/get_it_dependency_setup.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_data_barang/data/repository/submit_barang_repository_impl.dart';
import 'package:fitur_input_data_barang/presentation/page/input_data_barang_page.dart';
import 'package:fitur_input_data_barang/presentation/provider/input_data_barang_provider.dart';
import 'package:flutter/material.dart';

class InputDataBarangDependencySetup extends GetItDependencySetup {
  InputDataBarangDependencySetup({
    required RouteSettings settings,
    super.key,
  }) : super(
    setup: (){
      final arg = settings.arguments as Barang?;

      GetIt.I.registerSingleton(
        InputDataBarangProvider(
          initialData: arg,
          repository: SubmitBarangRepositoryImpl(),
        )
      );

    },
    disposeFunction: (){
      GetIt.I.unregister<InputDataBarangProvider>();
    },
    page: const InputDataBarangPage(),
  );
}