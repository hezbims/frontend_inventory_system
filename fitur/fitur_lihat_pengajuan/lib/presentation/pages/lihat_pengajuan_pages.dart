import 'package:common/domain/model/pengajuan.dart';
import 'package:common/presentation/api_loader/api_loader.dart';
import 'package:common/presentation/bottom_navbar/stock_bottom_navbar.dart';
import 'package:common/routes/routes.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_lihat_pengajuan/data/repository/fake_lihat_pengajuan_repository.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/pengajuan_card.dart';
import 'package:fitur_lihat_pengajuan/presentation/provider/lihat_pengajuan_provider.dart';
import 'package:flutter/material.dart';

class LihatPengajuanPages extends StatelessWidget {
  const LihatPengajuanPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LihatPengajuanProvider(
        repository: FakeLihatPengajuanRepository(),
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
            body: ApiLoader(
              apiResponse: provider.getAllPengajuanResponse,
              onRefresh: provider.refreshData,
              builder: (List<Pengajuan> data){
                return ListView.separated(
                  padding: const EdgeInsets.all(24),
                  itemBuilder: (context , index){
                    return PengajuanCard(pengajuan: data[index]);
                  },
                  separatorBuilder: (context , index){
                    return const SizedBox(height: 24,);
                  },
                  itemCount: data.length
                );
              }
            ),
          );
        }
      ),
    );
  }
}
