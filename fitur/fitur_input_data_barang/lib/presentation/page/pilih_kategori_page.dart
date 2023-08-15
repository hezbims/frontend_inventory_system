import 'package:common/domain/model/kategori.dart';
import 'package:common/presentation/api_loader/api_loader.dart';
import 'package:common/presentation/button/tambah_sesuatu_button.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_data_barang/data/repository/fake_kategori_repository.dart';
import 'package:fitur_input_data_barang/presentation/component/kategori_card.dart';
import 'package:fitur_input_data_barang/presentation/provider/kategori_provider.dart';
import 'package:common/presentation/textfield/search_app_bar.dart';
import 'package:flutter/material.dart';

class PilihKategoriPage extends StatelessWidget {
  const PilihKategoriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => KategoriProvider(
          repository: FakeKategoriRepository()
      ),
      child: Consumer<KategoriProvider>(
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
              placeholder: "Cari kategori",
            ),
            body: ApiLoader<List<Kategori>>(
                apiResponse: provider.getFilteredKategori(),
                onRefresh: provider.onRefreshKategori,
                builder: (listKategori) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          right: 24,
                        ),
                        child: TambahSesuatuButton(
                            label: "Tambah kategori baru",
                            onTap: (){

                            }
                        ),
                      ),

                      Expanded(
                        child: ListView.separated(
                            padding: const EdgeInsets.all(24),
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
