import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:common/domain/model/kategori.dart';
import 'package:common/presentation/api_loader/api_loader.dart';
import 'package:common/presentation/textfield/custom_dropdown_menu.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_lihat_stock_barang/presentation/provider/kategori_filter_provider.dart';
import 'package:flutter/material.dart';

class KategoriFilterDrawer extends StatelessWidget {
  const KategoriFilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).maxDrawerWidth,
        maxHeight: MediaQuery.of(context).size.height,
      ),
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filter Kategori',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      Scaffold.of(context).closeEndDrawer();
                    }, icon: const Icon(Icons.done_outline_sharp),
                  ),
                ],
              ),

              const SizedBox(height: 45,),

              Consumer<KategoriFilterProvider>(
                builder: (context , provider , child) {
                  return ApiLoader(
                    apiResponse: provider.getKategoriResponse,
                    onRefresh: provider.refresh,
                    builder: (List<Kategori> result){
                      return CustomDropdownMenu(
                        label: 'Kategori',
                        value: provider.choosenKategori,
                        values: provider.constructDropdownItems(result),
                        onValueChange: provider.setChoosenKategori,
                        errorText: null,
                      );
                    }
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}