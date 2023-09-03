import 'package:common/constant/json_field/user_field.dart';
import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/password_textfield.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_setting_akun/data/repository/register_repository_impl.dart';
import 'package:fitur_setting_akun/presentation/provider/buat_akun_baru_provider.dart';
import 'package:flutter/material.dart';

class BuatAkunBaruDialog extends StatelessWidget {
  const BuatAkunBaruDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 372,
          maxHeight: 440,
        ),
        child: ChangeNotifierProvider(
          create: (context) => BuatAkunBaruProvider(
            repository: RegisterRepositoryImpl(),
          ),
          child: Consumer<BuatAkunBaruProvider>(
            builder: (context , provider , child) {
              // TODO : make sure ngepop kalo response sukses
              if (provider.registerResponse is ApiResponseSuccess){
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    Navigator.of(context).pop();
                  }
                );
              }
              final listItem = buildListItem(
                context: context,
                provider: provider
              );

              return ListView.separated(
                padding: EdgeInsets.only(
                  right: 24,
                  left: 24,
                  bottom: 36,
                  top: 12,
                ),
                itemBuilder: (BuildContext context , index) =>
                  listItem[index],
                separatorBuilder: (BuildContext context , index) {
                  return const SizedBox(height: 12,);
                },
                itemCount: listItem.length,
              );
            }
          ),
        ),
      ),
    );
  }

  List<Widget> buildListItem({
    required BuildContext context,
    required BuatAkunBaruProvider provider
  }){
    return [
      Row(
        children: [
          const SizedBox(width: 24,),

          Expanded(
            child: Text(
              "Buat Akun Baru",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.highlight_remove)
          ),
        ],
      ),
      

      CustomTextfield(
        controller: provider.usernameController,
        label: 'Username',
        errorText: provider.errorMap[UserField.username],
      ),

      PasswordTextfield(
        label: 'Password',
        controller: provider.passwordController,
        isPasswordVisible: provider.isPasswordVisible,
        onChangePasswordVisibility: provider.turnPasswordVisibility,
        errorText: provider.errorMap[UserField.password],
        textInputAction: TextInputAction.next,
      ),

      PasswordTextfield(
        label: 'Konfirmasi Password',
        controller: provider.confirmPasswordController,
        isPasswordVisible: provider.isConfirmPasswordVisible,
        onChangePasswordVisibility: provider.turnConfirmPasswordVisibility,
        onSubmit: (_){
          if (provider.register != null){
            provider.register!();
          }
        },
      ),

      SizedBox(
        width: double.infinity,
        child: SubmitButton(
          onTap: provider.register,
        ),
      ),
    ];
  }
}
