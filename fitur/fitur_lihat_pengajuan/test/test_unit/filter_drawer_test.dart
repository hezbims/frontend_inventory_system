
import 'package:common/constant/test_tags/test_tags.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/filter_pengaju/choosen_pengaju_field.dart';
import 'package:fitur_lihat_pengajuan/presentation/pages/filter_pengaju_drawer.dart';
import 'package:fitur_lihat_pengajuan/presentation/provider/filter_pengaju_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/prepare_mock_pengaju_repository.dart';

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Diberikan tampilan drawer filter pengaju, '
    'ketika tipe pengaju dipilih menjadi pemasok, '
    'lalu ketika suatu pengaju dipilih, '
    'maka ia akan tampil sebagai yang dipilih pada card yang sudah ditentukan, ',
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
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pump();
    await tester.tap(find.text('Pemasok'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('pemasok-2'));
    await tester.pump();
    expect(
      find.descendant(
        of: find.byType(ChoosenPengajuField),
        matching: find.text('pemasok-2')
      ),
      findsOneWidget
    );

  } , tags: [TestTags.fastTest]);
}