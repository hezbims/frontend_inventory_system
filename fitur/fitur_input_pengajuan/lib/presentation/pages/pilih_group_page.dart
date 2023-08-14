import 'package:common/presentation/api_loader/api_loader.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/data/repository/fake_group_repository.dart';
import 'package:common/domain/model/group.dart';
import 'package:fitur_input_pengajuan/presentation/component/common/search_app_bar.dart';
import 'package:fitur_input_pengajuan/presentation/component/common/tambah_sesuatu_button.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_group/group_card.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_group/show_buat_group_dialog.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_group_provider.dart';
import 'package:flutter/material.dart';

class PilihGroupPage extends StatelessWidget {
  const PilihGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PilihGroupProvider(
        repository: FakeGroupRepository()
      ),
      child: Consumer<PilihGroupProvider>(
        builder: (context , provider , child){
          return Scaffold(
            appBar: SearchAppBar(
              controller: provider.searchController,
              placeholder: "Cari group",
            ),
            body: ApiLoader<List<Group>>(
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
