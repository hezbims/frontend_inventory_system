import 'package:common/domain/model/barang.dart';
import 'package:common/domain/model/kategori.dart';
import 'package:flutter_test/flutter_test.dart';

import 'input_data_barang_ke_form.dart';

Future<void> inputDuaBarang({required WidgetTester tester}) async {
  // Mencoba input barang baru
  await inputDataBarangKeForm(
      data: Barang(
        id: -1,
        kodeBarang: "",
        nama: 'Barang 1',
        minStock: 2,
        nomorRak: 2,
        nomorLaci: 3,
        nomorKolom: 4,
        stockSekarang: 25,
        lastMonthStock: 10,
        unitPrice: 2500,
        kategori: Kategori(id: -1, nama: 'Kategori 1'),
        uom: 'Liter',
      ),
      tester: tester
  );
  await inputDataBarangKeForm(
      data: Barang(
        id: -1,
        kodeBarang: "",
        nama: 'Barang 2',
        minStock: 2,
        nomorRak: 2,
        nomorLaci: 3,
        nomorKolom: 5,
        stockSekarang: 20,
        lastMonthStock: 10,
        unitPrice: 3000,
        kategori: Kategori(id: -1, nama: 'Kategori 2'),
        uom: 'Pc',
      ),
      tester: tester
  );
}