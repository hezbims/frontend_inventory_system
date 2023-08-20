import 'package:common/domain/model/barang.dart';
import 'package:common/domain/model/kategori.dart';
import 'package:common/domain/use_cases/empty_validation_use_case.dart';
import 'package:common/domain/use_cases/int_validation_use_case.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_input_data_barang/domain/model/submit_barang_dto.dart';
import 'package:fitur_input_data_barang/domain/repository/i_submit_barang_repository.dart';
import 'package:flutter/cupertino.dart';

class InputDataBarangProvider extends ChangeNotifier {
  final ISubmitBarangRepository _repository;
  final Barang? _initialData;
  InputDataBarangProvider({
    required ISubmitBarangRepository repository,
    Barang? initialData,
  }) :
      _repository = repository,
      _initialData = initialData,
      namaController = TextEditingController(
        text: initialData?.nama ?? ""
      ),
      _kategori = initialData?.kategori,
      nomorRakController = TextEditingController(
        text: initialData?.rak.nomorRak.toString() ?? ""
      ),
      nomorLaciController = TextEditingController(
        text: initialData?.rak.nomorLaci.toString() ?? ""
      ),
      nomorKolomController = TextEditingController(
        text: initialData?.rak.nomorKolom.toString() ?? ""
      ),
      minStockController = TextEditingController(
        text: initialData?.minStock.toString() ?? ""
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
          "Invalid",
      uomController = TextEditingController(
        text: initialData?.uom ?? "",
      );

  final emptyValidator = EmptyValidationUseCase();
  final intValidator = IntValidationUseCase();

  final TextEditingController namaController;
  Kategori? _kategori;
  Kategori? get kategori => _kategori;
  void onKategoriChange(Kategori? newValue){
    if (newValue != null && newValue.id != kategori?.id){
      _kategori = newValue;
      notifyListeners();
    }
  }

  final TextEditingController nomorRakController;
  final TextEditingController nomorLaciController;
  final TextEditingController nomorKolomController;
  final TextEditingController minStockController;
  final TextEditingController stockSekarangController;
  final TextEditingController lastMonthStockController;
  final TextEditingController unitPriceController;
  final TextEditingController uomController;
  String amount;

  // String? namaError;
  // String? kategoriError;
  // String? nomorRakError;
  // String? nomorLaciError;
  // String? nomorKolomError;
  // String? createRakError;
  // String? minStockError;
  // String? stockSekarangError;
  // String? lastMonthStockError;
  // String? unitPriceError;
  // String? uomError;
  Map<String , String?> errorMessage = {};

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
    if (submitResponse is! ApiResponseLoading) {
      submitResponse = ApiResponseLoading();
      notifyListeners();

      // namaError = emptyValidator.validate(namaController.text, fieldName: "Nama");
      // kategoriError = emptyValidator.validate(kategori?.nama ?? "", fieldName: "Category");
      // nomorRakError = emptyValidator.validate(nomorRakController.text, fieldName: "Nomor rak");
      // stockSekarangError = intValidator.validate(stockSekarangController.text, fieldName: "Stock sekarang");
      // lastMonthStockError = intValidator.validate(lastMonthStockController.text, fieldName: "Last month stock");
      // unitPriceError = intValidator.validate(unitPriceController.text, fieldName: "Unit price");
      // notifyListeners();

      final data = SubmitBarangDto(
        id: _initialData?.id.toString() ?? "",
        nama: namaController.text,
        nomorRak: nomorRakController.text,
        nomorKolom: nomorKolomController.text,
        nomorLaci: nomorLaciController.text,
        minStock: minStockController.text,
        stockSekarang: stockSekarangController.text,
        lastMonthStock: lastMonthStockController.text,
        unitPrice: unitPriceController.text,
        idKategori: kategori?.id.toString() ?? "",
        uom: uomController.text,
      );

      late ApiResponse nextResponse;

      // sedang editing, karena ada initial datanya
      if (_initialData != null) {
        nextResponse = await _repository.editBarang(data);
      }
      else {
        nextResponse = await _repository.addNewBarang(data);
      }

      // parse semua error messagenya ke dalam error di textfield
      if (nextResponse is ApiResponseFailed) {
        errorMessage = nextResponse.error;
      }

      submitResponse = nextResponse;
      notifyListeners();
    }
  }


  @override
  void dispose() {
    namaController.dispose();
    nomorRakController.dispose();
    stockSekarangController.dispose();
    lastMonthStockController.dispose();
    unitPriceController.dispose();
    super.dispose();
  }
}