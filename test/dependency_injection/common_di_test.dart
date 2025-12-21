import 'package:common/data/service/time_service.dart';
import 'package:common/domain/service/i_time_service.dart';
import 'package:dependencies/get_it.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_system/dependency_injection/setup_main_dependency_injection.dart';

void main(){
  setUp((){
    setupMainDependencyInjection();
  });

  tearDown((){
    GetIt.I.reset();
  });

  test("Common dependency should registered correctly", (){
    final timeService = GetIt.I.get<ITimeService>();

    expect(timeService, isA<TimeService>());
  });
}