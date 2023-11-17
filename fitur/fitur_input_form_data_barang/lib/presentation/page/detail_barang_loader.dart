import 'package:common/domain/model/barang.dart';
import 'package:common/presentation/api_loader/default_error_widget.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_form_data_barang/presentation/page/input_data_barang_page.dart';
import 'package:fitur_input_form_data_barang/presentation/provider/detail_barang_provider.dart';
import 'package:flutter/material.dart';

class DetailBarangLoader extends StatelessWidget {
  final int?  idBarang;
  const DetailBarangLoader({super.key,
    required this.idBarang,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GetIt.I.get<DetailBarangProvider>(param1: idBarang),
      child: Consumer<DetailBarangProvider>(
        builder: (context , provider , child){
          return FutureBuilder(
            future: provider.getDetailBarangResponse,
            builder: (context , snapshot){
              if (snapshot.connectionState == ConnectionState.done){
                final response = snapshot.data!;
                if (response is ApiResponseFailed){
                  return Scaffold(
                    body: DefaultErrorWidget(
                      onTap: provider.refresh,
                      errorMessage: response.error.toString(),
                    ),
                  );
                }
                else if (response is ApiResponseSuccess<Barang?>){
                  return InputDataBarangPage(initialBarang: response.data);
                }
                else {
                  throw Exception("Unknown type detail barang : ${response.runtimeType}");
                }
              }
              else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }
          );
        }
      ),
    );
  }
}
