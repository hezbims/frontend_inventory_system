import 'package:common/domain/model/barang.dart';
import 'package:common/presentation/api_loader/api_loader.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/presentation/component/preview_stock_barang_card.dart';
import 'package:fitur_input_pengajuan/presentation/provider/input_pengajuan_provider.dart';
import 'package:flutter/material.dart';

class PilihListBarangPage extends StatelessWidget {
  const PilihListBarangPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final initialProvider =
        ModalRoute.of(context)?.settings.arguments as InputPengajuanProvider;
    return ChangeNotifierProvider.value(
      value: initialProvider,
      child: Consumer<InputPengajuanProvider>(
        builder: (context , provider , child) {
          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              centerTitle: true,
              title: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: provider.searchBarangController,
                      decoration: const InputDecoration(
                        label: Text("Cari barang"),
                        prefixIcon: Icon(Icons.search)
                      ),
                    ),
                  ),

                  const SizedBox(width: 48,),
                ],
              ),
              // leading: const BackButton(),
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
          );
        }
      ),
    );

  }
}
