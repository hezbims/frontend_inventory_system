import 'package:common/constant/url/env/i_env.dart';

class LocalEnv implements IEnv {
  @override
  String get serverHost => '127.0.0.1';

  @override
  String get serverPort => '8000';

  @override
  String get pusherAppKey => '0034c6855cd02144d9f7';

  @override
  String get websocketPort => '6001';


}