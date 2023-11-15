import 'package:common/constant/test_tags/test_tags.dart';
import 'package:common/domain/model/pengaju.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/presentation/textfield/custom_dropdown_menu.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/pengajuan_card.dart';
import 'package:fitur_lihat_pengajuan/presentation/pages/lihat_pengajuan_pages.dart';
import 'package:fitur_lihat_pengajuan/presentation/provider/filter_pengaju_provider.dart';
import 'package:fitur_lihat_pengajuan/presentation/provider/lihat_pengajuan_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../mock/prepare_mock_lihat_pengajuan_repository.dart';
import '../mock/prepare_mock_notif_repo.dart';
import '../mock/prepare_mock_pengaju_repository.dart';

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(
    'Diberikan sebuah lihat pengajuan page, '
    'ketika filter drawer dibuka, '
    'lalu suatu pengaju dipilih, '
    'lalu back button ditekan, '
    'maka hanya pengajuan dengan pengaju dipilih yang terdisplay',
    (tester) async {
      GetIt.I.registerSingleton(User(token: '', username: '', isAdmin: true, id: 1));
      GetIt.I.registerSingleton(
        FilterPengajuProvider(repository: prepareMockPengajuRepository())
      );
      GetIt.I.registerSingleton(
        LihatPengajuanProvider(
          lihatPengajuanRepo: prepareMockLihatPengajuanRepository(),
          notifRepo: prepareMockNotifRepo(),
        ),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: LihatPengajuanPage(),
        ),
      );
      await tester.pump();
      expect(find.byType(PengajuanCard), findsNWidgets(3));

      await tester.tap(find.byIcon(Icons.filter_alt));
      await tester.pumpAndSettle();

      await tester.tap(
        find.widgetWithText(
          CustomDropdownMenu<String>, 'Tipe Pengaju'
        )
      );
      await tester.pump();
      await tester.tap(find.text('Group').last);
      await tester.pump();

      await tester.tap(
        find.widgetWithText(
          CustomDropdownMenu<Pengaju>,
          'Nama Group'
        )
      );
      await tester.pump();

      final dropdownItem = find.text('grup-2').last;
      expect(dropdownItem , findsOneWidget);
      await tester.tap(dropdownItem);
      await tester.pump();
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();

      expect(find.byType(PengajuanCard), findsOneWidget);
    },
    tags: [TestTags.fastTest],
  );
}