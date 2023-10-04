import 'package:common/presentation/dependency_setup/get_it_dependency_setup.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/presentation/component/common/transaksi_barang_bottom_sheet.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/bottom_sheet_barang_provider.dart';

class BottomSheetDependencySetup extends GetItDependencySetup {
  BottomSheetDependencySetup({
    super.key,
    required BarangTransaksi initialBarangTransaksi,
  }) : super(
    setup: (){
      GetIt.I.registerSingleton(
        BottomSheetBarangProvider()
      );

    },
    disposeFunction: (){
      GetIt.I.unregister<BottomSheetBarangProvider>();
    },
    page: TransaksiBarangBottomSheet(
      initialBarangTransaksi: initialBarangTransaksi
    ),
  );
}