import 'package:common/constant/url/env/i_env.dart';

class ReleaseEnv implements IEnv {
  @override
  // tag_python_script_ganti_current_ip
  String get serverHost => '10.83.35.71';

  @override
  // tag_python_script_ganti_dengan_laravel_port
  String get serverPort => '9999';

  @override
  String get pusherAppKey => '0034c6855cd02144d9f7';

  @override
  String get websocketPort => '6001';
}