import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:common/domain/model/barang.dart';
import 'package:common/presentation/api_loader/default_error_widget.dart';
import 'package:common/presentation/provider/refresh_notifier.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:dependencies/infinite_scroll_pagination.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_lihat_stock_barang/presentation/component/barang_card.dart';
import 'package:fitur_lihat_stock_barang/presentation/provider/kategori_filter_provider.dart';
import 'package:fitur_lihat_stock_barang/presentation/provider/lihat_stock_barang_provider.dart';
import 'package:flutter/material.dart';

class StockBarangPagination extends StatefulWidget {
  final LihatStockBarangProvider provider;
  const StockBarangPagination({
    super.key,
    required this.provider,
  });

  @override
  State<StockBarangPagination> createState() => _StockBarangPaginationState();
}

class _StockBarangPaginationState extends State<StockBarangPagination> {
  late final refreshNotifier = context.read<RefreshNotifier>();
  late final kategoriFilterProvider = context.read<KategoriFilterProvider>();

  @override
  Widget build(BuildContext context) {
    return PagedListView<int , Barang>.separated(
      padding: EdgeInsets.symmetric(
        vertical: 24,
        horizontal: MediaQuery.of(context).phoneLandscapePadding,
      ),
      pagingController: widget.provider.pagingController,
      builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context , barang , index){
            return BarangCard(barang: barang);
          },
          newPageErrorIndicatorBuilder: (context) {
            return DefaultErrorWidget(
              onTap: widget.provider.pagingController.retryLastFailedRequest,
              errorMessage: widget.provider.pagingController.error.toString(),
            );
          },
          firstPageErrorIndicatorBuilder: (context){
            return Center(
              child: DefaultErrorWidget(
                onTap: widget.provider.pagingController.retryLastFailedRequest,
                errorMessage: widget.provider.pagingController.error.toString(),
              ),
            );
          }
      ),
      separatorBuilder: (context , index){
        return const VerticalFormSpacing();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    refreshNotifier.addListener(widget.provider.tryRefreshPagination);
    kategoriFilterProvider.addListener(onChangeKategori);
  }

  void onChangeKategori(){
    widget.provider.setChoosenIdKategori(
      kategoriFilterProvider.choosenKategori.id
    );
  }

  @override
  void dispose() {
    refreshNotifier.removeListener(widget.provider.tryRefreshPagination);
    kategoriFilterProvider.removeListener(onChangeKategori);
    super.dispose();
  }
}
