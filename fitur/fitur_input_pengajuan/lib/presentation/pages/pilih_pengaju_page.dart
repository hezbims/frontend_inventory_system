import 'package:common/presentation/api_loader/api_loader.dart';
import 'package:dependencies/provider.dart';
import 'package:common/presentation/textfield/search_app_bar.dart';
import 'package:common/presentation/button/tambah_sesuatu_button.dart';
import 'package:fitur_input_pengajuan/data/repository/pengaju_repository_impl.dart';
import 'package:fitur_input_pengajuan/domain/model/pengaju.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_group/group_card.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_group/show_buat_group_dialog.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_group/pilih_group_provider.dart';
import 'package:flutter/material.dart';

class PilihPengajuPage extends StatelessWidget {
  const PilihPengajuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isPemasok = ModalRoute.of(context)?.settings.arguments as int;

    return ChangeNotifierProvider(
      create: (context) => PilihGroupProvider(
        repository: PengajuRepositoryImpl(),
        isPemasok: isPemasok,
      ),
      child: Consumer<PilihGroupProvider>(
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
              placeholder: "Cari group",
            ),
            body: ApiLoader<List<Pengaju>>(
                apiResponse: provider.filteredGroupResponse,
                onRefresh: provider.onRefreshGroup,
                builder: (listGroup) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          right: 24,
                        ),
                        child: TambahSesuatuButton(
                            label: "Tambah group baru",
                            onTap: (){
                              showBuatGroupDialog(context);
                            }
                        ),
                      ),

                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(24),
                          itemBuilder: (context , index){
                            return GroupCard(
                              group: listGroup[index],
                            );
                          },
                          separatorBuilder: (context , index){
                            return const SizedBox(height: 10,);
                          },
                          itemCount: listGroup.length
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
