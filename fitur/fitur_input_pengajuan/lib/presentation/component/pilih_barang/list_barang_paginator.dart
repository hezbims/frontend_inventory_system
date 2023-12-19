import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:dependencies/infinite_scroll_pagination.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_preview.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_barang/preview_stock_barang_card.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/pilih_barang_provider.dart';
import 'package:flutter/material.dart';

class ListBarangPaginator extends StatelessWidget {
  final PilihBarangProvider provider;

  const ListBarangPaginator({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return PagedListView.separated(
      padding: EdgeInsets.symmetric(
        vertical: 36,
        horizontal: MediaQuery.of(context).phoneWidthLandscapePadding,
      ),
      pagingController: provider.pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context , BarangPreview item , index){
          return PreviewStockBarangCard(
            barang: item,
            onTap: (){
              provider.setBarangBottomSheet(item);
            },
          );
        },
      ),
      separatorBuilder: (context , index){
        return const SizedBox(height: 10,);
      },
    );
  }
}
