
import 'dart:math';

import 'package:common/domain/model/page_result.dart';
import 'package:common/domain/model/response_wrapper.dart';
import 'package:common/presentation/api_loader/response_builder.dart';
import 'package:common/presentation/pagination/page_number_ui_controller.dart';
import 'package:common/presentation/provider/refresh_notifier_listener.dart';
import 'package:common/presentation/styling/color/my_colors.dart';
import 'package:common/presentation/tab_navbar/main_tab_nav_bar.dart';
import 'package:common/routing/my_route_state.dart';
import 'package:common/routing/my_route_state_provider.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_buat_laporan/presentation/page/download_monthly_report_dialog.dart';
import 'package:fitur_lihat_stock_barang/domain/model/preview_barang.dart';
import 'package:fitur_lihat_stock_barang/presentation/component/list_stock_barang_table.dart';
import 'package:common/presentation/layouting/scroll_or_fill_column_wrapper.dart';
import 'package:fitur_lihat_stock_barang/presentation/provider/kategori_filter_provider.dart';
import 'package:fitur_lihat_stock_barang/presentation/provider/lihat_stock_barang_provider.dart';
import 'package:flutter/material.dart';

class LihatStockBarangScreen extends StatelessWidget {
  const LihatStockBarangScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchKey = GlobalKey();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GetIt.I.get<LihatStockBarangProvider>()
        ),
        ChangeNotifierProvider(
          create: (context) =>  GetIt.I.get<KategoriFilterProvider>(),
        ),
      ],
      child: RefreshNotifierListener(
        listener: (context){
          context.read<LihatStockBarangProvider>().refreshListBarang();
        },
        builder: (context) {
          final stockBarangProvider = context.watch<LihatStockBarangProvider>();
          final routeStateProvider = context.read<MyRouteStateProvider>();

          return Scaffold(
            appBar: AppBar(
              title: const Text("company name"),
              forceMaterialTransparency: true,
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: max(1048, MediaQuery.of(context).size.width),
                child: ScrollOrFillColumnWrapper(
                  padding: EdgeInsets.symmetric(
                    horizontal: max(24, (MediaQuery.of(context).size.width - 1000) / 2),
                  ),
                  isFillMaxSize: stockBarangProvider.listBarangResponse is! ResponseSucceed,
                  children: [
                    const SizedBox(height: 48,),

                    const MainTabNavBar(),

                    const SizedBox(height: 64,),

                    Row(
                      children: [
                        FilledButton(
                          onPressed: (){
                            routeStateProvider.setRouteState(RouteInputFormDataBarangState(
                              idBarang: null
                            ));
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: MyColors.primary3,
                            padding: const EdgeInsets.all(20),
                          ),
                          child: const Text("Add New Product"),
                        ),

                        const SizedBox(width: 48,),

                        SizedBox(
                          width: 480,
                          child: TextField(
                            decoration: const InputDecoration(
                              label: Text("Search Product"),
                              suffixIcon: Icon(Icons.search),
                            ),
                            key: searchKey,
                            onChanged: stockBarangProvider.changeSearchQuery,
                          ),
                        ),

                        const SizedBox(width: 8,),

                        IconButton(
                          onPressed: (){

                          },
                          icon: const Icon(Icons.filter_list)
                        ),

                        const SizedBox(width: 8,),

                        IconButton(
                          onPressed: (){
                            showDialog(
                              context: context,
                              builder: (context) =>
                                const Dialog(
                                  child: DownloadMonthlyReportDialog(),
                                )
                            );
                          },
                          icon: const Icon(Icons.print)
                        ),

                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PageNumberUiController(
                                currentPage: stockBarangProvider.filterState.pageNumber,
                                hasNextPage: stockBarangProvider.hasNextPage,
                                hasPrevPage: stockBarangProvider.hasPrevPage,
                                onClickForward: stockBarangProvider.onClickForwardPage,
                                onClickBackward: stockBarangProvider.onClickBackwardPage,
                                onClickFirst: stockBarangProvider.onClickToFirstPage,
                                onClickLatest: stockBarangProvider.onClickToLatestPage,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16,),

                    ResponseBuilder<PageResult<PreviewBarang>, Object>(
                      apiResponse: stockBarangProvider.listBarangResponse,
                      onRefresh: stockBarangProvider.refreshListBarang,
                      builder: (BuildContext context, PageResult<PreviewBarang> pageData){
                        return ListStockBarangTable(
                            pageNumber: stockBarangProvider.filterState.pageNumber,
                            onClickEdit: (idBarang){
                              routeStateProvider.setRouteState(RouteInputFormDataBarangState(idBarang: idBarang));
                            },
                            listBarang: pageData.listData,
                        );
                      },
                      loadingBuilder: (BuildContext context, Widget defaultLoadingBuilder) {
                        return Expanded(child: Center(child: defaultLoadingBuilder));
                      },
                      errorBuilder: (BuildContext context, Widget defaultErrorBuilder){
                        return Expanded(child: Center(child: defaultErrorBuilder));
                      },
                    )
                  ]
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
