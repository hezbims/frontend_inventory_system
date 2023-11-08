import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:common/domain/model/barang.dart';
import 'package:common/presentation/api_loader/default_error_widget.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:dependencies/infinite_scroll_pagination.dart';
import 'package:fitur_lihat_stock_barang/presentation/component/barang_card.dart';
import 'package:fitur_lihat_stock_barang/presentation/provider/lihat_stock_barang_provider.dart';
import 'package:flutter/material.dart';

class ListStockBarang extends StatelessWidget {
  final LihatStockBarangProvider provider;
  const ListStockBarang({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return PagedListView<int , Barang>.separated(
      padding: EdgeInsets.symmetric(
        vertical: 24,
        horizontal: MediaQuery.of(context).phoneLandscapePadding,
      ),
      pagingController: provider.pagingController,
      builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context , barang , index){
            return BarangCard(barang: barang);
          },
          newPageErrorIndicatorBuilder: (context) {
            return DefaultErrorWidget(
              onTap: provider.pagingController.retryLastFailedRequest,
              errorMessage: "Gagal Tersambung",
            );
          },
          firstPageErrorIndicatorBuilder: (context){
            return Center(
              child: DefaultErrorWidget(
                onTap: provider.pagingController.retryLastFailedRequest,
                errorMessage: "Gagal Tersambung",
              ),
            );
          }
      ),
      separatorBuilder: (context , index){
        return const VerticalFormSpacing();
      },
    );
  }
}
