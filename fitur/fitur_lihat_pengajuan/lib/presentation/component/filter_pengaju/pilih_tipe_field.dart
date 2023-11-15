import 'package:dependencies/provider.dart';
import 'package:fitur_lihat_pengajuan/presentation/provider/filter_pengaju_provider.dart';
import 'package:flutter/material.dart';

class PilihTipeField extends StatelessWidget {
  const PilihTipeField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FilterPengajuProvider>(context , listen: false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tipe'
        ),
        DropdownButtonFormField<String>(
          value: provider.tipePengaju,
          items: provider.listTipePengaju.map(
            (tipePengaju) =>
              DropdownMenuItem(
                value: tipePengaju,
                child: Text(
                  tipePengaju,
                  style: const TextStyle(
                    fontSize: 11,
                  ),
                ),
              ),
          ).toList(),
          onChanged: provider.onChangeTipePengaju,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 22,
            ),
          ),
        ),
      ],
    );
  }
}
