

void main() {
  // final testApiClient = TestApiClient();
  //
  // test('Test struktur JSON Get Barang benar', () async {
  //   final resetDatabaseResponse = await testApiClient.resetDatabase();
  //   assert(resetDatabaseResponse.statusCode == 200);
  //
  //   final seedDatabaseResponse = await testApiClient.seedBarang();
  //   assert(seedDatabaseResponse.statusCode == 200);
  //
  //   final repository = BarangRepositoryImpl();
  //   for (int i = 1 ; true ; i++) {
  //     var getBarangResponse = await repository.getStockBarang(i, '');
  //     getBarangResponse = getBarangResponse as ApiResponseSuccess<List<Barang>>;
  //
  //     if (!getBarangResponse.isNextDataExist) {
  //       break;
  //     }
  //   }
  // } , tags: ['api_test']);
}