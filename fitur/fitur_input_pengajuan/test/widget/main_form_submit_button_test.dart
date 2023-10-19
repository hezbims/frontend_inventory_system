import 'package:common/constant/enums/status_pengajuan.dart';
import 'package:common/constant/themes/theme_color.dart';
import 'package:common/domain/model/pengaju.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/presentation/button/disabled_submit_button.dart';
import 'package:common/presentation/button/submit_button.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:fitur_input_pengajuan/presentation/pages/main_form.dart';
import 'package:fitur_input_pengajuan/presentation/provider/main_form/main_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/mock_submit_pengajuan_repository.dart';

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();

  var currentUser = User(token: '', username: '', isAdmin: false, id: 0);
  setUpAll((){
    GetIt.I.registerFactoryParam(
      (Pengajuan? initialData , _) =>
        MainFormProvider(
            user: currentUser,
            initialData: initialData,
            repository: MockSubmitPengajuanRepository()
        ),
    );
  });

  testWidgets('''
    Diberikan sebuah main form dengan pengajuan yang sudah ditolak,
    ketika user, adalah user biasa,
    maka submit button akan terdisable
  ''', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MainForm(initialData: null),
      )
    );

    expect(find.byType(DisabledSubmitButton), findsOneWidget);
  });
  
  testWidgets('''
    Diberikan sebuah main form dengan status pengajuan menunggu menunggu dan barang ajuan dengan quantity 7,
    ketika user admin mencoba mengedit quantity barang ajuan menjadi 0,
    maka warna button akan menjadi merah dan akan ada tulisan "Tolak" pada button
  ''', (tester) async {
    currentUser = User(token: '', username: '', isAdmin: true, id: 0);

    await tester.pumpWidget(
      MaterialApp(
        home: MainForm(
          initialData: Pengajuan(
            id: 0,
            tanggal: DateTime(2023),
            pengaju: Pengaju(nama: '', id: -1, isPemasok: false),
            status: StatusPengajuan.menunggu
          ),
        ),
      )
    );

    await tester.pumpAndSettle();

    final submitButtonFinder = find.descendant(
        of: find.byType(SubmitButton),
        matching: find.byType(FilledButton)
    );



    var submitButtonWidget = tester.widget(submitButtonFinder) as FilledButton;

    expect(submitButtonWidget.style?.backgroundColor?.resolve({}) , primaryColor);
  });
}