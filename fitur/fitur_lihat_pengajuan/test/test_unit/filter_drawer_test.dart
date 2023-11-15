import 'package:common/constant/test_tags/test_tags.dart';
import 'package:common/domain/model/pengaju.dart';
import 'package:common/presentation/textfield/custom_dropdown_menu.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/filter_pengaju_drawer.dart';
import 'package:fitur_lihat_pengajuan/presentation/provider/filter_pengaju_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/prepare_mock_pengaju_repository.dart';

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Diberikan tampilan drawer filter pengaju, '
    'ketika tipe pengaju dipilih menjadi pemasok, '
    'maka di dropdown pilih pengaju, '
    'hanya pemasok-pemasok yang keluar',
  (tester) async {
    final mockRepo = prepareMockPengajuRepository();

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => FilterPengajuProvider(repository: mockRepo),
          child: const FilterPengajuDrawer()
        ),
      ),
    );

    // Milih tipe pengaju
    final dropdownTipePengaju = find.byType(CustomDropdownMenu<String>);
    expect(dropdownTipePengaju, findsOneWidget);
    await tester.tap(dropdownTipePengaju);
    await tester.pump();
    await tester.tap(find.text('Pemasok'));
    await tester.pumpAndSettle();


    // Cari dropdown pemilih nama pengaju
    final dropdownNamaPengaju = find.widgetWithText(
      CustomDropdownMenu<Pengaju>,
      'Nama Pemasok'
    );
    expect(dropdownNamaPengaju, findsOneWidget);

    // Coba buka dropdown yang berisi nama-nama pengaju
    await tester.tap(dropdownNamaPengaju);
    await tester.pumpAndSettle();
    expect(find.text('pemasok-1').last, findsOneWidget);
    expect(find.text('pemasok-2').last, findsOneWidget);

  } , tags: [TestTags.fastTest]);
}