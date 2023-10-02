import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:common/presentation/api_loader/api_loader.dart';
import 'package:dependencies/provider.dart';
import 'package:common/presentation/textfield/search_app_bar.dart';
import 'package:common/presentation/button/tambah_sesuatu_button.dart';
import 'package:common/data/repository/pengaju_repository_impl.dart';
import 'package:common/domain/model/pengaju.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_pengaju/pengaju_card.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_pengaju/show_buat_pengaju_dialog.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_pengaju/pilih_pengaju_provider.dart';
import 'package:flutter/material.dart';

class PilihPengajuPage extends StatelessWidget {
  const PilihPengajuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isPemasok = ModalRoute.of(context)?.settings.arguments as bool;

    return ChangeNotifierProvider(
      create: (context) => PilihPengajuProvider(
        repository: PengajuRepositoryImpl(),
        isPemasok: isPemasok,
      ),
      child: Consumer<PilihPengajuProvider>(
        builder: (context , provider , child){
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
                provider.requestFocus();
            }
          );
          return Scaffold(
            appBar: SearchAppBar(
              controller: provider.searchController,
              focusNode: provider.searchFocusNode,
              placeholder: "Cari nama ${isPemasok ? 'pemasok' : 'group'}",
            ),
            body: ApiLoader<List<Pengaju>>(
                apiResponse: provider.filteredGroupResponse,
                onRefresh: provider.refresh,
                builder: (listGroup) {
                  return Stack(
                    children: [
                      ListView.separated(
                        padding: EdgeInsets.symmetric(
                          vertical: 48,
                          horizontal: MediaQuery.of(context).maxHorizontalPadding
                        ),
                        itemBuilder: (context , index){
                          return PengajuCard(
                            group: listGroup[index],
                          );
                        },
                        separatorBuilder: (context , index){
                          return const SizedBox(height: 10,);
                        },
                        itemCount: listGroup.length
                      ),

                      Positioned(
                        top: 16,
                        right: 24 + MediaQuery.of(context).maxHorizontalPadding,
                        child: TambahSesuatuButton(
                            label: "Tambah ${isPemasok ? 'pemasok' : 'group'} baru",
                            onTap: () async {
                              final result = await showBuatPengajuDialog(
                                context: context,
                                isPemasok: isPemasok,
                              );

                              if (result != null){
                                provider.refresh();
                              }
                            }
                        ),
                      ),
                    ],
                  );
                }
            ),
          );
        },
      ),
    );
  }
}
