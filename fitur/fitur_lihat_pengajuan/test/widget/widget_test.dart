import 'package:common/constant/test_tags/test_tags.dart';
import 'package:fitur_lihat_pengajuan/presentation/pages/filter_pengaju_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  testWidgets(
      'Diberikan filter pengaju yang terbuka, '
      'jika suatu pengaju dipilih, '
      'maka ia akan tampil sebagai yang dipilih, ', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: FilterPengajuDrawer(),
      )
    );

  } , tags: [TestTags.fastTest]);
}