import 'package:common/constant/enums/status_pengajuan.dart';
import 'package:common/constant/test_tags/test_tags.dart';
import 'package:common/domain/model/barang.dart';
import 'package:common/domain/model/kategori.dart';
import 'package:common/domain/model/pengaju.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:fitur_input_pengajuan/presentation/arg_model/main_form_to_pilih_barang_arg.dart';
import 'package:fitur_input_pengajuan/presentation/component/common/transaksi_barang_bottom_sheet.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_barang/barang_quantity_incrementer.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_barang/preview_stock_barang_card.dart';
import 'package:fitur_input_pengajuan/presentation/pages/main_form_screen.dart';
import 'package:fitur_input_pengajuan/presentation/pages/pilih_barang_screen.dart';
import 'package:fitur_input_pengajuan/presentation/provider/main_form/main_form_provider.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/bottom_sheet_barang_provider.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/pilih_barang_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../mock/mock_barang_repository.dart';
import '../mock/mock_submit_pengajuan_repository.dart';

void main(){

  TestWidgetsFlutterBinding.ensureInitialized();
  /// Mendapatkan textfield keterangan yang ada di bottom sheet
  TextField getKeteranganTextField(WidgetTester tester)  {
    final keteranganTextFieldFinder = find.descendant(
        of: find.byType(CustomTextfield),
        matching: find.byType(TextField)
    );
    return tester.widget(keteranganTextFieldFinder) as TextField;
  }

  /// Mendapatkan textfield quantity yang ada di bottom sheet
  TextField getQuantityTextField(WidgetTester tester) {
    final quantityTextFieldFinder = find.descendant(
        of: find.byType(BarangQuantityIncrementer),
        matching: find.byType(TextField)
    );
    return tester.widget(quantityTextFieldFinder) as TextField;
  }

  testWidgets(
    "ketika tombol edit sebuah barang ajuan di main form di tekan, "
    "maka quantity dan keterangan awalan yang tampil pada textfield di bottom sheet, "
    "akan tampil sama dengan quantity dan keterangan dari barang ajuan tersebut",
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MainFormScreen(
            initialData: Pengajuan(
              id: 1,
              tanggal: DateTime.now(),
              pengaju: Pengaju(nama: 'g', id: -1, isPemasok: false),
              status: StatusPengajuan.menunggu,
              listBarangTransaksi: [
                BarangTransaksi(
                  id: -1,
                  idBarang: -1,
                  namaBarang: 'barang-1',
                  quantity: 5,
                  keterangan: 'hai'
                ),
              ]
            )
          ),
        )
      );

      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(TransaksiBarangBottomSheet, 'barang-1'), findsOneWidget);
      expect(getQuantityTextField(tester).controller!.text , '5');
      expect(getKeteranganTextField(tester).controller!.text, 'hai');

    } , tags: [TestTags.fastTest]
  );

  testWidgets(
    "Ketika user menekan kartu barang pada tampilan pemilihan barang, "
    "maka pada bottom sheet yang muncul, "
    "nilai dari quantity textfield adalah 0, "
    "nilai dari keterangan textfield adalah kosong, "
    "dan judul bottom sheetnya adalah sesuai dengan barang yang dipilih",
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PilihBarangScreen(
            arg: MainFormToPilihBarangArg(
              initialList: [],
              isPemasukan: true
            ),
            onPopDone: (_){},
          ),
        ),
      );
      await tester.pump();
      final stockBarangCard = find.widgetWithText(PreviewStockBarangCard , 'barang-1');
      await tester.tap(stockBarangCard);
      await tester.pumpAndSettle();

      expect(find.widgetWithText(TransaksiBarangBottomSheet, 'barang-1'), findsOneWidget);
      expect(getQuantityTextField(tester).controller!.text, '0');
      expect(getKeteranganTextField(tester).controller!.text, '');
    } , tags: [TestTags.fastTest]
  );

  setUpAll((){
    // Main form dependency injection
    GetIt.I.registerFactoryParam(
      (Pengajuan? initialPengajuan, _) =>
        MainFormProvider(
          user: User(
            token: '',
            username: '',
            isAdmin: true,
            id: -1
          ),
          initialData: initialPengajuan,
          repository: MockSubmitPengajuanRepository()
        ),
    );

    // Bottom Sheet dependency injection
    GetIt.I.registerFactoryParam(
      (BarangTransaksi initialData , _) =>
        BottomSheetBarangProvider(initialBarangTransaksi: initialData)
    );

    final mockBarangRepository = MockBarangRepository();
    when(() => mockBarangRepository.getStockBarangPaginated(
        pageNumber: 1,
        keyword: '',
        idKategori: 0
    )).thenAnswer((_) async => ApiResponseSuccess(
      data: <Barang>[
        Barang(
          id: -1, kodeBarang: '', nama: 'barang-1', nomorRak: 1, nomorLaci: 1,
          nomorKolom: 1, minStock: 1, stockSekarang: 1, lastMonthStock: 1,
          unitPrice: 1, kategori: Kategori(id: 1, nama: ''), uom: 'p'
        ),
        Barang(
          id: -1, kodeBarang: '', nama: 'barang-2', nomorRak: 1, nomorLaci: 1,
          nomorKolom: 1, minStock: 1, stockSekarang: 1, lastMonthStock: 1,
          unitPrice: 1, kategori: Kategori(id: 1, nama: ''), uom: 'p'
        ),
      ],
      isNextDataExist: false,
    ));
    //
    GetIt.I.registerFactoryParam(
          (MainFormToPilihBarangArg arg, param2) => PilihBarangProvider(
        barangRepository: mockBarangRepository,
        isPemasukan: arg.isPemasukan,
        choosenBarang: arg.initialList,
      ),
    );
  });
}