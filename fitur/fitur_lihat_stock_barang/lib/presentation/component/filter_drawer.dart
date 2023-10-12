import 'package:common/domain/model/kategori.dart';
import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/page/pilih_kategori/pilih_kategori_page.dart';
import 'package:common/presentation/textfield/custom_dropdown_menu.dart';
import 'package:common/presentation/textfield/dropdown_page_chooser.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_lihat_stock_barang/presentation/provider/lihat_stock_barang_provider.dart';
import 'package:flutter/material.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final LihatStockBarangProvider provider = Provider.of(context , listen: true);

    final drawerWidth = MediaQuery.of(context).size.width * 3 / 4;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: drawerWidth
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: (){
                  Scaffold.of(context).closeEndDrawer();
                }, icon: const Icon(Icons.close)
              ),

              const SizedBox(height: 45,),

              DropdownPageChooser(
                label: "Kategori",
                value: provider.kategori?.nama ?? "",
                errorMessage: null,
                onTap: () async {
                  final result = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PilihKategoriPage()
                    ),
                  );

                  if (result is Kategori){
                    provider.onKategoriChange(result);
                  }
                }
              ),

              const VerticalFormSpacing(),

              CustomDropdownMenu(
                label: "Nomor Rak",
                value: provider.nomorRak,
                values: const ["Semua" , "R1" , "R2" , "R3" , "R4"],
                onValueChange: provider.onNomorRakChange,
                errorText: null
              ),

              const VerticalFormSpacing(),

              SubmitButton(
                onTap: (){},
                label: "Terapkan",
              ),

            ],
          ),
        ),
      ),
    );
  }
}