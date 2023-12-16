import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/presentation/arg_model/main_form_to_pilih_barang_arg.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_barang/done_card.dart';
import 'package:common/presentation/textfield/search_app_bar.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_barang/pilih_barang_scaffold_body.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/pilih_barang_provider.dart';
import 'package:flutter/material.dart';

class PilihBarangScreen extends StatelessWidget {
  final MainFormToPilihBarangArg arg;
  final void Function(List<BarangTransaksi>) onPopDone;
  
  const PilihBarangScreen({
    super.key,
    required this.arg,
    required this.onPopDone,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GetIt.I.get<PilihBarangProvider>(param1: arg,),
      child: Builder(
        builder: (context) {
          final provider = context.read<PilihBarangProvider>();
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => provider.tryRequestFocus(),
          );

          return PopScope(
            onPopInvoked: (didPop) {
              if (didPop) {
                handlePop(provider);
              }
            },
            child: Scaffold(
              appBar: SearchAppBar(
                controller: provider.searchBarangController,
                focusNode: provider.searchBarangFocusNode,
                placeholder: "Cari barang",
                leading: BackButton(
                  onPressed: (){
                    Navigator.of(context).pop(provider.choosenBarang);
                  },
                ),
                onValueChange: (_) => provider.tryRefreshPagination(),
                onSubmit: (_) => provider.searchBarangFocusNode.requestFocus(),
              ),
              body: const PilihBarangScaffoldBody(),
              bottomNavigationBar: const DoneCard(),
            ),
          );
        }
      ),
    );
  }
  
  void handlePop(PilihBarangProvider provider){
    onPopDone(provider.choosenBarang);
  }

}
