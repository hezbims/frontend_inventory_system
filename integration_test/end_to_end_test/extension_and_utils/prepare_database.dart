import 'package:flutter_test/flutter_test.dart';

import '../../../test/testing_api_client.dart';

Future<void> prepareDatabase() async {
  final testApiClient = TestingApiClient();
  final resetDatabaseResponse = await testApiClient.resetDatabase();
  expect(resetDatabaseResponse.statusCode, 200);

  final buatDuaUserResponse = await testApiClient.buatDuaUser();
  expect(buatDuaUserResponse.statusCode , 200);
}