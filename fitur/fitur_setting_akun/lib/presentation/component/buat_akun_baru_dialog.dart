import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/password_textfield.dart';
import 'package:dependencies/provider.dart';
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
          create: (context) => BuatAkunBaruProvider(),
          child: Consumer<BuatAkunBaruProvider>(
            builder: (context , provider , child) {
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
                  if (index == 0) {
                    return const SizedBox();
                  }
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
      Align(
        alignment: Alignment.topRight,
        child: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.highlight_remove)
        ),
      ),

      Align(
        alignment: Alignment.center,
        child: Text(
          "Buat Akun Baru",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      CustomTextfield(
        controller: provider.usernameController,
        label: 'Username',
        errorText: null
      ),

      PasswordTextfield(
        label: 'Password',
        controller: provider.passwordController,
        isPasswordVisible: provider.isPasswordVisible,
        onChangePasswordVisibility: provider.turnPasswordVisibility,
      ),

      PasswordTextfield(
        label: 'Konfirmasi Password',
        controller: provider.confirmPasswordController,
        isPasswordVisible: provider.isConfirmPasswordVisible,
        onChangePasswordVisibility: provider.turnConfirmPasswordVisibility,
      ),

      SizedBox(
        width: double.infinity,
        child: SubmitButton(
          onTap: (){

          }
        ),
      ),
    ];
  }
}
