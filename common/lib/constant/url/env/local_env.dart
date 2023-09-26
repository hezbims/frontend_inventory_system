import 'package:common/constant/url/env/i_env.dart';

class LocalEnv extends IEnv {
  @override
  String get serverHost => '127.0.0.1';

  @override
  String get serverPort => '8000';
}