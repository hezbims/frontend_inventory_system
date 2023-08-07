import 'package:common/presentation/api_loader/api_loader.dart';
import 'package:common/presentation/bottom_navbar/stock_bottom_navbar.dart';
import 'package:dependencies/get.dart';
import 'package:fitur_lihat_stock_barang/domain/model/barang.dart';
import 'package:fitur_lihat_stock_barang/presentation/component/list_view_barang.dart';
import 'package:fitur_lihat_stock_barang/presentation/controller/lihat_stock_barang_controller.dart';
import 'package:flutter/material.dart';

class LihatStockBarang extends StatelessWidget {
  const LihatStockBarang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock Barang"),
        centerTitle: true,
        elevation: 4,
        scrolledUnderElevation: 4,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(Icons.add),
        shape: CircleBorder(),
      ),
      bottomNavigationBar: StockBottomNavBar(),
      body: GetBuilder<LihatStockBarangController>(
        builder: (controller) {
          return ApiLoader(
            apiResponse: controller.stockBarangApiResponse,
            onRefresh: controller.refreshStockBarang,
            builder: (List<Barang> listBarang){
              return ListViewBarang(listBarang: listBarang);
            },
          );
        }
      ),
    );
  }
}
