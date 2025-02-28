import 'package:common/domain/model/barang.dart';
import 'package:fitur_lihat_stock_barang/domain/model/preview_barang.dart';

extension PreviewBarangMapper on Barang {
  PreviewBarang toPreviewBarang(){
    final BarangStockStatus status;
    if (stockSekarang <= 0) {
      status = BarangStockStatus.runOut;
    }
    else if (stockSekarang <= minStock){
      status = BarangStockStatus.shortage;
    }
    else {
      status = BarangStockStatus.ok;
    }

    return PreviewBarang(
      id: id,
      name: nama,
      location: "R$nomorRak-$nomorLaci-$nomorKolom",
      quantity: "$stockSekarang $uom",
      status: status,
    );
  }
}