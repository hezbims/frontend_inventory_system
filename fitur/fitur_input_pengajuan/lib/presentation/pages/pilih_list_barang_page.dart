import 'package:common/data/repository/fake_lihat_stock_barang_repository.dart';
import 'package:common/domain/model/barang.dart';
import 'package:common/presentation/api_loader/api_loader.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_barang/preview_stock_barang_card.dart';
import 'package:fitur_input_pengajuan/presentation/component/common/search_app_bar.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang_provider.dart';
import 'package:flutter/material.dart';

class PilihListBarangPage extends StatelessWidget {
  const PilihListBarangPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PilihBarangProvider(
        barangRepository: FakeLihatStockBarangRepository()
      ),
      child: Consumer<PilihBarangProvider>(
        builder: (context , provider , child) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.of(context).pop(provider.choosenBarang);
              return false;
            },
            child: Scaffold(
              appBar: SearchAppBar(
                controller: provider.searchBarangController,
                placeholder: "Cari barang",
                leading: BackButton(
                  onPressed: (){
                    Navigator.of(context).pop(provider.choosenBarang);
                  },
                ),
              ),
              body: ApiLoader<List<Barang>>(
                  apiResponse: provider.filteredBarangResponse,
                  onRefresh: provider.onRefreshStockBarang,
                  builder: (listData){
                    return ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          vertical: 36,
                          horizontal: 24,
                        ),
                        itemBuilder: (context , index){
                          return PreviewStockBarangCard(barang: listData[index]);
                        },
                        separatorBuilder: (context , index){
                          return const SizedBox(height: 10,);
                        },
                        itemCount: listData.length
                    );
                  }
              ),
            ),
          );
        }
      ),
    );

  }
}
