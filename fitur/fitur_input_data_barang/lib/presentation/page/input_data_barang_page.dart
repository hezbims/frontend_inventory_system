import 'package:common/domain/model/barang.dart';
import 'package:common/domain/model/kategori.dart';
import 'package:common/presentation/bottom_navbar/submit_card.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/disabled_textfield.dart';
import 'package:common/presentation/textfield/dropdown_page_chooser.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:common/response/api_response.dart';
import 'package:common/routes/routes.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_data_barang/presentation/provider/input_data_barang_provider.dart';
import 'package:flutter/material.dart';

class InputDataBarangPage extends StatelessWidget {
  const InputDataBarangPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Barang? initialData;
    try {
      initialData = ModalRoute.of(context)?.settings.arguments as Barang;
    } catch (_) { }

    return ChangeNotifierProvider(
      create: (context) => InputDataBarangProvider(
        initialData: initialData,
      ),
      child: Consumer<InputDataBarangProvider>(
        builder: (context , provider , child){
          if (provider.submitResponse is ApiResponseSuccess){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
          }
          return Scaffold(
              appBar: AppBar(
                scrolledUnderElevation: 0,
                title: Text("${initialData == null ? "Tambah" : "Edit"} Data Barang"),
                centerTitle: true,
                leading: BackButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ),
              bottomNavigationBar: SubmitCard(
                onTap: provider.submit,
              ),
              body : ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 36
                ),
                children: [
                  CustomTextfield(
                    controller: provider.namaController,
                    label: "Nama",
                    errorText: provider.namaError,
                  ),

                  const VerticalFormSpacing(),

                  DropdownPageChooser(
                    label: "Kategori",
                    value: provider.kategori?.nama,
                    errorMessage: provider.kategoriError,
                    onTap: () async {
                      final result = await Navigator.of(context).pushNamed(
                        Routes.fiturPilihKategoriRoute
                      );

                      if (result is Kategori){
                        provider.onKategoriChange(result);
                      }
                    }
                  ),

                  const VerticalFormSpacing(),

                  Row(
                    children: [
                      Expanded(
                        child: CustomTextfield(
                            controller: provider.nomorRakController,
                            label: "Nomor Rak",
                            errorText: null
                        ),
                      ),

                      const SizedBox(width: 12,),

                      Expanded(
                        child: CustomTextfield(
                            controller: provider.nomorLaciController,
                            label: "Nomor Laci",
                            errorText: null
                        ),
                      ),

                      const SizedBox(width: 12,),

                      Expanded(
                        child: CustomTextfield(
                            controller: provider.nomorKolomController,
                            label: "Nomor Kolom",
                            errorText: null
                        ),
                      ),
                    ],
                  ),

                  const VerticalFormSpacing(),

                  CustomTextfield(
                    controller: provider.lastMonthStockController,
                    label: "Last Month Stock",
                    errorText: provider.lastMonthStockError,
                    inputType: TextInputType.number,
                  ),

                  const VerticalFormSpacing(),

                  CustomTextfield(
                    controller: provider.stockSekarangController,
                    label: "Stock Sekarang",
                    errorText: provider.stockSekarangError,
                    inputType: TextInputType.number,
                    onChanged: provider.updateAmount,
                  ),

                  const VerticalFormSpacing(),

                  CustomTextfield(
                    controller: provider.unitPriceController,
                    label: "Unit Price",
                    errorText: provider.unitPriceError,
                    inputType: TextInputType.number,
                    onChanged: provider.updateAmount,
                  ),

                  const VerticalFormSpacing(),

                  DisabledTextField(
                    label: "Amount",
                    value: provider.amount,
                    errorMessage: null,
                  ),
                ],
              )
          );
        },
      ),
    );
  }
}
