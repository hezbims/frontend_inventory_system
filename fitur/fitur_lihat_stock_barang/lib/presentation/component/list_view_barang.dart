import 'package:common/domain/model/barang.dart';
import 'package:fitur_lihat_stock_barang/presentation/component/barang_card.dart';
import 'package:flutter/material.dart';

class ListViewBarang extends StatelessWidget {
  final List<Barang> listBarang;
  const ListViewBarang({
    required this.listBarang,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24 , vertical: 36),
      itemBuilder: (context , index){
        return BarangCard(barang: listBarang[index]);
      },
      separatorBuilder: (context , index){
        return const SizedBox(height: 24,);
      },
      itemCount: listBarang.length,
    );
  }
}
