import 'package:common/domain/extension/media_query_data_extension.dart';
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
            maxWidth: MediaQuery.of(context).maxDrawerWidth,
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
