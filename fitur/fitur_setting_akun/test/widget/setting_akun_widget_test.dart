import 'package:common/constant/test_tags/test_tags.dart';
import 'package:common/domain/model/user.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_setting_akun/presentation/provider/setting_akun_provider.dart';
import 'package:fitur_setting_akun/presentation/page/setting_akun_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'setting_akun_mock_repository.dart';


void main(){
  setUpAll((){
    GetIt.I.registerSingleton(
        User(token: '', username: 'admin', isAdmin: true, id: -1)
    );
    GetIt.I.registerSingleton(
      SettingAkunProvider(repository: SettingAkunMockRepository())
    );
  });

  testWidgets(
    'Ketika user adalah admin, '
    'maka tampilan buat akun akan keliatan'
  , (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: SettingAkunPage(),
        ),
      )
    );

    // harus di pump
    await tester.pump();
    final tambahAkunItem = find.text('Tambah akun baru');

    expect(tambahAkunItem, findsOneWidget);

  } , tags: TestTags.fastTest);
}