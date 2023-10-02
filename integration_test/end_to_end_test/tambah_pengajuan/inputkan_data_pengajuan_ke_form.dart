import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:flutter_test/flutter_test.dart';

import '../extension_and_utils/cusom_widget_tester_extension.dart';
import 'buat_pengaju_baru_lalu_pilih.dart';

Future<void> inputkanDataPengajuanKeForm({
  required WidgetTester tester,
  required Pengajuan data,
}) async {
  await tester.chooseDropdown(
    dropdownLabel: 'Tipe pengajuan',
    input: data.pengaju!.isPemasok ? 'Pemasukan' : 'Pengeluaran',
  );
  await buatPengajuBaruLaluPilih(
    tester: tester,
    pengaju: data.pengaju!
  );

}