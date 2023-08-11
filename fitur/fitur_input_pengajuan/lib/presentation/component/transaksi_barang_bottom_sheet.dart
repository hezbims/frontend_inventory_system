import 'package:common/domain/model/barang.dart';
import 'package:common/presentation/button/cancel_button.dart';
import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/presentation/component/barang_quantity_incrementer.dart';
import 'package:flutter/material.dart';

class TransaksiBarangBottomSheet extends StatefulWidget {
  final Barang currentBarang;
  const TransaksiBarangBottomSheet({
    super.key,
    required this.currentBarang,
  });

  @override
  State<TransaksiBarangBottomSheet> createState() => _TransaksiBarangBottomSheetState();
}

class _TransaksiBarangBottomSheetState extends State<TransaksiBarangBottomSheet> {
  String? errorMessage;

  int _currentQuantity = 0;
  void onDecrease() {
    if (_currentQuantity > 0) {
      setState(() {
        --_currentQuantity;
      });
    }
  }

  void onIncrease() {
    if (_currentQuantity < widget.currentBarang.stockSekarang) {
      setState(() {
        ++_currentQuantity;
      });
    }
  }

  final _keteranganController = TextEditingController();
  @override
  void dispose(){
    _keteranganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            widget.currentBarang.nama,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24
            ),
          ),
        ),

        const VerticalFormSpacing(),

        BarangQuantityIncrementer(
          onDecrease: onDecrease,
          onIncrease: onIncrease,
          currentQuantity: _currentQuantity,
          errorMessage: errorMessage,
        ),

        const VerticalFormSpacing(),

        CustomTextfield(
          controller: _keteranganController,
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
                  if (_currentQuantity > 0) {
                    Navigator.of(context).pop(
                        BarangTransaksi(
                          barang: widget.currentBarang,
                          quantity: _currentQuantity,
                          keterangan: _keteranganController.text,
                        )
                    );
                  }
                  else {
                    setState(() {
                      errorMessage = "Kuantitas tidak boleh 0!";
                    });
                  }
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
