import 'package:common/constant/themes/custom_color.dart';
import 'package:common/constant/themes/custom_text_style.dart';
import 'package:common/domain/model/barang.dart';
import 'package:common/constant/routes/routes_path.dart';
import 'package:flutter/material.dart';

class BarangCard extends StatelessWidget {
  final Barang barang;
  const BarangCard({
    required this.barang,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getColorByCurrentStockAndMinStock(
          minStock: barang.minStock,
          currentStock: barang.stockSekarang,
        ),
        boxShadow: const [
          BoxShadow(
            offset: Offset(4 , 4),
            blurRadius: 15,
            spreadRadius: -3,
            color: Color(0x1a000000),
          )
        ],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 0.2),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            barang.nama ,
            style: CustomTextStyle.headerStyle,
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text("Kode : ${barang.kodeBarang}"),),

              const SizedBox(width: 4,),

              Text("Current stock : ${barang.stockSekarang}"),
            ],
          ),

          // Text(barang.id.toString()),

          const SizedBox(height: 24,),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Text("Kategori :\n${barang.kategori.nama}")
              ),
              const SizedBox(width: 4,),
              Expanded(
                flex: 2,
                child: Text(
                  "Rak :\n"
                  "R${barang.nomorRak}-"
                  "${barang.nomorLaci}-"
                  "${barang.nomorKolom}"
                )
              ),
              const SizedBox(width: 4,),
              Expanded(
                flex: 2,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      RoutesPath.inputDataBarangPath(barang.id),
                    );
                  },
                  child: const Text("Edit")
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Color getColorByCurrentStockAndMinStock({
    required int minStock,
    required int currentStock,
  }){
    if (currentStock <= 0){ return CustomColor.dangerLight; }
    if (currentStock < minStock){ return CustomColor.warningLight; }
    return CustomColor.normalGreyLight;
  }
}
