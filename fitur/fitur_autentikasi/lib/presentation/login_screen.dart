import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:common/response/api_response.dart';
import 'package:common/routes/routes.dart';
import 'package:dependencies/provider.dart';
import 'package:flutter/material.dart';
import 'package:fitur_autentikasi/data/repository/auth_repository_impl.dart';
import 'package:fitur_autentikasi/presentation/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  final void Function(String) setCurrentSessionToken;
  const LoginScreen({
    super.key,
    required this.setCurrentSessionToken,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ChangeNotifierProvider(
          create: (context) => AuthProvider(
            repository: AuthRepositoryImpl(),
            setCurrentSessionToken : setCurrentSessionToken,
          ),
          child: Consumer<AuthProvider>(
            builder: (context , provider , child) {
              if (provider.loginResponse is ApiResponseSuccess<String>){
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    debugPrint('ngecoba ngepush initial route');
                    Navigator.of(context).pushReplacementNamed(Routes.initialRoute);
                  }
                );
              }
              return ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 372,
                  maxHeight: 332
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 36
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextfield(
                        controller: provider.usernameC,
                        label: 'Username',
                        errorText: null
                      ),

                      const VerticalFormSpacing(),

                      CustomTextfield(
                        controller: provider.passwordC,
                        label: 'Password',
                        errorText: null
                      ),

                      const VerticalFormSpacing(),

                      SizedBox(
                        width: double.infinity,
                        child: SubmitButton(
                          onTap: provider.login
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
