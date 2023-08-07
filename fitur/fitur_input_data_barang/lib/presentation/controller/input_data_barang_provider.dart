import 'package:flutter/cupertino.dart';

class InputDataBarangProvider extends ChangeNotifier {
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