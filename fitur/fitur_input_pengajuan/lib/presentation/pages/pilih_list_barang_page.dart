import 'package:dependencies/infinite_scroll_pagination.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/data/repository/barang_preview_repository_impl.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_preview.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_barang/preview_stock_barang_card.dart';
import 'package:common/presentation/textfield/search_app_bar.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/pilih_barang_provider.dart';
import 'package:flutter/material.dart';

class PilihListBarangPage extends StatelessWidget {
  const PilihListBarangPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final initialList = ModalRoute.of(context)?.settings.arguments as List<BarangTransaksi>;
    return ChangeNotifierProvider(
      create: (context) => PilihBarangProvider(
        barangRepository: BarangPreviewRepositoryImpl(),
        choosenBarang: initialList,
      ),
      child: Consumer<PilihBarangProvider>(
        builder: (context , provider , child) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              provider.requestFocus();
            }
          );
          return WillPopScope(
            onWillPop: () async {
              Navigator.of(context).pop(provider.choosenBarang);
              return false;
            },
            child: Scaffold(
              appBar: SearchAppBar(
                controller: provider.searchBarangController,
                focusNode: provider.searchBarangFocusNode,
                placeholder: "Cari barang",
                leading: BackButton(
                  onPressed: (){
                    Navigator.of(context).pop(provider.choosenBarang);
                  },
                ),
              ),
              body: PagedListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: 36,
                  horizontal: 24,
                ),
                pagingController: provider.pagingController,
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (context , BarangPreview item , index){
                    return PreviewStockBarangCard(barang: item);
                  },
                ),
                separatorBuilder: (context , index){
                  return const SizedBox(height: 10,);
                },
              ),
            ),
          );
        }
      ),
    );

  }
}
