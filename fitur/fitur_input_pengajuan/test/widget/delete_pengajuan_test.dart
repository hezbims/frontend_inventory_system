import 'package:common/constant/enums/status_pengajuan.dart';
import 'package:common/constant/test_tags/test_tags.dart';
import 'package:common/domain/model/pengaju.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/rflutter_alert.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:fitur_input_pengajuan/presentation/pages/main_form_screen.dart';
import 'package:fitur_input_pengajuan/presentation/provider/main_form/main_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/mock_submit_pengajuan_repository.dart';

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();

  final repository = MockSubmitPengajuanRepository();
  final adminUser = User(token: '', username: '', isAdmin: true, id: 1);
  final nonAdminUser = User(token: '', username: '', isAdmin: false, id: 1);
  late User currentUser;
  final defaultPengajuan = Pengajuan(
    id: 1,
    tanggal: DateTime(2023),
    pengaju: Pengaju(nama: 'hezbi', id: 2, isPemasok: false),
    status: StatusPengajuan.ditolak,
  );

  setUp((){
    currentUser = adminUser;
  });

  setUpAll((){
    GetIt.I.registerFactory(() => currentUser);
    GetIt.I.registerFactoryParam(
      (Pengajuan? initialPengajuan , _) =>
        MainFormProvider(
          user: GetIt.I.get(),
          initialData: initialPengajuan,
          repository: repository
        ),
    );
  });
  testWidgets(
    "Diberikan main form dengan sebuah pengajuan, "
    "apabila user mengkonfirmasi proses delete pengajuan, "
    "maka user akan kembali ke halaman sebelumnya"
  , (tester) async {
    when(() => repository.deletePengajuan(any())).thenAnswer(
      (invocation) => Future.delayed(
        const Duration(seconds: 2),
        () => ApiResponseSuccess(),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: MainFormScreen(
          initialData: defaultPengajuan
        ),
      ),
    );

    await tester.tap(
      find.descendant(
        of: find.byType(AppBar),
        matching: find.byIcon(Icons.delete),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(DialogButton, 'Ya'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    while (find.byType(CircularProgressIndicator).evaluate().isNotEmpty){
      await tester.pump(const Duration(milliseconds: 500));
    }

    await tester.pumpAndSettle();
    expect(find.byType(MainFormScreen), findsNothing);
  } , tags: [TestTags.fastTest]);

  testWidgets(
    "Diberikan main form tanpa initial pengajuan (pengajuan baru), "
    "maka tombol delete pengajuan tidak akan tampil"
  , (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MainFormScreen(initialData: null),
        )
      );

      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.byIcon(Icons.delete)
        ),
        findsNothing
      );
  } , tags: [TestTags.fastTest]);

  testWidgets(
    "Diberikan main form dengan status pengajuan ditolak, "
    "ketika current user adalah non admin, "
    "Maka tombol delete pengajuan tidak akan tampil",
    (tester) async {
      currentUser = nonAdminUser;

      await tester.pumpWidget(
        MaterialApp(
          home: MainFormScreen(initialData: defaultPengajuan),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.byIcon(Icons.delete)
        ),
        findsNothing
      );
    } , tags: [TestTags.fastTest]
  );
}