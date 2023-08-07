import 'package:common/presentation/bottom_navbar/submit_card.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/disabled_textfield.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_data_barang/presentation/controller/input_data_barang_provider.dart';
import 'package:flutter/material.dart';

class InputDataBarangPage extends StatelessWidget {
  const InputDataBarangPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InputDataBarangProvider(),
      child: Consumer<InputDataBarangProvider>(
        builder: (context , provider , child){
          return Scaffold(
              appBar: AppBar(
                scrolledUnderElevation: 0,
                title: const Text("Input Data Barang"),
                centerTitle: true,
                leading: BackButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ),
              bottomNavigationBar: SubmitCard(
                onTap: () {

                },
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
                    errorMessage: provider.namaError,
                  ),

                  const VerticalFormSpacing(),

                  CustomTextfield(
                      controller: provider.categoryController,
                      label: "Kategori",
                      errorMessage: provider.categoryError
                  ),

                  const VerticalFormSpacing(),

                  CustomTextfield(
                      controller: provider.nomorRakController,
                      label: "Nomor Rak",
                      errorMessage: provider.nomorRakError
                  ),

                  const VerticalFormSpacing(),

                  CustomTextfield(
                      controller: provider.lastMonthStockController,
                      label: "Last Month Stock",
                      errorMessage: provider.lastMonthStockError
                  ),

                  const VerticalFormSpacing(),

                  CustomTextfield(
                      controller: provider.stockSekarangController,
                      label: "Stock Sekarang",
                      errorMessage: provider.stockSekarangError
                  ),

                  const VerticalFormSpacing(),

                  CustomTextfield(
                    controller: provider.unitPriceController,
                    label: "Unit Price",
                    errorMessage: provider.unitPriceError,
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
