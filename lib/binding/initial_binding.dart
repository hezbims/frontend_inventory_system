import 'package:common/presentation/bottom_navbar/stock_bottom_navbar_controller.dart';
import 'package:dependencies/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StockBottomNavBarController());
  }

}