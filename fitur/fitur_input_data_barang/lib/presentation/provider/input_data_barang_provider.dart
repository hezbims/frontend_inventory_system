import 'package:common/domain/model/barang.dart';
import 'package:common/domain/use_cases/empty_validation_use_case.dart';
import 'package:common/domain/use_cases/int_validation_use_case.dart';
import 'package:common/response/api_response.dart';
import 'package:flutter/cupertino.dart';

class InputDataBarangProvider extends ChangeNotifier {
  InputDataBarangProvider({
    Barang? initialData,
  }) :
      namaController = TextEditingController(
        text: initialData?.nama ?? ""
      ),
      categoryController = TextEditingController(
        text: initialData?.category ?? ""
      ),
      nomorRakController = TextEditingController(
        text: initialData?.nomorRak ?? ""
      ),
      stockSekarangController = TextEditingController(
        text: initialData?.stockSekarang.toString() ?? ""
      ),
      lastMonthStockController = TextEditingController(
        text: initialData?.lastMonthStock.toString() ?? ""
      ),
      unitPriceController = TextEditingController(
        text: initialData?.unitPrice.toString() ?? ""
      ),
      amount =
        initialData != null ?
          (initialData.unitPrice * initialData.stockSekarang).toString() :
          "Invalid";

  final emptyValidator = EmptyValidationUseCase();
  final intValidator = IntValidationUseCase();

  final TextEditingController namaController;
  final TextEditingController categoryController;
  final TextEditingController nomorRakController;
  final TextEditingController stockSekarangController;
  final TextEditingController lastMonthStockController;
  final TextEditingController unitPriceController;
  String amount;

  String? namaError;
  String? categoryError;
  String? nomorRakError;
  String? stockSekarangError;
  String? lastMonthStockError;
  String? unitPriceError;

  void updateAmount(String _) async {
    final unitPrice = double.tryParse(unitPriceController.text);
    final stockSekarang = double.tryParse(stockSekarangController.text);
    if (unitPrice != null && stockSekarang != null){
      amount = (unitPrice * stockSekarang).toString();
    }
    else {
      amount = "Invalid";
    }
    notifyListeners();
  }

  ApiResponse? submitResponse;
  void submit() async {
    if (submitResponse is! ApiResponseLoading){
      namaError = emptyValidator.validate(namaController.text, fieldName: "Nama");
      categoryError = emptyValidator.validate(categoryController.text, fieldName: "Category");
      nomorRakError = emptyValidator.validate(nomorRakController.text, fieldName: "Nomor rak");
      stockSekarangError = intValidator.validate(stockSekarangController.text, fieldName: "Stock sekarang");
      lastMonthStockError = intValidator.validate(lastMonthStockController.text, fieldName: "Last month stock");
      unitPriceError = intValidator.validate(unitPriceController.text, fieldName: "Unit price");

      if (_noError){
        submitResponse = ApiResponseSuccess();
      }
      else {
        submitResponse = ApiResponseFailed();
      }
      notifyListeners();
    }
  }

  bool get _noError {
    return namaError == null &&
      categoryError == null &&
      nomorRakError == null &&
      stockSekarangError == null &&
      lastMonthStockError == null &&
      unitPriceError == null;
  }



  @override
  void dispose() {
    namaController.dispose();
    categoryController.dispose();
    nomorRakController.dispose();
    stockSekarangController.dispose();
    lastMonthStockController.dispose();
    unitPriceController.dispose();
    super.dispose();
  }
}