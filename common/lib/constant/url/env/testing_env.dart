import 'package:common/constant/url/env/i_env.dart';

class ReleaseEnv implements IEnv {
  @override
  // tag_python_script_ganti_current_ip
  String get serverHost => '192.168.186.100';

  @override
  String get serverPort => '9999';

  @override
  String get pusherAppKey => '0034c6855cd02144d9f7';

  @override
  String get websocketPort => '6001';
}