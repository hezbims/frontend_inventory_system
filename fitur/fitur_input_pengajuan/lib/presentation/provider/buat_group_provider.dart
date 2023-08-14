import 'package:common/domain/use_cases/empty_validation_use_case.dart';
import 'package:flutter/material.dart';

class BuatGroupProvider extends ChangeNotifier {
  final emptyValidator = EmptyValidationUseCase();

  final sectionController = TextEditingController();
  final groupController = TextEditingController();
  String? groupError;
  String? sectionError;

  void submit(){
    groupError = emptyValidator.validate(groupController.text, fieldName: "Group");
    sectionError = emptyValidator.validate(sectionController.text, fieldName: "Section");

    notifyListeners();
  }
}