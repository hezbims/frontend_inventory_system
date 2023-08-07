import 'package:dependencies/get.dart';
import 'package:fitur_input_data_barang/presentation/controller/input_data_barang_controller.dart';

class FiturInputDataBarangBinding extends Bindings {
  @override
  void dependencies(){
    Get.put(InputDataBarangController());
  }
}