import 'package:dependencies/get.dart';
import 'package:flutter/cupertino.dart';

class InputDataBarangController extends GetxController {
  final namaController = TextEditingController();
  final categoryController = TextEditingController();
  final nomorRakController = TextEditingController();
  final stockSekarangController = TextEditingController();
  final lastMonthStockController = TextEditingController();
  final unitPriceController = TextEditingController();
  String amount = "";

  String? namaError;
  String? categoryError;
  String? nomorRakError;
  String? stockSekarangError;
  String? lastMonthStockError;
  String? unitPriceError;

  void submit(){

  }

  @override
  void onClose() {
    namaController.dispose();
    categoryController.dispose();
    nomorRakController.dispose();
    stockSekarangController.dispose();
    lastMonthStockController.dispose();
    unitPriceController.dispose();
    super.onClose();
  }
}