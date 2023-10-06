import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:common/domain/model/kategori.dart';
import 'package:common/presentation/api_loader/api_loader.dart';
import 'package:common/presentation/button/tambah_sesuatu_button.dart';
import 'package:common/presentation/dependency_setup/buat_kategori_dialog_dependency_setup.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:common/presentation/card/kategori_card.dart';
import 'package:common/presentation/page/pilih_kategori/pilih_kategori_provider.dart';
import 'package:common/presentation/textfield/search_app_bar.dart';
import 'package:flutter/material.dart';

class PilihKategoriPage extends StatelessWidget {
  const PilihKategoriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GetIt.I.get<PilihKategoriProvider>(),
      child: Consumer<PilihKategoriProvider>(
        builder: (context , provider , child){
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              provider.tryRequestFocus();
            }
          );
          return Scaffold(
            appBar: SearchAppBar(
              controller: provider.searchController,
              focusNode: provider.searchFocusNode,
              placeholder: "Cari kategori",
            ),
            body: ApiLoader<List<Kategori>>(
                apiResponse: provider.getFilteredKategori(),
                onRefresh: provider.onRefreshKategori,
                builder: (listKategori) {
                  final horizontalPaddingSize = MediaQuery.of(context).phoneLandscapePadding;
                  return Stack(
                    children: [
                      ListView.separated(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPaddingSize,
                            vertical: 48,
                          ),
                          itemBuilder: (context , index){
                            final kategori = listKategori[index];
                            return KategoriCard(
                              kategori: kategori,
                              onTap: (){
                                Navigator.of(context).pop(kategori);
                              },
                            );
                          },
                          separatorBuilder: (context , index){
                            return const SizedBox(height: 10,);
                          },
                          itemCount: listKategori.length
                      ),

                      Positioned(
                        top: 16,
                        right: horizontalPaddingSize,
                        child: TambahSesuatuButton(
                            label: "Tambah kategori baru",
                            onTap: () async {
                              final result = await showDialog(
                                  context: context,
                                  builder: (context){
                                    return BuatKategoriDialogDependencySetup();
                                  }
                              );

                              if (result != null){
                                provider.onRefreshKategori();
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
