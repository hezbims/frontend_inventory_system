import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/presentation/arg_model/main_form_to_pilih_barang_arg.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_barang/done_card.dart';
import 'package:common/presentation/textfield/search_app_bar.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_barang/pilih_barang_scaffold_body.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/pilih_barang_provider.dart';
import 'package:flutter/material.dart';

class PilihBarangScreen extends StatelessWidget {
  final MainFormToPilihBarangArg arg;
  const PilihBarangScreen({
    super.key,
    required this.arg,
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

          return WillPopScope(
            onWillPop: () async =>
              popDone(context),
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
              bottomNavigationBar: DoneCard(popDone: popDone),
            ),
          );
        }
      ),
    );
  }

  bool popDone(
    BuildContext context
  ){
    Navigator.of(context).pop(
      context.read<PilihBarangProvider>().choosenBarang,
    );
    return false;
  }

}
