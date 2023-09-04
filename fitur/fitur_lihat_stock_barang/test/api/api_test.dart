import 'package:common/data/repository/barang_repository_impl.dart';
import 'package:common/domain/model/barang.dart';
import 'package:common/response/api_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'database_api_client.dart';

void main() {
  final databaseApiClient = DatabaseApiClient();

  test(
    'Test struktur JSON Get Barang benar',
    tags: 'api_test',
    () async {
      final resetDatabaseResponse = await databaseApiClient.resetDatabase();
      assert(resetDatabaseResponse.statusCode == 200);

      final seedDatabaseResponse = await databaseApiClient.seedBarang();
      assert(seedDatabaseResponse.statusCode == 200);

      final repository = BarangRepositoryImpl();
      for (int i = 1 ; true ; i++) {
        var getBarangResponse = await repository.getStockBarang(i, '');
        getBarangResponse = getBarangResponse as ApiResponseSuccess<List<Barang>>;

        if (!getBarangResponse.isNextDataExist) {
          break;
        }
    }
  });


}
