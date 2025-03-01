// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.







// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   setUpAll((){
//     registerFallbackValue(FakePostLoginDto());
//   });
//
//   testWidgets(
//       'Ketika user login, maka user berhak mengakses data',
//           (tester) async {
//         const token = 'ini-token-rahasia ';
//         final mockApiClient = prepareMockApiClient(token: token);
//
//         final mockUserRepository = MockUserRepository();
//         when(() => mockUserRepository.getUser()).thenAnswer(
//           (invocation) async {
//             try {
//               final user = GetIt.I.get<User>();
//               return ApiResponseSuccess(data: user);
//             } catch (e) {
//               return ApiResponseFailed(statusCode: HttpStatus.unauthorized);
//             }
//           }
//         );
//         GetIt.I.registerSingleton(
//           UserProvider(repository: mockUserRepository)
//         );
//
//         final tokenManager = TokenManagerImpl();
//         GetIt.I.registerSingleton<ITokenManager>(tokenManager);
//         GetIt.I.registerFactory(() =>
//           LoginProvider(
//             repository: LoginRepositoryImpl(
//               apiClient: mockApiClient,
//               tokenManager: tokenManager,
//             )
//           )
//         );
//
//         final mockBarangRepository = MockBarangRepository();
//         when(() => mockBarangRepository.getStockBarang(any(), any()))
//           .thenAnswer((_) async {
//             final tokenizedHeader = await tokenManager.getLocalStorageTokenizedHeader();
//             if (tokenizedHeader['token'] == token){
//               return ApiResponseSuccess(data: []);
//             }
//             return ApiResponseFailed();
//           }
//         );
//         GetIt.I.registerFactory(() => LihatStockBarangProvider(
//           repository: mockBarangRepository
//         ));
//
//         await tester.pumpWidget(
//           const MyApp(),
//         );
//         await tester.pump();
//         await tester.tap(find.byType(SubmitButton));
//         await tester.pump();
//         expect(find.byType(DefaultErrorWidget) , findsNothing);
//
//       }
//   );
// }
//
// MockLoginApiClient prepareMockApiClient({required String token}){
//   final mockLoginApiClient = MockLoginApiClient();
//
//   final jsonBody = '''
//       {
//         "message": "Sukses",
//         "token": "$token",
//         "user": {
//             "id": 1,
//             "username": "admin",
//             "is_admin": 1,
//             "created_at": "2023-09-01T06:38:23.000000Z",
//             "updated_at": "2023-09-01T06:38:23.000000Z"
//         }
//       }
//     ''';
//
//   when(() => mockLoginApiClient.login(any())).thenAnswer(
//     (realInvocation) async{
//       return Response(jsonBody, 200);
//     },
//   );
//
//   return mockLoginApiClient;
// }