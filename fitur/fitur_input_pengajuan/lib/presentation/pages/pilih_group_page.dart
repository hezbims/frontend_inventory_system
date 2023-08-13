import 'package:common/presentation/api_loader/api_loader.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/data/repository/fake_group_repository.dart';
import 'package:common/domain/model/group.dart';
import 'package:fitur_input_pengajuan/presentation/component/common/search_app_bar.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_group/group_card.dart';
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
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        vertical: 36,
                        horizontal: 24
                    ),
                    itemBuilder: (context , index){
                      return GroupCard(
                        group: listGroup[index],
                      );
                    },
                    separatorBuilder: (context , index){
                      return const SizedBox(height: 10,);
                    },
                    itemCount: listGroup.length
                  );
                }
            ),
          );
        },
      ),
    );
  }
}
