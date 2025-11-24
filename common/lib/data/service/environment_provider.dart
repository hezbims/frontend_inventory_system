import 'package:common/domain/service/i_environment_provider.dart';
import 'package:dependencies/flutter_dotenv.dart';

class EnvironmentProvider implements IEnvironmentProvider {
  @override
  String get baseApiUrl {
    return dotenv.get("API_URL");
  }
}