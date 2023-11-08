import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:dependencies/infinite_scroll_pagination.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_preview.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_barang/preview_stock_barang_card.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/pilih_barang_provider.dart';
import 'package:flutter/material.dart';

class ListBarangPaginator extends StatelessWidget {
  final PilihBarangProvider provider;
  final void Function({
    required BuildContext context ,
    required BarangPreview barang}) tryShowBottomSheet;

  const ListBarangPaginator({
    super.key,
    required this.provider,
    required this.tryShowBottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return PagedListView.separated(
      padding: EdgeInsets.symmetric(
        vertical: 36,
        horizontal: MediaQuery.of(context).phoneLandscapePadding,
      ),
      pagingController: provider.pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context , BarangPreview item , index){
          return PreviewStockBarangCard(
            barang: item,
            onTap: (){
              tryShowBottomSheet(context: context, barang: item);
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
