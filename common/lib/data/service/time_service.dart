import 'package:common/domain/service/i_time_service.dart';

class TimeService implements ITimeService {

  @override
  DateTime get now {
    return DateTime.now();
  }
}