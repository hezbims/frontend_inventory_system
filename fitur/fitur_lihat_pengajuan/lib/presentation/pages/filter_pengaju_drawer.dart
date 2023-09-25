import 'dart:math';

import 'package:dependencies/provider.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/filter_pengaju/choosen_pengaju_field.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/filter_pengaju/filter_pengaju_drawer_header.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/filter_pengaju/list_pengaju_tersedia.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/filter_pengaju/pilih_tipe_field.dart';
import 'package:fitur_lihat_pengajuan/presentation/provider/filter_pengaju_provider.dart';
import 'package:flutter/material.dart';

class FilterPengajuDrawer extends StatelessWidget {
  const FilterPengajuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterPengajuProvider>(
      builder: (context , provider , child) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: min(288 , MediaQuery.of(context).size.width * 4 / 5),
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Drawer(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const FilterPengajuDrawerHeader(),

                const SizedBox(height: 24,),

                const PilihTipeField(),

                const SizedBox(height: 24,),

                ChoosenPengajuField(
                  tipePengaju: provider.tipePengaju,
                  choosenPengaju: provider.pengajuDipilih,
                  onDeletePengaju: provider.onDeletePengajuDipilih,
                ),

                const SizedBox(height: 24,),
                
                ListPengajuTersedia(
                  getListPengajuResponse: provider.getListPengajuResponse,
                  refreshListPengaju: provider.refreshListPengaju,
                  tipePengaju: provider.tipePengaju,
                  onChoosePengaju: provider.onChoosePengaju,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
