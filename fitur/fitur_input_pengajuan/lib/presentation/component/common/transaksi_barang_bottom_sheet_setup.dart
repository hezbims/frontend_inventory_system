import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/presentation/component/common/transaksi_barang_bottom_sheet.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/bottom_sheet_barang_provider.dart';
import 'package:flutter/material.dart';

class TransaksiBarangBottomSheetBuilder extends StatelessWidget {
  final BarangTransaksi _initialBarangTransaksi;
  const TransaksiBarangBottomSheetBuilder({
    super.key,
    required BarangTransaksi initialBarangTransaksi,
  }) : _initialBarangTransaksi = initialBarangTransaksi;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomSheetBarangProvider(),
      child: TransaksiBarangBottomSheet(
        initialBarangTransaksi: _initialBarangTransaksi,
      ),
    );
  }
}
