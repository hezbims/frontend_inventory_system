import 'package:common/constant/test_tags/test_tags.dart';
import 'package:common/data/repository/token_manager.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:common/domain/repository/i_user_repository.dart';
import 'package:common/presentation/provider/user_provider.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/flutter_test.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/mockito.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_setting_akun/presentation/page/setting_akun_page.dart';
import 'package:flutter/material.dart';

import 'widget.mocks.dart';

@GenerateMocks([IUserRepository])
void main(){
  MockIUserRepository prepareMockUserRepository(){
    final mockUserRepository = MockIUserRepository();
    when(mockUserRepository.getUser()).thenAnswer(
      (realInvocation) async => ApiResponseSuccess(
        data: User(
            token: '',
            username: 'hezbi',
            isAdmin: true
        ),
      ),
    );
    return mockUserRepository;
  }

  void prepareTokenManager(){
    GetIt.I.registerSingleton<ITokenManager>(TokenManagerImpl());
  }

  testWidgets('''
    Ketika user adalah admin,
    maka tampilan buat akun akan keliatan,
  ''', (tester) async {
    final mockUserRepository = prepareMockUserRepository();
    prepareTokenManager();

    final userProvider = UserProvider(repository: mockUserRepository);

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: userProvider,
        child: MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: SettingAkunPage(),
          ),
        ),
      )
    );

    // harus di pump
    await tester.pump();
    final tambahAkunItem = find.text('Tambah akun baru');

    expect(tambahAkunItem, findsOneWidget);

  } , tags: TestTags.fast_test);
}