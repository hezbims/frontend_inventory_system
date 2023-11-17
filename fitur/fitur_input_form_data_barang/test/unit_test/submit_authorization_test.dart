import 'package:common/constant/test_tags/test_tags.dart';
import 'package:common/domain/model/barang.dart';
import 'package:common/domain/model/kategori.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/presentation/button/disabled_submit_button.dart';
import 'package:common/presentation/button/submit_button.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_form_data_barang/presentation/page/input_data_barang_page.dart';
import 'package:fitur_input_form_data_barang/presentation/provider/input_data_barang_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/mock_submit_pengajuan_repository.dart';

void main(){
  final initialBarang = Barang(
    id: 1,
    kodeBarang: "R1-26",
    nama: 'barang-1',
    nomorRak: 1,
    nomorLaci: 1,
    nomorKolom: 1,
    minStock: 2,
    stockSekarang: 1,
    lastMonthStock: 1,
    unitPrice: 1,
    kategori: Kategori(id: 1, nama: 'kategori-1'),
    uom: 'pc'
  );
  setUp((){
    GetIt.I.registerFactoryParam((Barang? init, _) =>
      InputDataBarangProvider(
        repository: MockSubmitPengajuanRepository(),
        initialData: init
      ),
    );
  });
  tearDown((){
    GetIt.I.reset();
  });

  testWidgets(
    "Diberikan input data barang page dalam mode editing, "
    "ketika user adalah admin, "
    "maka submit buttonnya tidak terdisable"
  , (tester) async {
    GetIt.I.registerSingleton(
      User(token: '', username: '-', isAdmin: true, id: 1)
    );
    await tester.pumpWidget(
      MaterialApp(
        home: InputDataBarangPage(
          initialBarang: initialBarang
        ),
      ),
    );
    expect(find.byType(SubmitButton), findsOneWidget);
  } , tags: [TestTags.fastTest]);

  testWidgets(
    "Diberikan input data barang page dalam mode editing, "
    "Ketika user bukan admin, "
    "maka submit buttonnya akan terdisable"
  , (tester) async {
    GetIt.I.registerSingleton(
      User(token: '', username: '-', isAdmin: false, id: 1)
    );
    await tester.pumpWidget(
      MaterialApp(
        home: InputDataBarangPage(initialBarang: initialBarang)
      ),
    );
    expect(find.byType(DisabledSubmitButton), findsOneWidget);
  } , tags: [TestTags.fastTest]);

}