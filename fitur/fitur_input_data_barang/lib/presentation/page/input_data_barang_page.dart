import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:common/domain/model/barang.dart';
import 'package:common/domain/model/kategori.dart';
import 'package:common/presentation/bottom_navbar/submit_card.dart';
import 'package:common/presentation/button/disabled_submit_button.dart';
import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/page/pilih_kategori/pilih_kategori_page.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/disabled_textfield.dart';
import 'package:common/presentation/textfield/dropdown_page_chooser.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_data_barang/domain/model/submit_barang_dto.dart';
import 'package:fitur_input_data_barang/presentation/provider/input_data_barang_provider.dart';
import 'package:flutter/material.dart';

class InputDataBarangPage extends StatelessWidget {
  final Barang? initialBarang;
  const InputDataBarangPage({
    super.key,
    required this.initialBarang,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GetIt.I.get<InputDataBarangProvider>(
        param1: initialBarang,
      ),
      child: Consumer<InputDataBarangProvider>(
        builder: (context , provider , child){
          if (provider.submitResponse is ApiResponseSuccess){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop(true);
            });
          }
          return Scaffold(
              appBar: AppBar(
                forceMaterialTransparency: true,
                scrolledUnderElevation: 0,
                title: Text("${!provider.isEditing ? "Tambah" : "Edit"} Data Barang"),
                centerTitle: true,
                leading: BackButton(
                  onPressed: (){
                    Navigator.of(context).pop(true);
                  },
                ),
              ),
              bottomNavigationBar: Builder(
                builder: (context) {
                  late Widget button;

                  // kareana initial datanya gak ada berarti tambah barang
                  if (!provider.isEditing){
                    button = SubmitButton(onTap: provider.submit);
                  }
                  // kalo lagi ngedit, gunain button yang disabled
                  else {
                    button = const DisabledSubmitButton();
                  }

                  return SubmitCard(button: button);
                }
              ),
              body : Builder(
                builder: (context) {
                  return ListView(
                    padding: EdgeInsets.symmetric(
                      vertical: 36,
                      horizontal: MediaQuery.of(context).phoneLandscapePadding,
                    ),
                    children: [
                      CustomTextfield(
                        controller: provider.namaController,
                        label: "Nama",
                        errorText: provider.errorMessage[SubmitBarangDto.kolomNama],
                      ),

                      const VerticalFormSpacing(),

                      DropdownPageChooser(
                          label: "Kategori",
                          value: provider.kategori?.nama,
                          errorMessage: provider.errorMessage[SubmitBarangDto.kolomIdKategori],
                          onTap: () async {
                            final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                  const PilihKategoriPage()
                              ),
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
                                errorText: provider.errorMessage[SubmitBarangDto.kolomNomorRak]
                            ),
                          ),

                          const SizedBox(width: 12,),

                          Expanded(
                            child: CustomTextfield(
                                controller: provider.nomorLaciController,
                                label: "Nomor Laci",
                                errorText: provider.errorMessage[SubmitBarangDto.kolomNomorLaci]
                            ),
                          ),

                          const SizedBox(width: 12,),

                          Expanded(
                            child: CustomTextfield(
                                controller: provider.nomorKolomController,
                                label: "Nomor Kolom",
                                errorText: provider.errorMessage[SubmitBarangDto.kolomNomorKolom]
                            ),
                          ),
                        ],
                      ),

                      const VerticalFormSpacing(),

                      CustomTextfield(
                        controller: provider.minStockController,
                        label: "Min. Stock",
                        errorText: provider.errorMessage[SubmitBarangDto.kolomMinStock],
                        inputType: TextInputType.number,
                      ),

                      const VerticalFormSpacing(),

                      CustomTextfield(
                        controller: provider.lastMonthStockController,
                        label: "Last Month Stock",
                        errorText: provider.errorMessage[SubmitBarangDto.kolomLastMonthStock],
                        inputType: TextInputType.number,
                      ),

                      const VerticalFormSpacing(),

                      CustomTextfield(
                        controller: provider.stockSekarangController,
                        label: "Stock Sekarang",
                        errorText: provider.errorMessage[SubmitBarangDto.kolomStockSekarang],
                        inputType: TextInputType.number,
                        onChanged: provider.updateAmount,
                      ),

                      const VerticalFormSpacing(),

                      CustomTextfield(
                        controller: provider.unitPriceController,
                        label: "Unit Price",
                        errorText: provider.errorMessage[SubmitBarangDto.kolomUnitPrice],
                        inputType: TextInputType.number,
                        onChanged: provider.updateAmount,
                      ),

                      const VerticalFormSpacing(),

                      DisabledTextField(
                        label: "Amount",
                        value: provider.amount,
                        errorMessage: null,
                      ),

                      const VerticalFormSpacing(),

                      CustomTextfield(
                        controller: provider.uomController,
                        label: "UOM",
                        errorText: provider.errorMessage[SubmitBarangDto.kolomUom],
                      ),
                    ],
                  );
                }
              )
          );
        },
      ),
    );
  }
}
