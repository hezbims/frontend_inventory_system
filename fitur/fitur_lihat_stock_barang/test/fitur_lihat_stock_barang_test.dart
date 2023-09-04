import 'package:common/data/repository/barang_repository_impl.dart';
import 'package:common/domain/model/barang.dart';
import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_lihat_stock_barang/presentation/page/lihat_stock_barang_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dependencies/mockito.dart';

import 'fitur_lihat_stock_barang_test.mocks.dart';
import 'test_database_api_client.dart';

@GenerateMocks([IBarangRepository])
void main() {
  final testApiClient = TestDatabaseApiClient();

  test('Test struktur JSON Get Barang benar', () async {
    final resetDatabaseResponse = await testApiClient.resetDatabase();
    assert(resetDatabaseResponse.statusCode == 200);

    final seedDatabaseResponse = await testApiClient.seedBarang();
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

  testWidgets(
    'Pencet refresh, tampilan barang terefresh',
    tags: ['fast_test'],
    (tester) async {
      final mockRepository = MockIBarangRepository();
      when(mockRepository.getStockBarang(1, '')).thenAnswer(
        (_) async =>
          Future.delayed(
            const Duration(milliseconds: 100),
            () => ApiResponseFailed(error: 'Gagal tersambung ke server')
          ),
      );
      GetIt.instance.registerSingleton<IBarangRepository>(mockRepository);

      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: LihatStockBarangPage()
          ),
        )
      );
      final loadingIndicator = find.byType(CircularProgressIndicator);
      expect(loadingIndicator, findsOneWidget);

      await tester.pumpAndSettle();
      final refreshButton = find.text('Refresh');

      expect(refreshButton, findsOneWidget);

      when(mockRepository.getStockBarang(1, '')).thenAnswer(
        (_) async => ApiResponseSuccess(
          data: []
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsNothing);
    }
  );
}
