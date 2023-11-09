import 'package:common/constant/test_tags/test_tags.dart';
import 'package:common/domain/model/barang.dart';
import 'package:common/domain/model/kategori.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/presentation/arg_model/main_form_to_pilih_barang_arg.dart';
import 'package:fitur_input_pengajuan/presentation/component/common/transaksi_barang_bottom_sheet.dart';
import 'package:fitur_input_pengajuan/presentation/pages/pilih_barang_page.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/bottom_sheet_barang_provider.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/pilih_barang_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/mock_barang_repository.dart';

void main(){
  testWidgets(
    "Ketika user mengetikkan suatu keyword, "
    "lalu barang yang dicari hanya terdapat satu barang, "
    "maka bottom sheet akan muncul",
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PilihBarangPage(
            arg: MainFormToPilihBarangArg(
              initialList: [],
              isPemasukan: true)
          ),
        )
      );

      final searchField = find.byType(TextField);
      expect(searchField, findsOneWidget);

      await tester.enterText(
        searchField,
        "R26E3"
      );
      await tester.pumpAndSettle();
      expect(find.byType(TransaksiBarangBottomSheet), findsOneWidget);
    } , tags: [TestTags.fastTest]
  );

  setUpAll((){
    final mockBarangRepository = prepareMockBarangRepository();
    GetIt.I.registerFactoryParam(
          (MainFormToPilihBarangArg arg , _) =>
          PilihBarangProvider(
            barangRepository: mockBarangRepository,
            isPemasukan: arg.isPemasukan,
            choosenBarang: arg.initialList,
          ),
    );
    GetIt.I.registerFactory(
            () => BottomSheetBarangProvider()
    );
  });
}

MockBarangRepository prepareMockBarangRepository(){
  final mockBarangRepository = MockBarangRepository();
  when(() =>
      mockBarangRepository.getStockBarang(
          pageNumber: 1,
          keyword: 'R26E3',
          idKategori: 0
      )
  ).thenAnswer((_) async =>
      ApiResponseSuccess(
        data: <Barang>[
          Barang(
            id: -1,
            kodeBarang: "R26E3",
            nama: 'barang-pilihan',
            nomorRak: 1,
            nomorLaci: 1,
            nomorKolom: 1,
            minStock: 1,
            stockSekarang: 1,
            lastMonthStock: 1,
            unitPrice: 1,
            kategori: Kategori(id: -1, nama: 'halo dunia'),
            uom: 'pc'
          ),
        ],
      ),
  );

  when(
    () => mockBarangRepository.getStockBarang(
      pageNumber: 1,
      keyword: '',
      idKategori: 0,
    ),
  ).thenAnswer((invocation) async {
    return ApiResponseSuccess(data: [
      for (int i = 1 ; i <= 3 ; i++)
        Barang(
          id: i,
          kodeBarang: '$i',
          nama: 'barang-$i',
          nomorRak: i,
          nomorLaci: i,
          nomorKolom: i,
          minStock: i,
          stockSekarang: i,
          lastMonthStock: i,
          unitPrice: i,
          kategori: Kategori(id: 1, nama: 'kategori-1'),
          uom: 'pc'
        ),
    ]);
  });

  return mockBarangRepository;
}

