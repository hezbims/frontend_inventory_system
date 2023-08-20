import 'package:common/presentation/api_loader/default_error_widget.dart';
import 'package:common/presentation/bottom_navbar/stock_bottom_navbar.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:common/routes/routes.dart';
import 'package:dependencies/infinite_scroll_pagination.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_lihat_pengajuan/data/repository/lihat_pengajuan_repository_impl.dart';
import 'package:fitur_lihat_pengajuan/domain/model/pengajuan_preview.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/pengajuan_card.dart';
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
            appBar: AppBar(
              scrolledUnderElevation: 0,
              title: const Text("List Pengajuan"),
              centerTitle: true,
            ),
            bottomNavigationBar: const StockBottomNavBar(
              currentIndex: Routes.fiturLihatPengajuanIndex,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.of(context).pushNamed(
                  Routes.fiturInputDataPengajuanRoute
                );
              },
              child: const Icon(Icons.add),
            ),
            body: PagedListView.separated(
              pagingController: provider.pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context , PengajuanPreview pengajuan , index){
                  return PengajuanCard(
                    pengajuan: pengajuan,
                    onTap: (){
                      Navigator.of(context).pushNamed(
                        Routes.fiturInputDataPengajuanRoute,
                        arguments: pengajuan.id,
                      );
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
