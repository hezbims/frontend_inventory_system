import 'package:common/presentation/bottom_navbar/submit_card.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/disabled_textfield.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:dependencies/get.dart';
import 'package:fitur_input_data_barang/presentation/controller/input_data_barang_controller.dart';
import 'package:flutter/material.dart';

class InputDataBarangPage extends StatelessWidget {
  const InputDataBarangPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
      body: GetBuilder<InputDataBarangController>(
        builder: (controller) {
          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 36
            ),
            children: [
              CustomTextfield(
                controller: controller.namaController,
                label: "Nama",
                errorMessage: controller.namaError,
              ),

              const VerticalFormSpacing(),

              CustomTextfield(
                controller: controller.categoryController,
                label: "Kategori",
                errorMessage: controller.categoryError
              ),

              const VerticalFormSpacing(),

              CustomTextfield(
                controller: controller.nomorRakController,
                label: "Nomor Rak",
                errorMessage: controller.nomorRakError
              ),

              const VerticalFormSpacing(),

              CustomTextfield(
                controller: controller.lastMonthStockController,
                label: "Last Month Stock",
                errorMessage: controller.lastMonthStockError
              ),

              const VerticalFormSpacing(),

              CustomTextfield(
                  controller: controller.stockSekarangController,
                  label: "Stock Sekarang",
                  errorMessage: controller.stockSekarangError
              ),

              const VerticalFormSpacing(),

              CustomTextfield(
                controller: controller.unitPriceController,
                label: "Unit Price",
                errorMessage: controller.unitPriceError,
              ),

              const VerticalFormSpacing(),

              DisabledTextField(
                label: "Amount",
                value: controller.amount,
                errorMessage: null,
              ),
            ],
          );
        }
      )
    );
  }
}
