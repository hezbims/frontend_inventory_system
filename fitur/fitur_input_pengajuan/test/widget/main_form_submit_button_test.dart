import 'package:common/domain/model/user.dart';
import 'package:common/presentation/button/disabled_submit_button.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:fitur_input_pengajuan/presentation/pages/main_form.dart';
import 'package:fitur_input_pengajuan/presentation/provider/main_form/main_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/mock_submit_pengajuan_repository.dart';

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('''
    Diberikan sebuah main form dengan pengajuan yang sudah ditolak,
    ketika user, adalah user biasa,
    maka submit button akan terdisable
  ''', (tester) async {
    GetIt.I.registerFactoryParam(
      (Pengajuan? initialData , _) =>
        MainFormProvider(
          user: User(token: '', username: '', isAdmin: false, id: 0),
          initialData: initialData,
          repository: MockSubmitPengajuanRepository()
        ),
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: MainForm(initialData: null),
      )
    );

    expect(find.byType(DisabledSubmitButton), findsOneWidget);
  });
}