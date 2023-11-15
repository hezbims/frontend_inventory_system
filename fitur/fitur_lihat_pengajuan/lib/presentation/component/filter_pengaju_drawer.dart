

import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:common/domain/model/pengaju.dart';
import 'package:common/presentation/api_loader/api_loader.dart';
import 'package:common/presentation/textfield/custom_dropdown_menu.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/filter_pengaju/filter_pengaju_drawer_header.dart';
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

                CustomDropdownMenu(
                  label: 'Tipe Pengaju',
                  value: provider.tipePengaju,
                  values: provider.listTipePengaju,
                  onValueChange: (String? newTipePengaju) =>
                    provider.onChangeTipePengaju(newTipePengaju),
                  errorText: null
                ),

                const SizedBox(height: 24,),

                ApiLoader(
                  apiResponse: provider.getListPengajuResponse,
                  onRefresh: provider.refreshListPengaju,
                  builder: (List<Pengaju> listPengaju) =>
                    CustomDropdownMenu<Pengaju>(
                      label: 'Nama ${provider.tipePengaju}',
                      value: null,
                      values: [null , ...listPengaju],
                      onValueChange: (Pengaju? choosenPengaju) =>
                        provider.onChoosePengaju(choosenPengaju),
                      errorText: null
                    ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
