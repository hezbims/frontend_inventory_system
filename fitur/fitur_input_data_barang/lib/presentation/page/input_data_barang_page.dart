import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:common/domain/model/barang.dart';
import 'package:common/domain/model/kategori.dart';
import 'package:common/presentation/bottom_navbar/submit_card.dart';
import 'package:common/presentation/button/disabled_submit_button.dart';
import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/disabled_textfield.dart';
import 'package:common/presentation/textfield/dropdown_page_chooser.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:common/response/api_response.dart';
import 'package:common/constant/routes/routes.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_data_barang/data/repository/submit_barang_repository_impl.dart';
import 'package:fitur_input_data_barang/domain/model/submit_barang_dto.dart';
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
        repository: SubmitBarangRepositoryImpl(),
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
                title: Text("${initialData == null ? "Tambah" : "Edit"} Data Barang"),
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
                  if (initialData == null){
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
                  final listViewItem = [
                    CustomTextfield(
                      controller: provider.namaController,
                      label: "Nama",
                      errorText: provider.errorMessage[SubmitBarangDto.kolomNama],
                    ),

                    DropdownPageChooser(
                        label: "Kategori",
                        value: provider.kategori?.nama,
                        errorMessage: provider.errorMessage[SubmitBarangDto.kolomIdKategori],
                        onTap: () async {
                          final result = await Navigator.of(context).pushNamed(
                              Routes.fiturPilihKategoriRoute
                          );

                          if (result is Kategori){
                            provider.onKategoriChange(result);
                          }
                        }
                    ),

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

                    CustomTextfield(
                      controller: provider.minStockController,
                      label: "Min. Stock",
                      errorText: provider.errorMessage[SubmitBarangDto.kolomMinStock],
                      inputType: TextInputType.number,
                    ),

                    CustomTextfield(
                      controller: provider.lastMonthStockController,
                      label: "Last Month Stock",
                      errorText: provider.errorMessage[SubmitBarangDto.kolomLastMonthStock],
                      inputType: TextInputType.number,
                    ),

                    CustomTextfield(
                      controller: provider.stockSekarangController,
                      label: "Stock Sekarang",
                      errorText: provider.errorMessage[SubmitBarangDto.kolomStockSekarang],
                      inputType: TextInputType.number,
                      onChanged: provider.updateAmount,
                    ),

                    CustomTextfield(
                      controller: provider.unitPriceController,
                      label: "Unit Price",
                      errorText: provider.errorMessage[SubmitBarangDto.kolomUnitPrice],
                      inputType: TextInputType.number,
                      onChanged: provider.updateAmount,
                    ),

                    DisabledTextField(
                      label: "Amount",
                      value: provider.amount,
                      errorMessage: null,
                    ),

                    CustomTextfield(
                      controller: provider.uomController,
                      label: "UOM",
                      errorText: provider.errorMessage[SubmitBarangDto.kolomUom],
                    ),
                  ];

                  return ListView.separated(
                    padding: EdgeInsets.symmetric(
                      vertical: 36,
                      horizontal: MediaQuery.of(context).maxHorizontalPadding,
                    ),
                    itemBuilder: (context, index){
                      return listViewItem[index];
                    },
                    separatorBuilder: (context, index){
                      return const VerticalFormSpacing();
                    },
                    itemCount: listViewItem.length,
                  );
                }
              )
          );
        },
      ),
    );
  }
}
