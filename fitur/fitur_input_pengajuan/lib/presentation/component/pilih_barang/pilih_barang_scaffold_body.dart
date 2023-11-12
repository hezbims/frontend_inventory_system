import 'package:dependencies/fluttertoast.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/presentation/component/common/transaksi_barang_bottom_sheet.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_barang/list_barang_paginator.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/pilih_barang_provider.dart';
import 'package:flutter/material.dart';

class PilihBarangScaffoldBody extends StatefulWidget {
  const PilihBarangScaffoldBody({super.key});

  @override
  State<PilihBarangScaffoldBody> createState() => _PilihBarangScaffoldBodyState();
}

class _PilihBarangScaffoldBodyState extends State<PilihBarangScaffoldBody> {
  late final provider = Provider.of<PilihBarangProvider>(
    context,
    listen: false
  );

  @override
  void initState() {
    super.initState();
    provider.addListener(_tryShowBottomSheet);
  }
  @override
  void dispose(){
    provider.removeListener(_tryShowBottomSheet);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListBarangPaginator(provider: provider);
  }


  void _tryShowBottomSheet() async {
    if (provider.isBottomSheetShowing){ return; }

    final barang = provider.barangBottomSheet;
    if (barang == null){ return; }

    provider.setBarangBottomSheet(null);

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
    if (!mounted){ return; }
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

    // Setelah selesai memperlihatkan bottom sheet, langsung focus lagi ke search bar
    provider.searchBarangFocusNode.requestFocus();

    if (result is BarangTransaksi) {
      provider.addNewBarangTransaksi(result);
    }
  }
}
