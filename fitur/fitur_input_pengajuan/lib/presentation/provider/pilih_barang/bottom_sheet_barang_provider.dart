import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/domain/use_case/quantity_validation_use_case.dart';
import 'package:flutter/material.dart';

class BottomSheetBarangProvider extends ChangeNotifier {
  BottomSheetBarangProvider({
    required BarangTransaksi initialBarangTransaksi,
  }) :
    quantityController = TextEditingController(text: initialBarangTransaksi.quantity.toString()),
    keteranganController = TextEditingController(text: initialBarangTransaksi.keterangan);

  final TextEditingController quantityController;
  final TextEditingController keteranganController;

  final quantityFocusNode = FocusNode();
  final quantityValidator = QuantityValidtionUseCase();
  int? get currentQuantity => int.tryParse(quantityController.text);

  String? quantityError;

  bool canSubmit(){
    quantityError = quantityValidator(
      quantityText: quantityController.text,
    );
    notifyListeners();

    if (quantityError == null){
      return true;
    }
    else {
      return false;
    }
  }

  bool _isFirstTimeFocused = true;
  void tryRequestFocus(){
    if (_isFirstTimeFocused){
      _isFirstTimeFocused = false;
      quantityFocusNode.requestFocus();
    }
  }

  @override
  void dispose(){
    quantityController.dispose();
    keteranganController.dispose();
    quantityFocusNode.dispose();
    super.dispose();
  }
}