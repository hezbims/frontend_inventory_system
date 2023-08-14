import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/textfield/custom_dropdown_menu.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_lihat_stock_barang/presentation/provider/lihat_stock_barang_provider.dart';
import 'package:flutter/material.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final LihatStockBarangProvider provider = Provider.of(context , listen: false);

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
                  provider.scaffoldKey.currentState?.closeEndDrawer();
                }, icon: const Icon(Icons.close)
              ),

              const SizedBox(height: 45,),

              CustomTextfield(
                controller: provider.namaController,
                label: "Nama Barang",
                errorText: null
              ),

              const VerticalFormSpacing(),

              CustomDropdownMenu(
                label: "Kategori",
                value: provider.kategori,
                values: const ["Semua" , "Sarung Tangan" , "Kaos Kaki"],
                onValueChange: provider.onKategoriChange,
                errorText: null
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