import 'package:dependencies/fluttertoast.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_preview.dart';
import 'package:fitur_input_pengajuan/presentation/arg_model/main_form_to_pilih_barang_arg.dart';
import 'package:fitur_input_pengajuan/presentation/component/common/transaksi_barang_bottom_sheet.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_barang/done_card.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_barang/list_barang_paginator.dart';
import 'package:common/presentation/textfield/search_app_bar.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/pilih_barang_provider.dart';
import 'package:flutter/material.dart';

class PilihBarangPage extends StatelessWidget {
  final MainFormToPilihBarangArg arg;
  const PilihBarangPage({
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
              body: Builder(
                builder: (context) {
                  context.select<PilihBarangProvider , void>(
                    (value){
                      final barang = provider.barangBottomSheet;
                      if (barang != null){
                        provider.doneShowBarangBottomSheet();
                        tryShowBottomSheet(context: context, barang: barang);
                      }
                    }
                  );

                  return ListBarangPaginator(
                    provider: provider,
                  );
                }
              ),
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

  void tryShowBottomSheet({
    required BuildContext context,
    required BarangPreview barang,
  }) async {
    final provider = context.read<PilihBarangProvider>();
    if (provider.isBottomSheetShowing){ return; }

    if (barang.currentStock == 0 &&
        !provider.isPemasukan) {
      Fluttertoast.showToast(msg: "Barang sudah habis!", timeInSecForIosWeb: 4);
      return;
    }
    if (provider.thisBarangAlreadyTaken(barang)) {
      Fluttertoast.showToast(msg: "Barang ini sudah pernah anda ambil!", timeInSecForIosWeb: 4);
      return;
    }

    provider.showingBottomSheet();
    final result = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return TransaksiBarangBottomSheet(
            initialBarangTransaksi: BarangTransaksi(
              id: null,
              idBarang: barang.id,
              namaBarang: barang.nama,
              quantity: 0,
              keterangan: null
            ),
          );
        }
    );
    provider.doneShowingBottomSheet();
    provider.searchBarangFocusNode.requestFocus();

    if (result is BarangTransaksi) {
      provider.addNewBarangTransaksi(result);
    }
  }
}
