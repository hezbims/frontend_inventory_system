import 'package:fitur_input_pengajuan/domain/use_case/quantity_validation_use_case.dart';
import 'package:flutter/material.dart';

class QuantityBarangProvider extends ChangeNotifier {
  final int _currentStock;
  final bool _isPemasukan;

  final quantityController = TextEditingController(text: "0");
  final quantityFocusNode = FocusNode();
  final quantityValidator = QuantityValidtionUseCase();
  int? get currentQuantity => int.tryParse(quantityController.text);

  final keteranganController = TextEditingController();

  String? quantityError;

  QuantityBarangProvider({
    required int currentStock,
    required bool isPemasukan,
  }) : _currentStock = currentStock , _isPemasukan = isPemasukan;

  void onIncrease(){
    quantityController.text = (
      (int.parse(quantityController.text)) + 1
    ).toString();
  }

  void onDecrease(){
    quantityController.text = (
        (int.parse(quantityController.text)) - 1
    ).toString();
  }

  bool canSubmit(){
    quantityError = quantityValidator(
      quantityText: quantityController.text,
      isPemasukan: _isPemasukan,
      currentStock: _currentStock,
    );
    notifyListeners();

    if (quantityError == null){
      return true;
    }
    else {
      return false;
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