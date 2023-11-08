import 'package:common/presentation/bottom_navbar/submit_card.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/pilih_barang_provider.dart';
import 'package:flutter/material.dart';

class DoneCard extends StatelessWidget {
  final bool Function(BuildContext) popDone;
  const DoneCard({
    super.key,
    required this.popDone,
  });

  @override
  Widget build(BuildContext context) {
    return SubmitCard(
      button: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 28),
          ),
          onPressed: () => popDone(context),
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
