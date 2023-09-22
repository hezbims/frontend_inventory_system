import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:common/presentation/api_loader/default_error_widget.dart';
import 'package:common/presentation/bottom_navbar/stock_bottom_navbar.dart';
import 'package:common/presentation/textfield/search_with_filter_app_bar.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:common/constant/routes/routes.dart';
import 'package:dependencies/infinite_scroll_pagination.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_lihat_pengajuan/data/repository/lihat_pengajuan_repository_impl.dart';
import 'package:fitur_lihat_pengajuan/domain/model/pengajuan_preview.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/pengajuan_card.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/transaksi_drawer.dart';
import 'package:fitur_lihat_pengajuan/presentation/provider/lihat_pengajuan_provider.dart';
import 'package:flutter/material.dart';

class LihatPengajuanPages extends StatelessWidget {
  const LihatPengajuanPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LihatPengajuanProvider(
        repository: LihatPengajuanRepositoryImpl(),
      ),
      child: Consumer<LihatPengajuanProvider>(
        builder: (context , provider , child) {
          return Scaffold(
            key: provider.scaffoldKey,
            appBar: SearchWithFilterAppBar(
              label: "Cari transaksi ",
              hintText: "ex : TRXI20220914001",
              onFilterPressed: (){},
              searchController: provider.searchController,
              onValueChange: (_) => provider.tryRefresh(),
            ),
            endDrawer: const TransaksiDrawer(),
            bottomNavigationBar: const StockBottomNavBar(
              currentIndex: Routes.fiturLihatPengajuanIndex,
            ),
            floatingActionButton: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).maxHorizontalPadding,
              ),
              child: FloatingActionButton(
                onPressed: () async {
                  final result = await Navigator.of(context).pushNamed(
                    Routes.fiturInputDataPengajuanRoute
                  );

                  if (result != null){
                    provider.pagingController.refresh();
                  }
                },
                child: const Icon(Icons.add),
              ),
            ),
            body: PagedListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).maxHorizontalPadding,
                vertical: 24,
              ),
              pagingController: provider.pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context , PengajuanPreview pengajuan , index){
                  return PengajuanCard(
                    pengajuan: pengajuan,
                    onTap: () async {
                      final result = await Navigator.of(context).pushNamed(
                        Routes.fiturInputDataPengajuanRoute,
                        arguments: pengajuan.id,
                      );

                      if (result != null){
                        provider.pagingController.refresh();
                      }
                    },
                  );
                },
                firstPageErrorIndicatorBuilder: (context){
                  return DefaultErrorWidget(
                    onTap: provider.pagingController.refresh,
                    errorMessage: provider.pagingController.error.toString(),
                  );
                }
              ),
              separatorBuilder: (context , index){
                return const VerticalFormSpacing();
              },
            )
          );
        }
      ),
    );
  }
}
