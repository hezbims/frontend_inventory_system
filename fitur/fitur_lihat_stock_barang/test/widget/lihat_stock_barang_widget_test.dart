import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:mockito/annotations.dart';


@GenerateMocks([IBarangRepository])
void main(){
  // testWidgets(
  //     'Pencet refresh, tampilan barang terefresh',
  //     tags: 'fast_test',
  //         (tester) async {
  //       final mockRepository = MockIBarangRepository();
  //       when(mockRepository.getStockBarang(1, '')).thenAnswer(
  //             (_) async =>
  //             Future.delayed(
  //                 const Duration(milliseconds: 100),
  //                     () => ApiResponseFailed(error: 'Gagal tersambung ke server')
  //             ),
  //       );
  //       GetIt.instance.registerSingleton<IBarangRepository>(mockRepository);
  //
  //       await tester.pumpWidget(
  //           const MaterialApp(
  //             home: Directionality(
  //                 textDirection: TextDirection.ltr,
  //                 child: LihatStockBarangPage()
  //             ),
  //           )
  //       );
  //       final loadingIndicator = find.byType(CircularProgressIndicator);
  //       expect(loadingIndicator, findsOneWidget);
  //
  //       await tester.pumpAndSettle();
  //       final refreshButton = find.text('Refresh');
  //
  //       expect(refreshButton, findsOneWidget);
  //
  //       when(mockRepository.getStockBarang(1, '')).thenAnswer(
  //             (_) async => ApiResponseSuccess(
  //             data: []
  //         ),
  //       );
  //
  //       expect(find.byType(CircularProgressIndicator), findsNothing);
  //     }
  // );
}