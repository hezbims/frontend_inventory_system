import 'dart:convert';

import 'package:common/constant/json_field/barang_field.dart';
import 'package:common/constant/json_field/kategori_field.dart';
import 'package:common/constant/json_field/rak_field.dart';
import 'package:fitur_buat_laporan/domain/model/data_laporan.dart';
import 'package:fitur_buat_laporan/domain/model/transaksi_barang_summary.dart';

class GetDataLaporanMapper {
  List<DataLaporan> fromBodyToListDataLaporan(String body){
    final jsonBody = jsonDecode(body);
    final data = jsonBody['data'].cast<Map<String , dynamic>>() as List<Map<String , dynamic>>;

    return data.map(
      (json) => DataLaporan(
        namaKategori: json[KategoriField.nama],
        barang: json[KategoriField.barang].map(
          (jsonBarang) =>
            TransaksiBarangSummary(
              kodeBarang: jsonBarang[BarangField.kodeBarang],
              nomorRak: jsonBarang[RakField.nomorRak],
              nomorLaci: jsonBarang[RakField.nomorLaci],
              nomorKolom: jsonBarang[RakField.nomorKolom],
              namaBarang: jsonBarang[BarangField.nama],
              uom: jsonBarang[BarangField.uom],
              minStock: jsonBarang[BarangField.minStock],
              lastMonthStock: jsonBarang[BarangField.lastMonthStock],
              currentStock: jsonBarang[BarangField.currentStock],
              totalMasuk: jsonBarang[BarangField.totalMasuk],
              totalKeluar: jsonBarang[BarangField.totalKeluar],
              unitPrice: jsonBarang[BarangField.unitPrice],
              amount: jsonBarang[BarangField.amount],
            ),
        ).cast<TransaksiBarangSummary>().toList()
      ),
    ).cast<DataLaporan>().toList();
  }
}