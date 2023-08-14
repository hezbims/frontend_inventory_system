import 'package:common/domain/model/barang.dart';
import 'package:common/presentation/button/cancel_button.dart';
import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_barang/barang_quantity_incrementer.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/quantity_barang_provider.dart';
import 'package:flutter/material.dart';

class TransaksiBarangBottomSheet extends StatelessWidget {
  final Barang currentBarang;

  const TransaksiBarangBottomSheet({
    required this.currentBarang,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuantityBarangProvider(),
      child: Consumer<QuantityBarangProvider>(
        builder: (context , provider , child) {
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  currentBarang.nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                  ),
                ),
              ),

              const VerticalFormSpacing(),

              BarangQuantityIncrementer(
                onDecrease: provider.onDecrease,
                onIncrease: provider.onIncrease,
                controller: provider.quantityController,
                errorMessage: provider.quantityError,
                focusNode: provider.quantityFocusNode,
                onSubmit: (_){
                  submitData(context: context, provider: provider);
                },
              ),

              const VerticalFormSpacing(),

              CustomTextfield(
                controller: provider.keteranganController,
                label: "Keterangan",
                errorText: null,
                minLines: 3,
              ),

              const VerticalFormSpacing(),

              Row(
                children: [
                  Expanded(
                    child: CancelButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ),

                  const HorizontalFormSpacing(),

                  Expanded(
                    child: SubmitButton(
                      onTap: (){
                        submitData(context: context, provider: provider);
                      }
                    ),
                  ),
                ],
              )
            ],
          );
        }
      ),
    );
  }

  void submitData({
    required BuildContext context,
    required QuantityBarangProvider provider,
  }){
    if (provider.canSubmit()) {
      Navigator.of(context).pop(
          BarangTransaksi(
            barang: currentBarang,
            quantity: provider.currentQuantity!,
            keterangan: provider.keteranganController.text,
          )
      );
    }
  }
}
