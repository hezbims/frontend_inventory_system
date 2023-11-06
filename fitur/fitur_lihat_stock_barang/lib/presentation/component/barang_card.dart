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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Kode : ${barang.kodeBarang}"),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text(barang.nama)),

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
      ),
    );
  }
}
