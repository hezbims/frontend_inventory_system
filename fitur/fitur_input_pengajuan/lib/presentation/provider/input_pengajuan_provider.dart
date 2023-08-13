
import 'package:common/domain/model/pengajuan.dart';
import 'package:common/domain/repository/i_stock_barang_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:common/utils/date_formatter.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:common/domain/model/group.dart';
import 'package:fitur_input_pengajuan/domain/use_case/get_filtered_barang_use_case.dart';
import 'package:flutter/material.dart';

class InputPengajuanProvider extends ChangeNotifier {
  final IStockBarangRepository _barangRepository;
  final _getFilteredBarangUseCase = GetFilteredBarangFromApiUseCase();

  InputPengajuanProvider({
    Pengajuan? initialData,
    required IStockBarangRepository barangRepository,
  })  :
    _barangRepository = barangRepository,
    tanggal = initialData == null ?
      DateTime.now() :
      IntlFormatter.stringToDateTime(initialData.tanggal),
    jam = initialData == null ?
        TimeOfDay.now() :
        IntlFormatter.stringToTimeOfDay(initialData.jam),
    tipePengajuanController = TextEditingController(text: initialData?.tipe ?? ""),
    namaController = TextEditingController(text: initialData?.nama ?? ""),
    _group = initialData?.group  {
    searchBarangController.addListener(notifyListeners);
  }

  DateTime tanggal;
  TimeOfDay jam;
  final TextEditingController tipePengajuanController;
  final TextEditingController namaController;
  Group? _group;
  Group? get group => _group;
  void onChangeGroup(Group newGroup) {
    _group = newGroup;
    notifyListeners();
  }

  List<BarangTransaksi> listBarangTransaksi = [];
  final searchBarangController = TextEditingController();

  String? tanggalError;
  String? jamError;
  String? tipePengajuanError;
  String? namaError;
  String? groupError;

  void onTanggalChange(DateTime newValue){
    tanggal = newValue;
    notifyListeners();
  }
  void onJamChange(TimeOfDay newValue){
    jam = newValue;
    notifyListeners();
  }
  void addNewBarang(BarangTransaksi newBarang) {
    listBarangTransaksi.add(newBarang);
    notifyListeners();
  }
  void deleteBarang(BarangTransaksi oldBarang) {
    listBarangTransaksi.remove(oldBarang);
    notifyListeners();
  }
  Future<ApiResponse>? _allBarangResponse;
  Future<ApiResponse> _getAllBarangResponse() {
    _allBarangResponse ??= _barangRepository.getAllStockBarang();
    return _allBarangResponse!;
  }
  void onRefreshStockBarang(){
    _allBarangResponse = _barangRepository.getAllStockBarang();
    notifyListeners();
  }

  Future<ApiResponse> get filteredBarangResponse =>
    _getFilteredBarangUseCase.get(
      future: _getAllBarangResponse(),
      keyword: searchBarangController.text
    );

  @override
  void dispose(){
    namaController.dispose();
    searchBarangController.dispose();
    super.dispose();
  }
}