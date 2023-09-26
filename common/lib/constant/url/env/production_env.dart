import 'package:common/constant/url/env/i_env.dart';

class ProductionEnv extends IEnv {
  @override
  String get serverHost => '192.168.119.100';

  @override
  String get serverPort => '9999';

}