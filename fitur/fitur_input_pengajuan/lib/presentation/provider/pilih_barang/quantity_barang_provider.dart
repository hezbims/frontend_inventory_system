import 'package:common/domain/use_cases/int_validation_use_case.dart';
import 'package:flutter/material.dart';

class QuantityBarangProvider extends ChangeNotifier {
  final int _maxQuantity;

  final quantityController = TextEditingController(text: "0");
  int? get currentQuantity => int.tryParse(quantityController.text);
  final keteranganController = TextEditingController();
  final quantityFocusNode = FocusNode();
  final intValidator = IntValidationUseCase();

  String? quantityError;

  QuantityBarangProvider({required int maxQuantity}) :_maxQuantity = maxQuantity{
    quantityFocusNode.requestFocus();
  }

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
    if (quantityController.text == "0") {
      quantityError = "Quantity tidak boleh 0!";
    } else {
      quantityError = intValidator.validate(quantityController.text, fieldName: "Quantity");
    }

    if (quantityError != null){
      quantityFocusNode.requestFocus();
    }
    else if (currentQuantity! > _maxQuantity){
      quantityError = "Quantity melebihi current stock";
    }
    notifyListeners();

    return quantityError == null;
  }

  @override
  void dispose(){
    quantityController.dispose();
    keteranganController.dispose();
    quantityFocusNode.dispose();
    super.dispose();
  }
}