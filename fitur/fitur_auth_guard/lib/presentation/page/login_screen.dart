
import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/password_textfield.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:common/response/api_response.dart';
import 'package:common/routing/my_route_state_provider.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:flutter/material.dart';
import 'package:fitur_auth_guard/presentation/provider/login_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ChangeNotifierProvider(
          create: (context) => GetIt.I.get<LoginProvider>(),
          child: Consumer<LoginProvider>(
            builder: (context , provider , child) {
              final loginResponse = provider.loginResponse;
              if (loginResponse is ApiResponseSuccess<User>){
                final MyRouteStateProvider routeStateProvider = context.read();
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    routeStateProvider.onLogin(
                      loginResponse.data!,
                    );
                  }
                );
              }

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).phoneWidthPotraitPadding,
                ),
                child: Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 36
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const VerticalFormSpacing(),

                        CustomTextfield(
                          controller: provider.usernameC,
                          label: 'Username',
                          errorText: null,
                          textInputAction: TextInputAction.next,
                        ),

                        const VerticalFormSpacing(),

                        PasswordTextfield(
                          label: 'Password',
                          controller: provider.passwordC,
                          onSubmit: (_){
                            if (provider.login != null){
                              provider.login!();
                            }
                          }
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
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
