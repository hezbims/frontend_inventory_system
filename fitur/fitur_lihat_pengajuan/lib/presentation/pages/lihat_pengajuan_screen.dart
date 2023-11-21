import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:common/presentation/bottom_navbar/stock_bottom_navbar.dart';
import 'package:common/presentation/textfield/search_with_filter_app_bar.dart';
import 'package:common/constant/routes/routes_path.dart';
import 'package:common/routing/my_route_state.dart';
import 'package:common/routing/my_route_state_provider.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/filter_pengaju_drawer.dart';
import 'package:fitur_lihat_pengajuan/presentation/pages/lihat_pengajuan_pagination.dart';
import 'package:fitur_lihat_pengajuan/presentation/provider/filter_pengaju_provider.dart';
import 'package:fitur_lihat_pengajuan/presentation/provider/lihat_pengajuan_provider.dart';
import 'package:flutter/material.dart';

class LihatPengajuanScreen extends StatelessWidget {
  const LihatPengajuanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GetIt.I.get<LihatPengajuanProvider>(),
        ),

        ChangeNotifierProvider(
          create: (context) => GetIt.I.get<FilterPengajuProvider>(),
        ),
      ],
      child: Consumer<LihatPengajuanProvider>(
        builder: (context , provider , child) {
          final routeStateProvider = context.read<MyRouteStateProvider>();
          return Scaffold(
            appBar: SearchWithFilterAppBar(
              label: "Cari transaksi ",
              hintText: "ex : TRXI20220914001",
              onFilterPressed: (context){
                Scaffold.of(context).openEndDrawer();
              },
              searchController: provider.searchController,
              onValueChange: (_) => provider.tryRefresh(),
            ),
            endDrawer: const FilterPengajuDrawer(),
            onEndDrawerChanged: (isOpened){
              if (!isOpened){
                final filterProvider = Provider.of<FilterPengajuProvider>(
                  context,
                  listen: false
                );
                provider.setFilterPengaju(filterProvider.pengajuDipilih);
              }
            },
            bottomNavigationBar: const StockBottomNavBar(
              currentIndex: RoutesPath.fiturLihatPengajuanIndex,
            ),
            floatingActionButton: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).phoneLandscapePadding,
              ),
              child: FloatingActionButton(
                onPressed: () async {
                  routeStateProvider.setRouteState(
                    RouteInputPengajuanState(idPengajuan: null)
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
            body: LihatPengajuanPagination(provider: provider),
          );
        }
      ),
    );
  }
}
