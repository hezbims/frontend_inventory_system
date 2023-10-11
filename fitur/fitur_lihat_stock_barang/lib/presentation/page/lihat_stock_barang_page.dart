import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:common/presentation/api_loader/default_error_widget.dart';
import 'package:common/presentation/bottom_navbar/stock_bottom_navbar.dart';
import 'package:common/presentation/textfield/search_with_filter_app_bar.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:common/constant/routes/routes_path.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/infinite_scroll_pagination.dart';
import 'package:dependencies/provider.dart';
import 'package:common/domain/model/barang.dart';
import 'package:fitur_lihat_stock_barang/presentation/component/barang_card.dart';
import 'package:fitur_lihat_stock_barang/presentation/component/filter_drawer.dart';
import 'package:fitur_lihat_stock_barang/presentation/provider/lihat_stock_barang_provider.dart';
import 'package:flutter/material.dart';

class LihatStockBarangPage extends StatelessWidget {
  const LihatStockBarangPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GetIt.I.get<LihatStockBarangProvider>(),
      child: Consumer<LihatStockBarangProvider>(
        builder: (context , provider , child) {
          return Scaffold(
            endDrawerEnableOpenDragGesture: false,
            endDrawer: const FilterDrawer(),
            appBar: SearchWithFilterAppBar(
              label: "Cari nama barang",
              onFilterPressed: (context){
                Scaffold.of(context).openEndDrawer();
              },
              searchController: provider.namaController,
              onValueChange: (newValue) => provider.tryApiCall(),
            ),
            floatingActionButton: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).phoneLandscapePadding,
              ),
              child: FloatingActionButton(
                onPressed: () async {
                  final result = await Navigator.of(context).pushNamed(
                      RoutesPath.inputDataBarangPath
                  );

                  if (result != null){
                    provider.tryApiCall();
                  }
                },
                child: const Icon(Icons.add),
              ),
            ),
            bottomNavigationBar: const StockBottomNavBar(
              currentIndex: RoutesPath.lihatStockBarangIndex,
            ),
            body: PagedListView<int , Barang>.separated(
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
            ),
          );
        }
      ),
    );
  }
}
