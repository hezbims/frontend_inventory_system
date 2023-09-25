import 'package:common/presentation/button/cancel_button.dart';
import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:dependencies/fluttertoast.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_barang/barang_quantity_incrementer.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/bottom_sheet_barang_provider.dart';
import 'package:flutter/material.dart';

class TransaksiBarangBottomSheet extends StatelessWidget {
  final BarangTransaksi _initialBarangTransaksi;

  const TransaksiBarangBottomSheet({
    required BarangTransaksi initialBarangTransaksi,
    super.key,
  }) : _initialBarangTransaksi = initialBarangTransaksi;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GetIt.I.get<BottomSheetBarangProvider>(),
      child: Consumer<BottomSheetBarangProvider>(
        builder: (context , provider , child) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => provider.tryRequestFocus(),
          );
          void trySubmit(){
            if (provider.canSubmit()){
              Fluttertoast.showToast(
                msg: "Berhasil meng${_initialBarangTransaksi.id == null ? 'ambil' : 'edit'} ${_initialBarangTransaksi.namaBarang} "
                    "sebanyak (${provider.currentQuantity!})",
                timeInSecForIosWeb: 3
              );

              Navigator.of(context).pop(
                  BarangTransaksi(
                    id: _initialBarangTransaksi.id,
                    idBarang: _initialBarangTransaksi.idBarang,
                    namaBarang: _initialBarangTransaksi.namaBarang,
                    quantity: provider.currentQuantity!,
                    keterangan: provider.keteranganController.text,
                  )
              );
            }
          }

          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  _initialBarangTransaksi.namaBarang,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                  ),
                ),
              ),

              const VerticalFormSpacing(),

              BarangQuantityIncrementer(
                controller: provider.quantityController,
                errorMessage: provider.quantityError,
                focusNode: provider.quantityFocusNode,
                onSubmit: (_) => trySubmit(),
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
                      onTap: trySubmit
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
}
