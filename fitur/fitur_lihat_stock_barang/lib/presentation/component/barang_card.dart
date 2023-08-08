import 'package:common/domain/model/barang.dart';
import 'package:common/routes/routes.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(barang.nama),
                Text("Total : ${barang.stockSekarang}"),
              ],
            ),
            if (barang.id != null)
              Text(barang.id!),

            const SizedBox(height: 24,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Text("Kategori :\n${barang.category}")
                ),
                const SizedBox(width: 4,),
                Expanded(
                  flex: 2,
                  child: Text("Rak :\n${barang.nomorRak}")
                ),
                const SizedBox(width: 4,),
                Expanded(
                  flex: 2,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        Routes.fiturInputDataBarangRoute,
                        arguments: barang,
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
