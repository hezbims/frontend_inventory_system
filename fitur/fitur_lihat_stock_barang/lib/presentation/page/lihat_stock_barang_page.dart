import 'package:common/presentation/bottom_navbar/stock_bottom_navbar.dart';
import 'package:common/presentation/textfield/search_with_filter_app_bar.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:common/routes/routes.dart';
import 'package:dependencies/infinite_scroll_pagination.dart';
import 'package:dependencies/provider.dart';
import 'package:common/data/repository/fake_lihat_stock_barang_repository.dart';
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
      create: (context) => LihatStockBarangProvider(
        repository: FakeLihatStockBarangRepository(),
      ),
      child: Consumer<LihatStockBarangProvider>(
        builder: (context , provider , child) {
          return Scaffold(
            key: provider.scaffoldKey,
            endDrawerEnableOpenDragGesture: false,
            endDrawer: const FilterDrawer(),
            appBar: SearchWithFilterAppBar(
              onFilterPressed: (){
                provider.scaffoldKey.currentState?.openEndDrawer();
              },
              searchController: provider.namaController,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.of(context).pushNamed(Routes.fiturInputDataBarangRoute);
              },
              child: const Icon(Icons.add),
            ),
            bottomNavigationBar: const StockBottomNavBar(
              currentIndex: Routes.fiturLihatStockBarangIndex,
            ),
            body: PagedListView<int , Barang>.separated(
              padding: const EdgeInsets.all(24),
              pagingController: provider.pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context , barang , index){
                  return BarangCard(barang: barang);
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
