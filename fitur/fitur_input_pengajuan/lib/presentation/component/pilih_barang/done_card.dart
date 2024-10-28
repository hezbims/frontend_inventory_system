import 'package:common/presentation/bottom_navbar/submit_card.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/pilih_barang_provider.dart';
import 'package:flutter/material.dart';

class DoneCard extends StatelessWidget {
  const DoneCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SubmitCard(
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 28),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: Selector<PilihBarangProvider , int>(
            selector: (context , provider) => provider.choosenBarang.length,
            builder: (context , totalChoosenItem , child) {
              return Text('Done ($totalChoosenItem)',);
            }
          )
      ),
    );
  }
}
