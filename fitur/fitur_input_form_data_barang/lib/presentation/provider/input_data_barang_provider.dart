import 'package:common/domain/model/barang.dart';
import 'package:common/domain/model/kategori.dart';
import 'package:common/domain/use_cases/empty_validation_use_case.dart';
import 'package:common/domain/use_cases/int_validation_use_case.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/fluttertoast.dart';
import 'package:fitur_input_form_data_barang/domain/model/submit_barang_dto.dart';
import 'package:fitur_input_form_data_barang/domain/repository/i_submit_barang_repository.dart';
import 'package:flutter/cupertino.dart';

class InputDataBarangProvider extends ChangeNotifier {
  final ISubmitBarangRepository _repository;
  final Barang? _initialData;
  bool get isEditing => _initialData != null;

  InputDataBarangProvider({
    required ISubmitBarangRepository repository,
    required Barang? initialData,
  }) :
      _repository = repository,
      _initialData = initialData,
      namaController = TextEditingController(
        text: initialData?.nama ?? ""
      ),
      _kategori = initialData?.kategori,
      kodeBarangController = TextEditingController(
        text: initialData?.kodeBarang.toString() ?? ""
      ),
      nomorRakController = TextEditingController(
        text: initialData?.nomorRak.toString() ?? ""
      ),
      nomorLaciController = TextEditingController(
        text: initialData?.nomorLaci.toString() ?? ""
      ),
      nomorKolomController = TextEditingController(
        text: initialData?.nomorKolom.toString() ?? ""
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
  final TextEditingController kodeBarangController;
  final TextEditingController nomorLaciController;
  final TextEditingController nomorKolomController;
  final TextEditingController minStockController;
  final TextEditingController stockSekarangController;
  final TextEditingController lastMonthStockController;
  final TextEditingController unitPriceController;
  final TextEditingController uomController;
  String amount;

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

  void Function()? get submit {
    // kalo lagi loading, maka jangan bolehin user ngetap
    if (submitResponse is ApiResponseLoading) {
      return null;
    }
    // bolehin user ngetap (ngegunain function _submit)
    return _submit;
  }

  void _submit() async {
    if (submitResponse is! ApiResponseLoading) {
      submitResponse = ApiResponseLoading();
      notifyListeners();

      final data = SubmitBarangDto(
        id: _initialData?.id,
        nama: namaController.text,
        kodeBarang: kodeBarangController.text,
        nomorRak: int.tryParse(nomorRakController.text),
        nomorKolom: int.tryParse(nomorKolomController.text),
        nomorLaci: int.tryParse(nomorLaciController.text),
        minStock: int.tryParse(minStockController.text),
        stockSekarang: int.tryParse(stockSekarangController.text),
        lastMonthStock: int.tryParse(lastMonthStockController.text),
        unitPrice: int.tryParse(unitPriceController.text),
        idKategori: kategori?.id,
        uom: uomController.text,
      );

      late ApiResponse nextResponse;

      nextResponse = await _repository.submitDataBarang(data);

      // parse semua error messagenya ke dalam error di textfield
      if (nextResponse is ApiResponseFailed) {
        if (nextResponse.error is String){
          Fluttertoast.showToast(msg: nextResponse.error , timeInSecForIosWeb: 3);
        }
        else {
          errorMessage = nextResponse.error;
        }
      }

      submitResponse = nextResponse;
      notifyListeners();
    }
  }


  @override
  void dispose() {
    namaController.dispose();
    kodeBarangController.dispose();
    nomorRakController.dispose();
    stockSekarangController.dispose();
    lastMonthStockController.dispose();
    unitPriceController.dispose();
    super.dispose();
  }
}