import 'package:fitur_input_pengajuan/domain/use_case/quantity_validation_use_case.dart';
import 'package:flutter/material.dart';

class QuantityBarangProvider extends ChangeNotifier {
  final quantityController = TextEditingController(text: "0");
  final quantityFocusNode = FocusNode();
  final quantityValidator = QuantityValidtionUseCase();
  int? get currentQuantity => int.tryParse(quantityController.text);

  final keteranganController = TextEditingController();

  String? quantityError;

  QuantityBarangProvider();

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